//
//  BalanceViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 31/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class BalanceViewController : UIViewController {
    let balance = Ocean.Balance { view in
        view.balanceAvailable = 69762.60
        view.currentBalance = 68762.60
        view.scheduleBlu = 1000.00
        view.scheduleNotBlu = 0
        view.scheduleNotBluHidden = false
        view.onStateChanged = { state in
            print(state)
        }
    }
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0
        
        stack.addArrangedSubview(balance)
        
        self.add(view: stack)
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            balance.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
