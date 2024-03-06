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
    lazy var button1: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Abrir"
            button.parameters.onTouch = {
                self.tooltip.parameters.position = .bottom
//                self.tooltip.parameters.show = true
            }
        }
    }()

    lazy var button2: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Abrir"
            button.parameters.onTouch = {
                self.tooltip.parameters.position = .top
//                self.tooltip.parameters.show = true
            }
        }
    }()

    var tooltip = OceanSwiftUI.Tooltip()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXxxl) {
            GeometryReader { g in
                if #available(iOS 14.0, *) {
                    self.button1
                        .help(Text("abc"))
                }
//                    .onTapGesture {
//                        print(g.frame(in: .named(UUID())).minY)
//                    }

                self.button2
//                    .onTapGesture {
//                        print(g.frame(in: .named(UUID())).minY)
//                    }
            }
        }
        .tooltip(tooltip)
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
