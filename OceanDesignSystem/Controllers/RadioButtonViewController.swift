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
    
    public override func viewDidLoad() {
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
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(rb1)
        stack.addArrangedSubview(rb2)
        
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
