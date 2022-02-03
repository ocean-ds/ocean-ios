//
//  RadioButtonViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 18/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class RadioButtonViewController : UIViewController {
    private var rb1: Ocean.RadioButton!
    private var rb2: Ocean.RadioButton!
    private var rb3: Ocean.RadioButton!
    private var rb4: Ocean.RadioButton!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        rb1 = Ocean.RadioButton { rb in
            rb.label = "Radio button 1"
            rb.onTouch = {
                self.rb2.isSelected = false
            }
        }
        rb2 = Ocean.RadioButton { rb in
            rb.label = "Radio button 2"
            rb.onTouch = {
                self.rb1.isSelected = false
            }
        }
        rb3 = Ocean.RadioButton { rb in
            rb.label = "Radio button 1 Disabled"
            rb.isSelected = true
            rb.isEnabled = false
        }
        rb4 = Ocean.RadioButton { rb in
            rb.label = "Radio button 2 Disabled"
            rb.isEnabled = false
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(rb1)
        stack.addArrangedSubview(rb2)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackSm))
        stack.addArrangedSubview(rb3)
        stack.addArrangedSubview(rb4)
        
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
