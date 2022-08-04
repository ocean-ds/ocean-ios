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

        let transactionItem1: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Desconto à vista"
            item.subtitleTextLabel = .init(value: "R$ 10,00",
                                           imageIcon: Ocean.icon.tagSolid,
                                           color: Ocean.color.colorStatusPositiveDeep)
            return item
        }()

        let transactionItem2: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Taxa do fornecedor"
            item.subtitleTextLabel = .init(value: "R$ 8,00",
                                           color: Ocean.color.colorInterfaceDarkDown)
            return item
        }()

        let transactionItem3: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Taxa de antecipação"
            item.subtitleTextLabel = .init(value: "R$ 10,00",
                                           color: Ocean.color.colorInterfaceDarkDown)
            return item
        }()

        let transactionItem4: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Taxa de antecipação"
            item.subtitleTextLabel = .init(value: "R$ 40,00",
                                           newValue: "Zero",
                                           color: Ocean.color.colorStatusPositiveDeep)
            return item
        }()

        let transactionItem5: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Taxa de antecipação"
            item.subtitleTextLabel = .init(value: "Zero",
                                           color: Ocean.color.colorStatusPositiveDeep)
            return item
        }()

        let transactionItem6: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Taxa de antecipação"
            item.subtitleTextLabel = .init(value: "Calculada no dia",
                                           color: Ocean.color.colorStatusNeutralDeep)
            return item
        }()

        let transactionItem7: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Desconto Blu"
            item.tooltipMessage = "Tooltip Message"
            item.subtitleTextLabel = .init(value: "R$ 10,00",
                                           imageIcon: Ocean.icon.giftSolid,
                                           color: Ocean.color.colorStatusPositiveDeep)
            return item
        }()

        let transactionItem8: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Desconto Blu"
            item.tooltipMessage = "Tooltip Message"
            item.subtitleTextLabel = .init(value: "Não disponível",
                                           color: Ocean.color.colorInterfaceDarkUp)
            return item
        }()

        let transactionItem9: Ocean.TransactionItemModel = {
            var item = Ocean.TransactionItemModel()
            item.title = "Pague"
            item.subtitleTextLabel = .init(value: "R$ 1.000,00",
                                           bold: true,
                                           color: Ocean.color.colorInterfaceDarkPure)
            return item
        }()

        let footerTransactions: Ocean.TransactionFooterView = {
            let footer = Ocean.TransactionFooterView()
            footer.transactionsItems = [transactionItem1,
                                        transactionItem2,
//                                        transactionItem3,
//                                        transactionItem4,
//                                        transactionItem5,
//                                        transactionItem6,
//                                        transactionItem7,
//                                        transactionItem8,
//                                        transactionItem9
            ]
            footer.buttonTitle = "Avançar"
            return footer
        }()

        add(view: footerTransactions)
    }

    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
