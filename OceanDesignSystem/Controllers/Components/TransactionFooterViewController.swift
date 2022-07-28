//
//  TransactionFooterViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Vilas Boas on 26/07/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TransactionFooterViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0

        let transactionItem1: Ocean.TransactionFooterItemView = {
            let item = Ocean.TransactionFooterItemView()
            item.title = "Title"
            item.subtitleTextLabel = .init(value: "Subtatile")

            return item
        }()

        let transactionItem2: Ocean.TransactionFooterItemView = {
            let item = Ocean.TransactionFooterItemView()
            item.title = "Title"
            item.subtitleTextLabel = .init(value: "R$ 40,00", newValue: "Zero")

            return item
        }()

        let transactionItem3: Ocean.TransactionFooterItemView = {
            let item = Ocean.TransactionFooterItemView()
            item.title = "Title"
            item.tooltipMessage = "Tooltip"
            item.subtitleTextLabel = .init(value: "Subtatile")

            return item
        }()

        let footerTransactions: Ocean.TransactionFooterView = {
            let footer = Ocean.TransactionFooterView()
            footer.transactionsItens = [transactionItem1,
                                        transactionItem2,
                                        transactionItem3]
            footer.buttonTitle = "Avançar"
            return footer
        }()

        add(view: footerTransactions)
    }

    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

