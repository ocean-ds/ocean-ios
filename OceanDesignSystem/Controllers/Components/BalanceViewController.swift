//
//  BalanceViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 17/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class BalanceViewController : UIViewController {
    lazy var balance = Ocean.Balance()

    private lazy var scrollButton: Ocean.ButtonSecondary = {
        Ocean.Button.secondarySM { button in
            button.text = "Toggle Scroll"
            button.onTouch = {
                self.balance.setState(self.balance.state == .scroll ? .collapsed : .scroll)
            }
        }
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorBrandPrimaryPure

        let stack = Ocean.StackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackSm

        stack.addArrangedSubview(balance)
        stack.addArrangedSubview(scrollButton.alignCenter())
        self.view.addSubview(stack)

        stack.oceanConstraints
            .topToTop(to: self.view, constant: Ocean.size.spacingStackXs)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }

    public override func viewDidAppear(_ animated: Bool) {
        let model = [
            Ocean.BalanceModel(title: "Saldo total na Blu",
                               value: 100,
                               item1Title: "Saldo atual",
                               item1Value: 50,
                               item2Title: "Agenda",
                               item2Value: 50,
                               description: "Confira tudo o que entrou e saiu da sua Conta Digital Blu",
                               actionCTA: "Extrato",
                               action: {
                                   print("Extrato")
                               }),
            Ocean.BalanceModel(title: "Saldo em Outras maquininhas",
                               value: nil,
                               description: "Consulte o seu saldo para descobrir oportunidades",
                               actionCTA: "Consultar", action: {
                                   print("Consultar")
                               })
        ]

        balance.addBalances(with: model)
    }
}
