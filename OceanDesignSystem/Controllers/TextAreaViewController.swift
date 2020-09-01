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
    @IBOutlet weak var statesTextArea: UISegmentedControl!
    
    var textfield : Ocean.InputTextField!
    var textArea : Ocean.TextArea!
    
    public override func viewDidLoad() {
        
        self.textfield = Ocean.Input.textfieldWithLabel { component in
            component.placeholder = "Input Text"
        }
        
        self.textfield.onBeginEditing = {
            self.textfield.becomeFirstResponder()
            self.textfield.errorMessage = ""
            self.states.selectedSegmentIndex = 1
        }
        self.textfield.onValueChanged = { text in
            //self.textfield.errorMessage = ""
            self.states.selectedSegmentIndex = 1
        }
        
        self.view.addSubview(self.textfield)
        self.textfield.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(generateConstraintsTextFieldTop())
        
        self.textArea = Ocean.Input.textareaWithLabel { component in
            component.placeholder = "Text Area"
        }
        self.textArea.onBeginEditing = {
            self.textArea.becomeFirstResponder()
            self.textArea.errorMessage = ""
            self.statesTextArea.selectedSegmentIndex = 1
        }
        self.textArea.onValueChanged = { text in
            //self.textfield.errorMessage = ""
            self.statesTextArea.selectedSegmentIndex = 1
        }
        self.view.addSubview(self.textArea)
        self.textArea.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(generateConstraintsTextAreaTop())
    }
        
    
    private func generateConstraintsTextFieldTop() -> [NSLayoutConstraint] {
        let constraintTop = NSLayoutConstraint(item: self.textfield,
        attribute: .top,
        relatedBy: .equal,
        toItem: topLayoutGuide,
        attribute: .top,
        multiplier: 1.0,
        constant: 80.0)
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
    
    private func generateConstraintsTextAreaTop() -> [NSLayoutConstraint] {
        let constraintTop = NSLayoutConstraint(item: self.textArea,
        attribute: .top,
        relatedBy: .equal,
        toItem: topLayoutGuide,
        attribute: .top,
        multiplier: 1.0,
        constant: 250.0)
        let constraintX = NSLayoutConstraint(item: self.textArea,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: view,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0.0)
        let constraintWidth = NSLayoutConstraint(item: self.textArea,
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
            self.textfield.isEnabled = true
            self.textfield.errorMessage = ""
            self.textfield.endEditing(true)
            
            break
        case 1: //Activated
            self.textfield.isEnabled = true
            self.textfield.errorMessage = ""
            self.textfield.becomeFirstResponder()
            break
        case 2: //Disabled
            self.textfield.isEnabled = false
            self.textfield.errorMessage = ""
            break
        case 3: //Error
            self.textfield.isEnabled = true
            self.textfield.errorMessage = "error message"
            break
        default:
            break
        }
    }
    
    @IBAction func onValueChangedTextArea(_ sender: Any) {
        switch statesTextArea.selectedSegmentIndex
        {
        case 0: //Inactive
            self.textArea.isEnabled = true
            self.textArea.errorMessage = ""
            self.textArea.endEditing(true)
            
            break
        case 1: //Activated
            self.textArea.isEnabled = true
            self.textArea.errorMessage = ""
            self.textArea.becomeFirstResponder()
            break
        case 2: //Disabled
            self.textArea.isEnabled = false
            self.textArea.errorMessage = ""
            break
        case 3: //Error
            self.textArea.isEnabled = true
            self.textArea.errorMessage = "error message"
            break
        default:
            break
        }
    }
}
