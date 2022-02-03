//
//  CheckBoxViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 12/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class CheckBoxViewController : UIViewController {
    private var ck1: Ocean.CheckBox!
    private var ck2: Ocean.CheckBox!
    private var ck3: Ocean.CheckBox!
    private var ck4: Ocean.CheckBox!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        ck1 = Ocean.CheckBox { ck in
            ck.label = "Check Box 1"
        }
        ck2 = Ocean.CheckBox { ck in
            ck.label = "Check Box 2"
        }
        ck3 = Ocean.CheckBox { ck in
            ck.label = "Check Box 1 Disabled"
            ck.isSelected = true
            ck.isEnabled = false
        }
        ck4 = Ocean.CheckBox { ck in
            ck.label = "Check Box 2 Disabled"
            ck.isEnabled = false
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(ck1)
        stack.addArrangedSubview(ck2)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackSm))
        stack.addArrangedSubview(ck3)
        stack.addArrangedSubview(ck4)
        
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
