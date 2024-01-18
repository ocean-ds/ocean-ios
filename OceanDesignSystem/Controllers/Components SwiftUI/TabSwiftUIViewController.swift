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

    lazy var tabPayments: any View = {
        VStack {
            Spacer()
            OceanSwiftUI.Typography.heading1 { view in
                view.parameters.text = "Pagamentos"
            }
        }
    }()

    lazy var tabReceipts: any View = {
        VStack {
            Spacer()
            OceanSwiftUI.Typography.heading1 { view in
                view.parameters.text = "Recebimentos"
            }
        }
    }()

    var tab: OceanSwiftUI.TabBar {
        OceanSwiftUI.TabBar { tab in
            tab.parameters.tabs = [
                .init(title: "Pagamentos", view: tabPayments, isSelected: true, badgeNumber: 10),
                .init(title: "Recebimentos", view: tabReceipts, isSelected: false)
            ]
            tab.parameters.onTouch = tabSelected
        }
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            tab
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

    private func tabSelected(_ tab: Int) {
        print("Tab selecionada: \(tab)")
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
