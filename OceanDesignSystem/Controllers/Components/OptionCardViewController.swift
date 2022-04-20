//
//  OptionCardViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 23/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class OptionCardViewController : UIViewController {
    var oc1: Ocean.OptionCard!
    var oc2: Ocean.OptionCard!
    var oc3: Ocean.OptionCard!
    var oc4: Ocean.OptionCard!
    var oc5: Ocean.OptionCard!
    var oc6: Ocean.OptionCard!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        oc1 = Ocean.OptionCard { option in
            option.title = "Title"
            option.subtitle = "Subtitle"
            option.image = Ocean.icon.documentOutline
            option.isEnabled = false
            option.onTouch = {
                self.oc2.isSelected = false
                self.oc3.isSelected = false
                self.oc4.isSelected = false
                self.oc5.isSelected = false
                self.oc6.isSelected = false
                print(1)
            }
            option.onTouchDisabled = {
                print(1)
            }
        }
        oc2 = Ocean.OptionCard { option in
            option.title = "Title"
            option.subtitle = "Subtitle"
            option.image = Ocean.icon.documentOutline
            option.isRecommend = true
            option.onTouch = {
                self.oc1.isSelected = false
                self.oc3.isSelected = false
                self.oc4.isSelected = false
                self.oc5.isSelected = false
                self.oc6.isSelected = false
                print(2)
            }
        }
        oc3 = Ocean.OptionCard { option in
            option.title = "Title"
            option.subtitle = "Subtitle"
            option.image = Ocean.icon.documentOutline
            option.isError = true
            option.onTouch = {
                self.oc1.isSelected = false
                self.oc2.isSelected = false
                self.oc4.isSelected = false
                self.oc5.isSelected = false
                self.oc6.isSelected = false
                print(3)
            }
        }
        oc4 = Ocean.OptionCard { option in
            option.title = "Title"
            option.image = Ocean.icon.documentOutline
            option.isEnabled = false
            option.onTouch = {
                self.oc1.isSelected = false
                self.oc2.isSelected = false
                self.oc3.isSelected = false
                self.oc5.isSelected = false
                self.oc6.isSelected = false
                print(4)
            }
            option.onTouchDisabled = {
                print(4)
            }
        }
        oc5 = Ocean.OptionCard { option in
            option.title = "Title"
            option.image = Ocean.icon.documentOutline
            option.onTouch = {
                self.oc1.isSelected = false
                self.oc2.isSelected = false
                self.oc3.isSelected = false
                self.oc4.isSelected = false
                self.oc6.isSelected = false
                print(5)
            }
        }
        oc6 = Ocean.OptionCard { option in
            option.title = "Title"
            option.subtitle = "Subtitle"
            option.image = Ocean.icon.documentOutline
            option.isRecommend = true
            option.recommendBackgroundColor = Ocean.color.colorStatusPositivePure
            option.recommendTitle = "Aproveite o cashback"
            option.onTouch = {
                self.oc1.isSelected = false
                self.oc2.isSelected = false
                self.oc3.isSelected = false
                self.oc4.isSelected = false
                self.oc5.isSelected = false
                print(6)
            }
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(oc1)
        stack.addArrangedSubview(oc2)
        stack.addArrangedSubview(oc3)
        stack.addArrangedSubview(oc4)
        stack.addArrangedSubview(oc5)
        stack.addArrangedSubview(oc6)
        
        self.add(view: stack)
        
        [oc1, oc2, oc3, oc4, oc5, oc6].forEach({
            $0.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32).isActive = true
        })
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
