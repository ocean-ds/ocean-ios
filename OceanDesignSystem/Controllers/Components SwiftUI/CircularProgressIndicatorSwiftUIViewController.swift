//
//  CircularProgressIndicatorSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

class CircularProgressIndicatorSwiftUIViewController: UIViewController {
    lazy var progress1: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .small
        }
    }()

    lazy var progress2: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .medium
        }
    }()

    lazy var progress3: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .large
        }
    }()

    lazy var progress4: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .small
        }
    }()

    lazy var progress5: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .medium
        }
    }()

    lazy var progress6: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .large
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            progress1
            progress2
            progress3
            progress4
            progress5
            progress6
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceDarkUp

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct CircularProgressIndicatorSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CircularProgressIndicatorSwiftUIViewController()
        }
    }
}
