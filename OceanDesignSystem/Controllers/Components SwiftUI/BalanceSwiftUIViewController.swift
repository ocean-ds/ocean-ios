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

    lazy var balance: OceanSwiftUI.Balance = {
        OceanSwiftUI.Balance { balance in
            balance.parameters.title = "Saldo total na Blu"
            balance.parameters.value = 10.00
            balance.parameters.item1Title = "Saldo atual"
            balance.parameters.item1Value = 10.00
            balance.parameters.item2Title = "Agenda"
            balance.parameters.item2Value = 10.00
            balance.parameters.description = "Confira tudo o que entrou e saiu da sua Conta Digital Blu Confira tudo o que entrou e saiu da sua Conta Digital Blu"
            balance.parameters.actionCTA = "Extrato"
            balance.parameters.actionCTACollapsed = ""
            balance.parameters.action = {}
            balance.parameters.cellType = .withValue
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: VStack(spacing: Ocean.size.spacingStackXs) {
        balance
    })


    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }

    @objc
    private func close() {
        self.dismiss(animated: true, completion: nil)
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

