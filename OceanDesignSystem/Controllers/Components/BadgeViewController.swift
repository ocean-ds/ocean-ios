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
    let badgeTiny = Ocean.Badge.tiny()
    let badgeNumber1 = Ocean.Badge.number { view in
        view.status = .primary
        view.number = 99
    }
    let badgeNumber2 = Ocean.Badge.number { view in
        view.status = .primaryInverted
        view.number = 100
    }
    let badgeNumber3 = Ocean.Badge.number { view in
        view.status = .warning
        view.number = 10
    }
    let badgeNumber4 = Ocean.Badge.number { view in
        view.status = .highlight
        view.size = .small
        view.number = 5
    }
    let badgeNumber5 = Ocean.Badge.number { view in
        view.status = .neutral
        view.size = .small
        view.number = 10
    }
    
    let badgeNumber6 = Ocean.Badge.number { view in
        view.status = .chipSelected
        view.number = 9
    }
    
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightUp
        
        let stack = Ocean.StackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(badgeTiny)
        stack.addArrangedSubview(badgeNumber1)
        stack.addArrangedSubview(badgeNumber2)
        stack.addArrangedSubview(badgeNumber3)
        stack.addArrangedSubview(badgeNumber4)
        stack.addArrangedSubview(badgeNumber5)
        stack.addArrangedSubview(badgeNumber6)
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
