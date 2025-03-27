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
                                                  value: 1000000.0,
                                                  item1Title: "Saldo atual",
                                                  item1Value: 500000.0,
                                                  item2Title: "Agenda",
                                                  item2Value: 500000.0,
                                                  item3Value: 1000000.0,
                                                  description: "Saldo em outras maquininhas",
                                                  pendingTitle: "Aguardando recebimento",
                                                  pendingValue: 1000000.0,
                                                  actionCTA: "Extrato",
                                                  actionCTA2: "Receber",
                                                  showAmountMachines: true,
                                                  action: {
        print("Extrato")
    })

    private var model2 = OceanSwiftUI.BalanceModel(title: "Saldo total na Blu",
                                                  value: 1000000.0,
                                                  item1Title: "Saldo atual",
                                                  item1Value: 500000.0,
                                                  item2Title: "Agenda",
                                                  item2Value: 500000.0,
                                                  item3Value: 1000000.0,
                                                  description: "Saldo em outras maquininhas",
                                                  pendingTitle: "Aguardando recebimento",
                                                  pendingValue: 1000000.0,
                                                  actionCTA: "Extrato",
                                                  actionCTA2: "Receber ",
                                                  showAmountMachines: false,
                                                  action: {
        print("Extrato")
    })

    lazy var balance: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model
        }
    }()

    lazy var balance2: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model2
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

    lazy var showBalance: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { button in
            button.parameters.text = self.balance.parameters.isVisibleBalance ? "Esconder Saldo" : "Mostrar Saldo"
            button.parameters.onTouch = {
                self.balance.parameters.isVisibleBalance.toggle()
                self.balance2.parameters.isVisibleBalance.toggle()
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackMd) {
            balance

            balance2

            toogleButton

            showBalance
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

