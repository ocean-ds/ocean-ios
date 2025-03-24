//
//  Ocean+InputTokenField.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 18/11/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class InputTokenField: UIView {
        public var onValueCompleted: ((String) -> Void)?
        
        private lazy var labelTitle: UILabel = {
            let view = UILabel()
            view.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxs)
            view.textColor = Ocean.color.colorInterfaceDarkDown
            view.text = ""
            return view
        }()
        
        private lazy var otpStackView: OTPStackView = {
            let view = OTPStackView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.onValueCompleted = { value in
                view.setAllFieldColor(color: Ocean.color.colorBrandPrimaryUp)
                self.labelError.isHidden = true
                self.onValueCompleted?(value)
            }

            return view
        }()
        
        private lazy var labelError: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            view.textColor = Ocean.color.colorStatusNegativePure
            view.text = ""
            view.isHidden = true
            return view
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                labelTitle,
                Spacer(space: Ocean.size.spacingStackXxxs),
                otpStackView,
                Spacer(space: Ocean.size.spacingStackXxxs),
                labelError
            ])
            
            return stack
        }()
        
        public var title: String = "" {
            didSet {
                labelTitle.text = title
            }
        }
        
        public var errorMessage: String = "" {
            didSet {
                labelError.text = errorMessage
                labelError.isHidden = errorMessage.isEmpty
                otpStackView.setAllFieldColor(color: Ocean.color.colorStatusNegativePure)
                otpStackView.emptyOTP()
            }
        }
        
        public convenience init(builderToken: InputTokenFieldBuilder) {
            self.init(frame: .zero)
            builderToken(self)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private final func setupUI() {
            self.add(view: contentStack)
            self.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: 216)
            ])
        }
    }
    
    class OTPStackView: Ocean.StackView, UITextFieldDelegate {
        let numberOfFields = 4
        var textFieldsCollection: [OTPTextField] = []
        var showsWarningColor = false
        
        let inactiveFieldBorderColor = Ocean.color.colorInterfaceLightDeep
        let activeFieldBorderColor = Ocean.color.colorBrandPrimaryDown
        let activatedFieldBorderColor = Ocean.color.colorBrandPrimaryUp
        
        var remainingStrStack: [String] = []
        
        public var onValueCompleted: ((String) -> Void)?
        
        required init(coder: NSCoder) {
            super.init(coder: coder)
            setupStackView()
            addOTPFields()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupStackView()
            addOTPFields()
        }
        
        private final func setupStackView() {
            self.backgroundColor = .clear
            self.isUserInteractionEnabled = true
            self.translatesAutoresizingMaskIntoConstraints = false
            self.contentMode = .center
            self.distribution = .fill
            self.spacing = Ocean.size.spacingStackXxs
        }
        
        private final func addOTPFields() {
            for index in 0..<numberOfFields {
                let field = OTPTextField()
                setupTextField(field)
                textFieldsCollection.append(field)
                index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
                index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
            }
            textFieldsCollection[0].becomeFirstResponder()
        }
        
        private final func setupTextField(_ textField: OTPTextField) {
            textField.delegate = self
            textField.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview(textField)
            textField.widthAnchor.constraint(equalToConstant: 48).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
            textField.backgroundColor = Ocean.color.colorInterfaceLightPure
            textField.textAlignment = .center
            textField.adjustsFontSizeToFitWidth = false
            textField.font = .baseRegular(size: Ocean.font.fontSizeXs)
            textField.textColor = Ocean.color.colorInterfaceDarkDeep
            textField.layer.cornerRadius = Ocean.size.borderRadiusTiny
            textField.layer.borderWidth = Ocean.size.borderWidthHairline
            textField.layer.borderColor = inactiveFieldBorderColor.cgColor
            textField.keyboardType = .default
            textField.autocorrectionType = .yes
            textField.textContentType = .oneTimeCode
        }
        
        private final func checkForValidity(){
            for fields in textFieldsCollection {
                if (fields.text?.trimmingCharacters(in: CharacterSet.whitespaces) == "") {
                    return
                }
                _ = fields.resignFirstResponder()
            }
            let otp = getOTP()
            self.onValueCompleted?(otp)
        }
        
        public func emptyOTP() {
            for textField in textFieldsCollection {
                textField.text = ""
            }
        }
        
        private func getOTP() -> String {
            var OTP = ""
            for textField in textFieldsCollection {
                OTP += textField.text ?? ""
            }
            return OTP
        }

        final func setAllFieldColor(isWarningColor: Bool = false, color: UIColor){
            for textField in textFieldsCollection {
                textField.layer.borderColor = color.cgColor
            }
            showsWarningColor = isWarningColor
        }
        
        private func autoFillTextField(with string: String) {
            remainingStrStack = string.reversed().compactMap{String($0)}
            for textField in textFieldsCollection {
                if let charToAdd = remainingStrStack.popLast() {
                    textField.text = String(charToAdd)
                } else {
                    break
                }
            }
            checkForValidity()
            remainingStrStack = []
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            if showsWarningColor {
                setAllFieldColor(color: inactiveFieldBorderColor)
                showsWarningColor = false
            }
            textField.layer.borderColor = activeFieldBorderColor.cgColor
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            let isActivated = textField.text?.isEmpty == true
            textField.layer.borderColor = isActivated ? inactiveFieldBorderColor.cgColor : activatedFieldBorderColor.cgColor
            checkForValidity()
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                       replacementString string: String) -> Bool {
            guard let textField = textField as? OTPTextField else { return true }
            if string.count > 1 {
                textField.resignFirstResponder()
                autoFillTextField(with: string)
                return false
            } else {
                if (range.length == 0 && string == "") {
                    return false
                } else if (range.length == 0){
                    if textField.nextTextField == nil {
                        textField.text? = string
                        textField.resignFirstResponder()
                    }else{
                        textField.text? = string
                        textField.nextTextField?.becomeFirstResponder()
                    }
                    return false
                }
                return true
            }
        }
    }
    
    class OTPTextField: UITextField {
        weak var previousTextField: OTPTextField?
        weak var nextTextField: OTPTextField?
        
        override public func deleteBackward(){
            text = ""
            previousTextField?.becomeFirstResponder()
        }
        
    }
}
