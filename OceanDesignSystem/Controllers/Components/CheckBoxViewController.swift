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
    private var ck5: Ocean.CheckBox!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        ck1 = Ocean.CheckBox { ck in
            ck.label = "Check Box 1"
        }
        ck2 = Ocean.CheckBox { ck in
            ck.label = "Check Box 2 with large text and many words. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        }
        ck3 = Ocean.CheckBox { ck in
            ck.label = "Check Box 3 Error"
            ck.errorMessage = "Mensagem de erro"
        }
        ck4 = Ocean.CheckBox { ck in
            ck.label = "Check Box 1 Disabled"
            ck.isSelected = true
            ck.isEnabled = false
        }
        ck5 = Ocean.CheckBox { ck in
            ck.label = "Check Box 2 Disabled"
            ck.isEnabled = false
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(ck1)
        stack.addArrangedSubview(ck2)
        stack.addArrangedSubview(ck3)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackSm))
        stack.addArrangedSubview(ck4)
        stack.addArrangedSubview(ck5)
        
        self.view.addSubview(stack)

        stack.oceanConstraints
            .topToTop(to: view, constant: 16)
            .leadingToLeading(to: view, constant: 16)
            .trailingToTrailing(to: view, constant: -16)
            .make()
    }
}
