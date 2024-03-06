//
//  TooltipSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 05/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TooltipSwiftUIViewController: UIViewController {
    lazy var tooltip: OceanSwiftUI.Tooltip = {
        OceanSwiftUI.Tooltip { tooltip in
            tooltip.parameters.text = "Tooltip Text"
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            tooltip
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct TooltipSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TooltipSwiftUIViewController()
        }
    }
}
