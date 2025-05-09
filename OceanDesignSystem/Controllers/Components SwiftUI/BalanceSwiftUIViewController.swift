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
                                                  actionCTA: "Receber",
                                                  acquires: ["acquirer-cielo", "acquirer-getnet", "acquirer-stone"],
                                                  displayMode: .amountMachines,
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
                                                   actionCTA: "Receber",
                                                   displayMode: .awaitPayment,
                                                   action: {
        print("Extrato")
    })

    private var model3 = OceanSwiftUI.BalanceModel(title: "Saldo total na Blu",
                                                   value: 1000000.0,
                                                   item1Title: "Saldo atual",
                                                   item1Value: 500000.0,
                                                   item2Title: "Agenda",
                                                   item2Value: 500000.0,
                                                   item3Value: 1000000.0,
                                                   description: "Saldo em outras maquininhas",
                                                   pendingTitle: "Suas vendas valem muito mais com  a Blu",
                                                   pendingValue: 1000000.0,
                                                   actionCTA: "Saiba mais",
                                                   displayMode: .knowMore,
                                                   action: {
        print("Extrato")
    })

    private var model4 = OceanSwiftUI.BalanceModel(title: "Saldo total na Blu",
                                                   value: 1000000.0,
                                                   item1Title: "Saldo atual",
                                                   item1Value: 500000.0,
                                                   item2Title: "Agenda",
                                                   item2Value: 500000.0,
                                                   item3Value: 1000000.0,
                                                   description: "Saldo em outras maquininhas",
                                                   pendingTitle: "Adicione saldo do seu jeito e economize mais!",
                                                   pendingValue: 1000000.0,
                                                   actionCTA: "Adicione saldo",
                                                   displayMode: .addBalance,
                                                   action: {
        print("Extrato")
    })

    private var model5 = OceanSwiftUI.BalanceModel(title: "Saldo total na Blu",
                                                  value: 1000000.0,
                                                  item1Title: "Saldo atual",
                                                  item1Value: 500000.0,
                                                  item2Title: "Agenda",
                                                  item2Value: 500000.0,
                                                  item3Value: 1000000.0,
                                                  description: "Saldo em outras maquininhas",
                                                  pendingTitle: "Aguardando recebimento",
                                                  pendingValue: 1000000.0,
                                                  actionCTA: "Receber",
                                                  acquires: ["acquirer-safra", "acquirer-mercado-pago", "acquirer-cielo", "acquirer-getnet", "acquirer-stone"],
                                                  displayMode: .amountMachines,
                                                  action: {
        print("Extrato")
    })

    lazy var balance1: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model
        }
    }()

    lazy var balance2: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model2
        }
    }()

    lazy var balance3: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model3
        }
    }()

    lazy var balance4: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model4
        }
    }()


    lazy var balance5: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.model = model5
        }
    }()

    lazy var acquirerInfinitePay = Image(uiImage: "acquirer-infinite-pay".toOceanIcon())
    lazy var acquirerMercadoPago = Image(uiImage: "acquirer_mercado_pago".toOceanIcon())
    lazy var acquirerPagBank = Image(uiImage: "AcquirerPagBank".toOceanIcon())
    lazy var acquirerPagarMe = Image(uiImage: "acquirer-pagar-me".toOceanIcon())

    lazy var toogleButton: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { button in
            button.parameters.text = "Toggle Scroll"
            button.parameters.onTouch = {
                if (self.balance1.parameters.state == .scroll &&
                    self.balance2.parameters.state == .scroll &&
                    self.balance3.parameters.state == .scroll &&
                    self.balance4.parameters.state == .scroll &&
                    self.balance5.parameters.state == .scroll) {
                    self.balance1.parameters.setStateWithAnimation(state: .collapsed)
                    self.balance2.parameters.setStateWithAnimation(state: .collapsed)
                    self.balance3.parameters.setStateWithAnimation(state: .collapsed)
                    self.balance4.parameters.setStateWithAnimation(state: .collapsed)
                    self.balance5.parameters.setStateWithAnimation(state: .collapsed)
                } else {
                    self.balance1.parameters.setStateWithAnimation(state: .scroll)
                    self.balance2.parameters.setStateWithAnimation(state: .scroll)
                    self.balance3.parameters.setStateWithAnimation(state: .scroll)
                    self.balance4.parameters.setStateWithAnimation(state: .scroll)
                    self.balance5.parameters.setStateWithAnimation(state: .scroll)
                }
            }
        }
    }()

    lazy var showBalance: OceanSwiftUI.Button = {
        OceanSwiftUI.Button.secondarySM { button in
            button.parameters.text = self.balance1.parameters.isVisibleBalance ? "Esconder Saldo" : "Mostrar Saldo"
            button.parameters.onTouch = {
                self.balance1.parameters.isVisibleBalance.toggle()
                self.balance2.parameters.isVisibleBalance.toggle()
                self.balance3.parameters.isVisibleBalance.toggle()
                self.balance4.parameters.isVisibleBalance.toggle()
                self.balance5.parameters.isVisibleBalance.toggle()
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            balance1

            balance5

            balance2

            balance3

            balance4
        }

        HStack {
            toogleButton
            showBalance
        }

        HStack(spacing: Ocean.size.spacingStackXxxs) {
            acquirerInfinitePay
            acquirerMercadoPago
            acquirerPagBank
            acquirerPagarMe
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
