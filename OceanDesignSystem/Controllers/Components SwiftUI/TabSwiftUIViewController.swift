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

    lazy var tabPayments: any View = {
        ScrollView {
            VStack(alignment: .center) {
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Ir para aba 1"
                    button.parameters.onTouch = {
                        self.tab.parameters.setSelectedIndex(1)
                    }
                }
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Mudar dados aba 1"
                    button.parameters.onTouch = self.updateTab
                }
            }
            .padding()
        }
        .background(Color(Ocean.color.colorInterfaceLightDown))
    }()

    lazy var tabReceipts: any View = {
        ScrollView {
            VStack(alignment: .center) {
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Ir para aba 0"
                    button.parameters.onTouch = {
                        self.tab.parameters.setSelectedIndex(0)
                    }
                }
                OceanSwiftUI.Button.primaryMD { button in
                    button.parameters.text = "Mudar dados aba 1"
                    button.parameters.onTouch = self.updateTab
                }
            }
            .padding()
        }
        .background(Color(Ocean.color.colorInterfaceLightDown))
    }()

    lazy var tab: OceanSwiftUI.Tab = {
        OceanSwiftUI.Tab { tab in
            tab.parameters.tabs = [
                .init(title: "Novo Titulo",
                      view: tabPayments,
                      badgeNumber: 10),
                .init(title: "Recebimentos",
                      view: tabReceipts)
            ]
            tab.parameters.setSelectedIndex(1)
            tab.parameters.onTouch = tabSelected
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: tab)

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
        self.tab.parameters.updateTab(
            tab: .init(title: "Recebimentos",
                       view: tabReceipts,
                       badgeNumber: TabSwiftUIViewController.badgeNumber,
                       badgeStatus: .highlight),
            index: 1)
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
