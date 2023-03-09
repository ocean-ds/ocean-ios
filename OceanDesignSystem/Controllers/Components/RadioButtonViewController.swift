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
    private var rb5: Ocean.RadioButton!
    private var rb6: Ocean.RadioButton!
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        rb1 = Ocean.RadioButton { rb in
            rb.text = "Radio button 1"
            rb.onTouch = {
                self.rb2.isSelected = false
                self.rb3.isSelected = false
            }
        }
        rb2 = Ocean.RadioButton { rb in
            rb.text = "Radio button 2 with large text and many words. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            rb.onTouch = {
                self.rb1.isSelected = false
                self.rb3.isSelected = false
            }
        }
        rb3 = Ocean.RadioButton { rb in
            rb.text = "Radio button 3 Error"
            rb.errorMessage = "Mensagem de erro"
            rb.onTouch = {
                self.rb1.isSelected = false
                self.rb2.isSelected = false
            }
        }
        rb4 = Ocean.RadioButton { rb in
            rb.text = "Radio button 1 Disabled"
            rb.isSelected = true
            rb.isEnabled = false
        }
        rb5 = Ocean.RadioButton { rb in
            rb.text = "Radio button 2 Disabled"
            rb.isEnabled = false
        }
        rb6 = Ocean.RadioButton { ck in
            let link = "Blu"
            let text = "Radio button with attributed text, so why not check \(link) out?"
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: Ocean.font.fontFamilyBaseWeightMedium,
                              size: Ocean.font.fontSizeXxxs)!,
                .foregroundColor: Ocean.color.colorInterfaceDarkDown
            ]
            
            let attrString = NSMutableAttributedString(string: text)
            attrString.addAttributes(attributes, range: (text as NSString).range(of: text))
            
            attrString.addAttribute(.link,
                                    value: "https://blu.com.br/",
                                    range: (text as NSString).range(of: link))
            
            ck.attributedText = attrString
            ck.isEnabled = true
        }
        
        let stack = Ocean.StackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        stack.setMargins(horizontal: Ocean.size.spacingStackXs)
        
        stack.addArrangedSubview(rb1)
        stack.addArrangedSubview(rb2)
        stack.addArrangedSubview(rb3)
        stack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingStackSm))
        stack.addArrangedSubview(rb4)
        stack.addArrangedSubview(rb5)
        stack.addArrangedSubview(rb6)
        
        self.view.addSubview(stack)

        stack.oceanConstraints
            .topToTop(to: view, constant: 16)
            .leadingToLeading(to: view, constant: 16)
            .trailingToTrailing(to: view, constant: -16)
            .make()
    }
}
