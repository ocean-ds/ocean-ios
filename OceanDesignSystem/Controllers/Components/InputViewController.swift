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
    var search: Ocean.InputSearchField!
    var token: Ocean.InputTokenField!
    
    public override func viewDidLoad() {
        self.textfield = Ocean.Input.textfieldWithLabel { component in
            component.placeholder = "placeholder"
            component.helper = "helper text"
            component.iconHelper = Ocean.icon.infoSolid
            component.onHelperTextTouched = { print("helper text on touch") }
            component.infoMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
            component.onInfoIconTouched = {
                
            }
        }
        
        self.textfield.onBeginEditing = {
            _ = self.textfield.becomeFirstResponder()
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
            component.helper = "helper text"
            component.infoMessage = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
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
        
        self.search = Ocean.Input.search { component in
            component.placeholder = "placeholder"
        }
        
        self.view.addSubview(self.search)
        self.search.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.search.topAnchor.constraint(equalTo: self.textArea.bottomAnchor, constant: 20),
            self.search.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.search.widthAnchor.constraint(equalToConstant: 328)
        ])
        
        self.token = Ocean.Input.token { component in
            component.title = "Label"
            component.onValueCompleted = { value in
                print(value)
            }
        }
        
        self.view.addSubview(self.token)
        self.token.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.token.topAnchor.constraint(equalTo: self.search.bottomAnchor, constant: 20),
            self.token.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.select = Ocean.Input.selectWithLabel { component in
            component.placeholder = "placeholder"
            component.helper = "helper text"
            component.titleModal = "Title"
            component.rootViewController = self
            component.placeholderFilter = "Digite o texto para filtrar"
            component.values = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7", "Label 8", "Label 9", "Label 10", "Label 11", "Label 12", "Label 13", "Label 14", "Label 15", "Label 16", "Label 17", "Label 18", "Label 19", "Label 20", "Label 21", "Label 22", "Label 23", "Label 24", "Label 25"]
            component.maxValues = 4
        }
        
        self.view.addSubview(self.select)
        self.select.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.select.topAnchor.constraint(equalTo: self.token.bottomAnchor, constant: 20),
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
            self.textfield.charactersLimitNumber = nil
            self.textfield.endEditing(true)
            
            break
        case 1: //Focused
            self.textArea.onBeginEditing = {
                
            }
            self.textfield.isEnabled = true
            self.textfield.errorMessage = ""
            self.textfield.charactersLimitNumber = nil
            _ = self.textfield.becomeFirstResponder()
            break
        case 2: //Activated
            self.textfield.isEnabled = true
            self.textfield.text = "Activated"
            self.textfield.errorMessage = ""
            self.textfield.charactersLimitNumber = nil
            self.textfield.endEditing(true)
            break
        case 3: //Disabled
            self.textfield.isEnabled = false
            self.textfield.errorMessage = ""
            self.textfield.charactersLimitNumber = nil
            break
        case 4: //Error
            self.textfield.isEnabled = true
            self.textfield.errorMessage = "error message"
            break
        case 5://Characters validator
            self.textfield.errorMessage = ""
            self.textfield.isEnabled = true
            self.textfield.charactersLimitNumber = 10
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
            self.textArea.charactersLimitNumber = nil
            self.textArea.endEditing(true)
            break
        case 1: //Focused
            self.textArea.isEnabled = true
            self.textArea.errorMessage = ""
            self.textArea.charactersLimitNumber = nil
            _ = self.textArea.becomeFirstResponder()
            break
        case 2: //Activated
            self.textArea.isEnabled = true
            self.textArea.text = "Activated"
            self.textArea.errorMessage = ""
            self.textArea.charactersLimitNumber = nil
            self.textArea.endEditing(true)
            break
        case 3: //Disabled
            self.textArea.isEnabled = false
            self.textArea.errorMessage = ""
            self.textArea.charactersLimitNumber = nil
            break
        case 4: //Error
            self.textArea.isEnabled = true
            self.textArea.errorMessage = "error message"
            break
        case 5: //Characters validator
            self.textArea.errorMessage = ""
            self.textArea.charactersLimitNumber = 10
            self.textArea.isEnabled = true
        default:
            break
        }
    }
}
