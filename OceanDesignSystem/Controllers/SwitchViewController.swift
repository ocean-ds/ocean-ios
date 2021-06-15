//
//  SwitchViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 10/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class SwitchViewController : UIViewController {
    private var oceanSwitch: Ocean.Switch!
    private var label: UILabel!
    
    public override func viewDidLoad() {
        oceanSwitch = Ocean.Switch { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            component.isOn = true
            component.onValueChanged = { value in
                self.label.text = value.description
            }
        }
        label = Ocean.Typography.description { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = self.oceanSwitch.isOn.description
        }
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        
        stack.addArrangedSubview(oceanSwitch)
        stack.addArrangedSubview(label)
        
        self.add(view: stack)
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
