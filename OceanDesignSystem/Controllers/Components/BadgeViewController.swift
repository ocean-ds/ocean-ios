//
//  BadgeViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 03/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class BadgeViewController : UIViewController {
    let badgeText = Ocean.Badge.text()
    let badgeTiny = Ocean.Badge.tiny()
    let badgeNumber1 = Ocean.Badge.number { view in
        view.status = .primary
        view.number = 99
    }
    let badgeNumber2 = Ocean.Badge.number { view in
        view.status = .complementary
        view.number = 100
    }
    let badgeNumber3 = Ocean.Badge.number { view in
        view.status = .highlight
        view.number = 10
    }
    let badgeNumber4 = Ocean.Badge.number { view in
        view.status = .alert
        view.size = .small
        view.number = 5
    }
    let badgeNumber5 = Ocean.Badge.number { view in
        view.status = .neutral
        view.size = .small
        view.number = 10
    }
    
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightUp
        
        let stack = Ocean.StackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(badgeText)
        stack.addArrangedSubview(badgeTiny)
        stack.addArrangedSubview(badgeNumber1)
        stack.addArrangedSubview(badgeNumber2)
        stack.addArrangedSubview(badgeNumber3)
        stack.addArrangedSubview(badgeNumber4)
        stack.addArrangedSubview(badgeNumber5)
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
