//
//  TabSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 16/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens
import OceanComponents

class TabSwiftUIViewController: UIViewController {

    private static var badgeNumber: Int = 0

    lazy var tabContentView: any View = {
        ScrollView {
            VStack(alignment: .center) {
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Voltar para inicio"
                    button.parameters.onTouch = {
                        self.customTab.parameters.setSelectedIndex(0)
                    }
                }
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Alterar titulo da Aba 1"
                    button.parameters.onTouch = self.updateTab
                }
            }
            .padding()
        }
    }()

    lazy var customTab: OceanSwiftUI.Tab = {
        OceanSwiftUI.Tab { tab in
            tab.parameters.tabs = [
                .init(title: "Aba 1",
                      view: getTextview("Aba 1")),
                .init(title: "Aba 2",
                      view: getTextview("Aba 2")),
                .init(title: "Aba 3",
                      view: getTextview("Aba 3")),
                .init(title: "Aba 4",
                      view: getTextview("Aba 4")),
                .init(title: "Titulo Grande Titulo",
                      view: tabContentView,
                      badgeNumber: 10),
            ]
            tab.parameters.setSelectedIndex(4)
            tab.parameters.isScrollable = true
            tab.parameters.onTouch = tabSelected
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: customTab)

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }

    private func tabSelected(_ tab: Int) {
        print("QWERT: Tab selecionada: \(tab)")
    }

    private func updateTab() {
        TabSwiftUIViewController.badgeNumber += 1
        self.customTab.parameters.updateTab(
            tab: .init(title: "Atualizada",
                       view: getTextview("0000"),
                       badgeNumber: TabSwiftUIViewController.badgeNumber,
                       badgeStatus: .highlight),
            index: 1)
    }

    private func getTextview(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
            OceanSwiftUI.Typography.heading2 { label in
                label.parameters.text = text
            }

            OceanSwiftUI.Typography.description { label in
                label.parameters.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, \nwhen an unknown printer took a galley of type and scrambled it to make a type specimen book."
                label.parameters.multilineTextAlignment = .leading
            }
        }
        .padding(Ocean.size.spacingStackXs)
    }
}

@available(iOS 13.0, *)
struct TabSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TabSwiftUIViewController()
        }
    }
}
