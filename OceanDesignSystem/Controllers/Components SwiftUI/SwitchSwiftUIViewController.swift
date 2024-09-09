//
//  SwitchSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 27/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class SwitchSwiftUIViewController: UIViewController {
    private lazy var switchView: OceanSwiftUI.Switch = {
        OceanSwiftUI.Switch { view in
            view.parameters.onValueChanged = { value in
                self.stateLabel.parameters.text = value.description
            }
        }
    }()
    
    private lazy var stateLabel: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.description { label in
            label.parameters.text = "false"
        }
    }()
    
    private lazy var switchSkeltonView: OceanSwiftUI.Switch = {
        OceanSwiftUI.Switch { view in
            view.parameters.showSkeleton = true
        }
    }()

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
            switchView
            
            stateLabel
            
            switchSkeltonView
        }
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct SwitchSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SwitchSwiftUIViewController()
        }
    }
}
