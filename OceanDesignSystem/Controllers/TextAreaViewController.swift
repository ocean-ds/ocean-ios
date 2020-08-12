//
//  TextAreaViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 11/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanComponents
import OceanTokens

public class TextAreaViewController : UIViewController {
    
    @IBOutlet weak var states: UISegmentedControl!
    
    var textfield : Ocean.InputTextField!
    var textArea : Ocean.TextArea!
    
    public override func viewDidLoad() {
        
        self.textfield = Ocean.Input.textfield { component in
            component.placeholder = "Input Text"
        }
        
//        self.textfield.onKeyEnterTouched = {
//            self.states.selectedSegmentIndex = 0
//        }
        self.textfield.onValueChanged = { text in
            //self.textfield.errorMessage = ""
            self.states.selectedSegmentIndex = 1
        }
        
        self.view.addSubview(self.textfield)
        self.textfield.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(generateConstraintsTextFieldTop())
    }
        
    
    private func generateConstraintsTextFieldTop() -> [NSLayoutConstraint] {
        let constraintTop = NSLayoutConstraint(item: self.textfield,
        attribute: .top,
        relatedBy: .equal,
        toItem: topLayoutGuide,
        attribute: .top,
        multiplier: 1.0,
        constant: 100.0)
        let constraintX = NSLayoutConstraint(item: self.textfield,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: view,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0.0)
        let constraintWidth = NSLayoutConstraint(item: self.textfield,
        attribute: .width,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: 328)

        return [constraintTop, constraintX, constraintWidth]
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        switch states.selectedSegmentIndex
        {
        case 0: //Inactive
            self.textfield.errorMessage = ""
            self.textfield.endEditing(true)
            self.textfield.isEnabled = true
            break
        case 1: //Activated
            self.textfield.errorMessage = ""
            self.textfield.becomeFirstResponder()
            self.textfield.isEnabled = true
            break
        case 2: //Disabled
            self.textfield.errorMessage = ""
            self.textfield.isEnabled = false
            break
        case 3: //Error
            self.textfield.errorMessage = "error message"
            break
        default:
            break
        }
    }
}
