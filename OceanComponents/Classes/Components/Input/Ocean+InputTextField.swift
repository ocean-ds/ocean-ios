//
//  InputTextField.swift
//  Blu
//
//  Created by Lucas Silveira on 01/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public enum InputTextFieldState {
        case disabled
        case error
    }

    public class InputTextField: UIControl, UITextFieldDelegate {
        var mainStack: UIStackView!

        private let errorEmpty = "..."
        private var labelTitle: UILabel!
        public var textField: UITextField!
        private var imageView: UIImageView!
        private var labelError: UILabel!
        private var labelCharactersLimit: UILabel!
        private var hStack: UIStackView!
        private var backgroundView: UIView!
        
        public var errorMessage: String = "" {
            didSet {
                labelError?.text = errorMessage.isEmpty == true ? errorEmpty : errorMessage
                self.updateState()
            }
        }

        public var title: String  = "" {
            didSet {
                labelTitle?.text = isOptional ? "\(title) (opcional)" : title
            }
        }

        public var placeholder: String = "" {
            didSet {
                textField?.placeholder = placeholder
            }
        }

        public var text: String = "" {
            didSet {
                textField?.text = text
                textField?.placeholder = ""
                self.updateState()
            }
        }
        
        public var image: UIImage? = nil {
            didSet {
                imageView.image = image
            }
        }

        public override var isEnabled: Bool {
            didSet {
                self.updateState()
            }
        }

        public var isActivated: Bool = true {
            didSet {
                isEnabled = isActivated
            }
        }
        
        public var isOptional: Bool = false {
            didSet {
                labelTitle?.text = isOptional ? "\(title) (opcional)" : title
            }
        }
        
        public var isValidCharactersRange: Bool {
            return charactersLimitValidator()
        }
        
        public var isSecureTextEntry: Bool = false {
            didSet {
                textField?.isSecureTextEntry = isSecureTextEntry
            }
        }

        public var autocorrectionType: UITextAutocorrectionType = .default {
            didSet {
                textField?.autocorrectionType = autocorrectionType
            }
        }

        public var keyboardType: UIKeyboardType = .default {
            didSet {
                textField?.keyboardType = keyboardType
            }
        }

        public var autocapitalizationType: UITextAutocapitalizationType = .sentences {
            didSet {
                textField?.autocapitalizationType = autocapitalizationType
            }
        }

        public var textContentType: UITextContentType? {
            didSet {
                if #available(iOS 12.0, *) {
                    textField?.textContentType = textContentType
                }
            }
        }
        
        public var charactersLimitNumber: Int? = nil {
            didSet {
                updateState()
            }
        }

        public override func becomeFirstResponder() -> Bool {
            return textField?.becomeFirstResponder() == true
        }

        public override func resignFirstResponder() -> Bool {
            return textField?.resignFirstResponder() == true
        }

        public var onValueChanged: ((String) -> Void)?
        public var onKeyEnterTouched: (() -> Void)?
        public var onBeginEditing: (() -> Void)?

        public var rightButton: UIButton?

        public convenience init(builder: InputTextFieldBuilder) {
            self.init()
            builder(self)
            makeView()
        }

        func makemainStack() {
            mainStack = UIStackView()
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.axis = .vertical
            mainStack.alignment = .fill
            mainStack.distribution = .fill
        }

        func makeHStack() {
            hStack = UIStackView()
            hStack.translatesAutoresizingMaskIntoConstraints = false
            hStack.axis = .horizontal
            hStack.alignment = .fill
            hStack.distribution = .fill
        }

        func makeTitleLabel() {
            labelTitle = UILabel()
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxs)
            labelTitle.textColor = Ocean.color.colorInterfaceDarkDown
        }

        func makeTextField() {
            textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.delegate = self

            textField.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXs)
            textField.textColor = Ocean.color.colorInterfaceDarkDeep
            textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
            textField.addTarget(self, action: #selector(editingChanged(textField:)), for: .editingChanged)
        }

        @objc func editingChanged(textField: UITextField) {
            guard self.text != textField.text else {
                return
            }
            self.text = textField.text ?? ""
            self.onValueChanged?(self.text)
        }

        func makeLabelError() {
            labelError = UILabel()
            labelError.translatesAutoresizingMaskIntoConstraints = false
            labelError.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            labelError.textColor = Ocean.color.colorStatusNegativePure
            labelError.text = errorEmpty
            labelError.isHidden = true
        }
        
        func makeLabelCharactersLimit() {
            labelCharactersLimit = UILabel()
            labelCharactersLimit.translatesAutoresizingMaskIntoConstraints = false
            labelCharactersLimit.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            labelCharactersLimit.textColor = Ocean.color.colorInterfaceDarkUp
            labelCharactersLimit.isHidden = true
        }
        
        func makeImageView() {
            imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
        }

        func updateState() {
            textField?.isEnabled = isEnabled
            labelError?.isHidden = true
            labelCharactersLimit.isHidden = true
    
            if labelError?.text != nil && labelError?.text != errorEmpty {
                labelError?.isHidden = false
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorStatusNegativePure,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                backgroundView.ocean.borderWidth.applyHairline()
            } else if let limitValue = self.charactersLimitNumber {
                labelCharactersLimit.isHidden = false
                labelCharactersLimit?.text = "\(textField.text?.count ?? 0)/\(limitValue)"
            } else if textField?.isFirstResponder == true {
                textField?.placeholder = ""
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorBrandPrimaryDown,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                backgroundView.ocean.borderWidth.applyThin()
            } else if isActivated == false {
                changeColor(text: Ocean.color.colorInterfaceLightDeep,
                            border: Ocean.color.colorInterfaceLightDeep,
                            placeHolder: Ocean.color.colorInterfaceLightDeep,
                            labelTitle: Ocean.color.colorInterfaceDarkUp)
                backgroundView.ocean.borderWidth.applyHairline()
            } else if isEnabled {
                let isActivated = self.textField?.text?.isEmpty == true
                let color = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDeep
                let border = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorBrandPrimaryUp
                let labelColor = Ocean.color.colorInterfaceDarkDown
                changeColor(text: color,
                            border: border,
                            placeHolder: Ocean.color.colorInterfaceLightDeep,
                            labelTitle: labelColor)
                backgroundView.ocean.borderWidth.applyHairline()
            } else {
                changeColor(text: Ocean.color.colorInterfaceDarkUp,
                            border: Ocean.color.colorInterfaceLightDown,
                            background: Ocean.color.colorInterfaceLightDown,
                            placeHolder: Ocean.color.colorInterfaceDarkUp,
                            labelTitle: Ocean.color.colorInterfaceDarkUp)
                backgroundView.ocean.borderWidth.applyHairline()
            }
        }

        func changeColor(text: UIColor,
                         border: UIColor,
                         background: UIColor? = Ocean.color.colorInterfaceLightPure,
                         placeHolder: UIColor? = Ocean.color.colorInterfaceLightUp,
                         labelTitle: UIColor) {
            self.textField?.textColor = text
            self.backgroundView?.backgroundColor = background
            self.backgroundView?.layer.borderColor = border.cgColor
            self.textField?.placeHolderColor = placeHolder
            self.labelTitle?.textColor = labelTitle
        }

        func makeView() {
            self.makemainStack()
            self.makeHStack()
            self.makeTitleLabel()
            self.makeTextField()
            self.makeLabelError()
            self.makeLabelCharactersLimit()
            self.makeImageView()
            
            textField.addSubview(imageView)

            mainStack.addArrangedSubview(labelTitle)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))

            backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.ocean.borderWidth.applyHairline()
            backgroundView.ocean.radius.applySm()
            backgroundView.backgroundColor = Ocean.color.colorInterfaceLightPure

            mainStack.addArrangedSubview(backgroundView)

            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            hStack.addArrangedSubview(textField)

            if let rightButton = self.rightButton {
                rightButton.translatesAutoresizingMaskIntoConstraints = false
                rightButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
                hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
                hStack.addArrangedSubview(rightButton)
            }

            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            backgroundView.addSubview(hStack)

            if #available(iOS 11.0, *) {
                mainStack.setCustomSpacing(Ocean.size.spacingStackXxxs, after: hStack)
            } else {
                mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
            }
            
            mainStack.addArrangedSubview(labelError)
            
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
            mainStack.addArrangedSubview(labelCharactersLimit)

            self.addSubview(mainStack)

            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            backgroundView.heightAnchor.constraint(equalToConstant: 48).isActive = true

            mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            hStack.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            hStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
            hStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
            hStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
            
            imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            imageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true

            labelTitle.text = isOptional ? "\(title) (opcional)" : title
            textField.text = self.text
            textField.placeholder = self.placeholder
            textField.isSecureTextEntry = self.isSecureTextEntry
            textField.keyboardType = self.keyboardType
            textField.autocapitalizationType = self.autocapitalizationType
            textField.autocorrectionType = self.autocorrectionType
            
            if !self.errorMessage.isEmpty {
                labelError.text = self.errorMessage
            }
            
            updateState()
        }

        func charactersLimitValidator() -> Bool {
            guard let textCount = textField.text?.count, let limitValue = charactersLimitNumber else { return true }
            return textCount < (limitValue)
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            updateState()
            if (textField.text?.isEmpty == true) {
                textField.placeholder = self.placeholder
            }
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            self.onBeginEditing?()
            updateState()
        }
        
        public func textField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange,
                              replacementString string: String) -> Bool {
            updateState()
            guard !string.isEmpty else { return true }
            return charactersLimitValidator()
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onKeyEnterTouched?()
            return true
        }
        
    }
}
