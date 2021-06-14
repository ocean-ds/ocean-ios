//
//  InputViewController.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 11/08/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanComponents
import OceanTokens

public class InputViewController : UIViewController {
    @IBOutlet weak var states: UISegmentedControl!
    @IBOutlet weak var statesTextArea: UISegmentedControl!
    
    var textfield : Ocean.InputTextField!
    var textArea : Ocean.TextArea!
    var select: Ocean.InputSelectField!
    
    public override func viewDidLoad() {
        self.textfield = Ocean.Input.textfieldWithLabel { component in
            component.placeholder = "placeholder"
        }
        
        self.textfield.onBeginEditing = {
            self.textfield.becomeFirstResponder()
            self.textfield.errorMessage = ""
            self.states.selectedSegmentIndex = 1
        }
        self.textfield.onValueChanged = { text in
            self.states.selectedSegmentIndex = 1
        }
        
        self.view.addSubview(self.textfield)
        self.textfield.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(generateConstraintsTextFieldTop())
        
        self.textArea = Ocean.Input.textareaWithLabel { component in
            component.placeholder = "placeholder"
        }
        self.textArea.onBeginEditing = {
            self.textArea.errorMessage = ""
            self.statesTextArea.selectedSegmentIndex = 1
        }
        self.textArea.onValueChanged = { text in
            self.statesTextArea.selectedSegmentIndex = 1
        }
        
        self.view.addSubview(self.textArea)
        self.textArea.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(generateConstraintsTextAreaTop())
        
        self.select = Ocean.Input.selectWithLabel { component in
            component.placeholder = "placeholder"
            component.rootViewController = self
            component.values = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5"]
        }
        
        self.view.addSubview(self.select)
        self.select.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.select.topAnchor.constraint(equalTo: self.textArea.bottomAnchor, constant: 80),
            self.select.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.select.widthAnchor.constraint(equalToConstant: 328)
        ])
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
            self.textfield.text = ""
            self.textfield.errorMessage = ""
            self.textfield.endEditing(true)
            
            break
        case 1: //Focused
            self.textArea.onBeginEditing = {
                
            }
            self.textfield.isEnabled = true
            self.textfield.errorMessage = ""
            self.textfield.becomeFirstResponder()
            break
        case 2: //Activated
            self.textfield.isEnabled = true
            self.textfield.text = "Activated"
            self.textfield.errorMessage = ""
            self.textfield.endEditing(true)
            break
        case 3: //Disabled
            self.textfield.isEnabled = false
            self.textfield.errorMessage = ""
            break
        case 4: //Error
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
            self.textArea.text = ""
            self.textArea.errorMessage = ""
            self.textArea.endEditing(true)
            break
        case 1: //Focused
            self.textArea.isEnabled = true
            self.textArea.errorMessage = ""
            self.textArea.becomeFirstResponder()
            break
        case 2: //Activated
            self.textArea.isEnabled = true
            self.textArea.text = "Activated"
            self.textArea.errorMessage = ""
            self.textArea.endEditing(true)
            break
        case 3: //Disabled
            self.textArea.isEnabled = false
            self.textArea.errorMessage = ""
            break
        case 4: //Error
            self.textArea.isEnabled = true
            self.textArea.errorMessage = "error message"
            break
        default:
            break
        }
    }
}
