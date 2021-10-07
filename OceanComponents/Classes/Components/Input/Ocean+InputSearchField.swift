//
//  Ocean+InputSearchField.swift
//  OceanComponents-OceanComponents
//
//  Created by Vini on 07/07/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public enum InputSearchFieldState {
        case disabled
        case error
    }

    public class InputSearchField: UIControl, UITextFieldDelegate {
        var mainStack: UIStackView!

        public var textField: UITextField!
        private var imageView: UIImageView!
        private var imageCloseView: UIImageView!
        private var hStack: UIStackView!
        private var backgroundView: UIView!
        
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
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.makeView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.makeView()
        }

        public convenience init(builder: InputSearchFieldBuilder) {
            self.init(frame: .zero)
            builder(self)
            updateState()
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
            self.imageCloseView.isHidden = self.text.isEmpty
        }

        func makeImageView() {
            imageView = UIImageView()
            imageView.image = Ocean.icon.searchOutline?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        func makeImageCloseView() {
            imageCloseView = UIImageView()
            imageCloseView.image = Ocean.icon.xSolid?.withRenderingMode(.alwaysTemplate)
            imageCloseView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageCloseView.contentMode = .scaleAspectFit
            imageCloseView.translatesAutoresizingMaskIntoConstraints = false
            imageCloseView.isHidden = true
            imageCloseView.addTapGesture(target: self, selector: #selector(imageCloseTap))
        }
        
        @objc func imageCloseTap() {
            textField.text = ""
            editingChanged(textField: textField)
        }
        
        func updateState() {
            textField?.isEnabled = isEnabled
    
            if textField?.isFirstResponder == true {
                textField?.placeholder = ""
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorBrandPrimaryDown,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                backgroundView?.ocean.borderWidth.applyThin()
            } else if isActivated == false {
                changeColor(text: Ocean.color.colorInterfaceLightDeep,
                            border: Ocean.color.colorInterfaceLightDeep,
                            labelTitle: Ocean.color.colorInterfaceDarkUp)
                backgroundView?.ocean.borderWidth.applyHairline()
            } else if isEnabled {
                let isActivated = self.textField?.text?.isEmpty == true
                let color = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDeep
                let border = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorBrandPrimaryUp
                let labelColor = Ocean.color.colorInterfaceDarkDown
                changeColor(text: color,
                            border: border,
                            labelTitle: labelColor)
                backgroundView?.ocean.borderWidth.applyHairline()
            } else {
                changeColor(text: Ocean.color.colorInterfaceDarkUp,
                            border: Ocean.color.colorInterfaceLightDown,
                            background: Ocean.color.colorInterfaceLightDown,
                            placeHolder: Ocean.color.colorInterfaceDarkUp,
                            labelTitle: Ocean.color.colorInterfaceDarkUp)
                backgroundView?.ocean.borderWidth.applyHairline()
            }
        }

        func changeColor(text: UIColor,
                         border: UIColor,
                         background: UIColor? = Ocean.color.colorInterfaceLightPure,
                         placeHolder: UIColor? = Ocean.color.colorInterfaceLightDeep,
                         labelTitle: UIColor) {
            self.textField?.textColor = text
            self.backgroundView?.backgroundColor = background
            self.backgroundView?.layer.borderColor = border.cgColor
            self.textField?.placeHolderColor = placeHolder
            self.imageView.tintColor = border
        }

        func makeView() {
            self.makemainStack()
            self.makeHStack()
            self.makeTextField()
            self.makeImageView()
            self.makeImageCloseView()
            
            backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.ocean.borderWidth.applyHairline()
            backgroundView.ocean.radius.applySm()
            backgroundView.backgroundColor = Ocean.color.colorInterfaceLightPure

            mainStack.addArrangedSubview(backgroundView)

            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            hStack.addArrangedSubview(imageView)
            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
            hStack.addArrangedSubview(textField)
            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
            hStack.addArrangedSubview(imageCloseView)
            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            
            backgroundView.addSubview(hStack)

            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))

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
            
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

            textField.text = self.text
            textField.placeholder = self.placeholder
            textField.keyboardType = self.keyboardType
            textField.autocapitalizationType = self.autocapitalizationType
            textField.autocorrectionType = self.autocorrectionType
            
            updateState()
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
            return true
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onKeyEnterTouched?()
            return true
        }
    }
}
