//
//  TransactionListViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 07/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TransactionListViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0
        stack.isSkeletonable = true
        
        let transactionListItem1 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Transferência recebida",
                                                         level2: "Digilab Laboratório Óptico Digital Ltda",
                                                         level3: "Lente de contato Mônica",
                                                         level4: "Lojista 2",
                                                         value: 250000,
                                                         valueStatus: .positive,
                                                         date: "09:00",
                                                         tagTitle: "Pago",
                                                         tagStatus: .positive,
//                                                         tagImageStatus: true,
                                                         withDivider: true)
            view.onTouch = {
                print("1")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }
        
        let transactionListItem2 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Boleto pago",
                                                         level2: "Digilab Laboratório Óptico Digital Ltda",
                                                         level3: "Lente de contato Mônica",
                                                         value: 1546.90,
                                                         valueStatus: .negative,
                                                         date: "19:00",
                                                         tagTitle: "Pendente",
                                                         tagStatus: .warning,
//                                                         tagImageStatus: true,
                                                         withDivider: true)
            view.onTouch = {
                print("2")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }
        
        let transactionListItem3 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Transferência recebida",
                                                         level2: "Digilab Laboratório Óptico Digital Ltda",
                                                         value: 500,
                                                         valueStatus: .positive,
                                                         date: "12:00",
                                                         tagTitle: "Cancelado",
                                                         tagStatus: .negative,
//                                                         tagImageStatus: true,
                                                         withDivider: true)
            view.onTouch = {
                print("3")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }
        
        let transactionListItem4 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Transferência enviada",
                                                         level2: "Digilab Laboratório Óptico Digital Ltda",
                                                         value: 200,
                                                         valueStatus: .negative,
                                                         tagTitle: "Pendente",
                                                         tagImage: Ocean.icon.documentAddSolid,
                                                         tagStatus: .warning,
                                                         withDivider: true)
            view.onTouch = {
                print("4")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }
        
        let transactionListItem5 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Antecipação de recebíveis",
                                                         value: 800,
                                                         valueStatus: .neutral,
                                                         date: "13:00",
                                                         withDivider: true)
            view.onTouch = {
                print("5")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }

        let transactionListItem6 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Maskel Indústria e Comércio de Colchões da Silva Sauro Industrial",
                                                         value: 15000,
                                                         valueStatus: .neutral,
                                                         date: "Agendado 24 Jun 2021",
                                                         withDivider: true)
            view.onTouch = {
                print("5")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }

        let transactionListItem7 = Ocean.TransactionListItem { view in
            view.model = Ocean.TransactionListItem.Model(level1: "Amex",
                                                         level2: "Rede",
                                                         value: 15000,
                                                         valueStatus: .positive,
                                                         valueLevel2: 1490,
                                                         date: "Confirmado às 14:00",
                                                         withDivider: true)
            view.onTouch = {
                print("5")
                view.hasCheckbox = !view.hasCheckbox
            }
            view.setSkeleton()
        }
        
        stack.addArrangedSubview(transactionListItem1)
        stack.addArrangedSubview(transactionListItem2)
        stack.addArrangedSubview(transactionListItem3)
        stack.addArrangedSubview(transactionListItem4)
        stack.addArrangedSubview(transactionListItem5)
        stack.addArrangedSubview(transactionListItem6)
        stack.addArrangedSubview(transactionListItem7)
        
        self.add(view: stack)
        
        transactionListItem1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem2.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem3.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem4.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem5.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem6.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem7.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
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
