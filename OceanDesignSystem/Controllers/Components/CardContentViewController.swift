//
//  CardContentViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 08/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class CardContentViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightUp
        
        let spacer1 = UIView()
        spacer1.translatesAutoresizingMaskIntoConstraints = false
        spacer1.widthAnchor.constraint(equalToConstant: 220).isActive = true
        spacer1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let spacer2 = UIView()
        spacer2.translatesAutoresizingMaskIntoConstraints = false
        spacer2.widthAnchor.constraint(equalToConstant: 220).isActive = true
        spacer2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let spacer3 = UIView()
        spacer3.translatesAutoresizingMaskIntoConstraints = false
        spacer3.widthAnchor.constraint(equalToConstant: 220).isActive = true
        spacer3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(Ocean.CardContent { view in
            view.image = Ocean.icon.cloudOutline
            view.title = "Title"
            view.badgeStatus = .alert
            view.badgeNumber = 5
            view.actionTitle = "Call to action"
            view.view = spacer1
            view.onTouch = { print("1") }
        })
        stack.addArrangedSubview(Ocean.CardContent { view in
            view.title = "Title"
            view.badgeStatus = .highlight
            view.badgeNumber = 8
            view.actionTitle = "Call to action"
            view.view = spacer2
            view.onTouch = { print("2") }
        })
        stack.addArrangedSubview(Ocean.CardContent { view in
            view.title = "Title"
            view.view = spacer3
            view.onTouch = { print("3") }
        })
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
