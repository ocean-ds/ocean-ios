//
//  BalanceSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 12/04/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class BalanceSwiftUIViewController: UIViewController {

    private var model = OceanSwiftUI.BalanceModel(title: "Saldo total na Blu",
                                                  value: 100,
                                                  item1Title: "Saldo atual",
                                                  item1Value: 50,
                                                  item2Title: "Agenda",
                                                  item2Value: 50,
                                                  description: "Saldo em outras maquininhas",
                                                  actionCTA: "Extrato",
                                                  action: {
        print("Extrato")
    })

    lazy var balance: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model
        }
    }()

    lazy var toogleButton: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { button in
            button.parameters.text = "Toggle Scroll"
            button.parameters.onTouch = {
                if self.balance.parameters.state == .scroll {
                    self.balance.parameters.state = .collapsed
                } else {
                    self.balance.parameters.state = .scroll
                }
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackMd) {
            balance

            toogleButton
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .topToTop(to: self.view, constant: Ocean.size.spacingStackXs)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .bottomToBottom(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct BalanceSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            BalanceSwiftUIViewController()
        }
    }
}

