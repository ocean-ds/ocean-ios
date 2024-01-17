//
//  SubheaderSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 17/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class SubheaderSwiftUIViewController: UIViewController {

    lazy var subheader1 = OceanSwiftUI.Subheader { subheader in
        subheader.parameters.icon = Ocean.icon.annotationSolid
        subheader.parameters.title = "Title"
        subheader.parameters.subtitle = "Subtitle"
    }

    lazy var subheader2 = OceanSwiftUI.Subheader { subheader in
        subheader.parameters.title = "Title"
        subheader.parameters.subtitle = "Subtitle"
    }

    lazy var subheader3 = OceanSwiftUI.Subheader { subheader in
        subheader.parameters.title = "Title"
        subheader.parameters.size = .small
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            subheader1
            subheader2
            subheader3
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }

    private func showSnackbar(text: String) {
        let snackbar = Ocean.View.snackbarInfo { view in
            view.line = .one
            view.snackbarText = text
        }
        snackbar.show(in: self.view)
    }
}

