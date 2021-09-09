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
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 0
        
        let transactionListItem1 = Ocean.TransactionListItem { view in
            view.level1 = "Transferência recebida"
            view.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.level3 = "Lente de contato Mônica"
            view.level4 = "Lojista 2"
            view.valueStatus = .positive
            view.value = 2000
            view.tagStatus = .warning
            view.tagImage = Ocean.icon.exclamationCircleSolid
            view.tagTitle = "Pendente"
            view.date = "09:00"
            view.onTouch = { print("1") }
        }
        
        let transactionListItem2 = Ocean.TransactionListItem { view in
            view.level1 = "Boleto pago"
            view.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.level3 = "Lente de contato Mônica"
            view.valueStatus = .negative
            view.value = 1546.90
            view.tagStatus = .warning
            view.tagImage = Ocean.icon.exclamationCircleSolid
            view.tagTitle = "Pendente"
            view.date = "19:00"
            view.onTouch = { print("2") }
        }
        
        let transactionListItem3 = Ocean.TransactionListItem { view in
            view.level1 = "Transferência recebida"
            view.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.valueStatus = .positive
            view.value = 500
            view.tagStatus = .warning
            view.tagImage = Ocean.icon.exclamationCircleSolid
            view.tagTitle = "Pendente"
            view.date = "12:00"
            view.onTouch = { print("3") }
        }
        
        let transactionListItem4 = Ocean.TransactionListItem { view in
            view.level1 = "Transferência enviada"
            view.level2 = "Digilab Laboratório Óptico Digital Ltda"
            view.valueStatus = .negative
            view.value = 200
            view.tagStatus = .warning
            view.tagImage = Ocean.icon.exclamationCircleSolid
            view.tagTitle = "Pendente"
            view.onTouch = { print("4") }
        }
        
        let transactionListItem5 = Ocean.TransactionListItem { view in
            view.level1 = "Antecipação de recebíveis"
            view.valueStatus = .neutral
            view.value = 800
            view.date = "13:00"
            view.onTouch = { print("5") }
        }
        
        stack.addArrangedSubview(transactionListItem1)
        stack.addArrangedSubview(transactionListItem2)
        stack.addArrangedSubview(transactionListItem3)
        stack.addArrangedSubview(transactionListItem4)
        stack.addArrangedSubview(transactionListItem5)
        
        self.add(view: stack)
        
        transactionListItem1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem2.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem3.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem4.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        transactionListItem5.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
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
