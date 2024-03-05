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
    lazy var tooltip1: OceanSwiftUI.Tooltip = {
        OceanSwiftUI.Tooltip { tooltip in
            tooltip.parameters.text = "Lorem ipsum dolor sit amet."
        }
    }()

    lazy var button1: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Abrir"
            button.parameters.onTouch = {
                self.tooltip1.parameters.show = true
            }
        }
    }()

    lazy var tooltip2: OceanSwiftUI.Tooltip = {
        OceanSwiftUI.Tooltip { tooltip in
            tooltip.parameters.text = "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet."
            tooltip.parameters.size = .large
            tooltip.parameters.position = .top
        }
    }()

    lazy var button2: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Abrir"
            button.parameters.onTouch = {
                self.tooltip2.parameters.show = true
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXxxl) {
            button1
                .tooltip(tooltip1)
            
            button2
                .tooltip(tooltip2)
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
