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
        public var errorMessage: String = "" {
            didSet {
                labelError.text = errorMessage.isEmpty == true ? errorEmpty : errorMessage
                self.updateState()
            }
        }

        public var title: String  = "" {
            didSet {
                labelTitle.text = isOptional ? "\(title) (opcional)" : title
            }
        }

        public var placeholder: String = "" {
            didSet {
                textField.placeholder = placeholder
            }
        }

        public var text: String = "" {
            didSet {
                textField.text = text
                self.updateState()
            }
        }

        public var helper: String = "" {
            didSet {
                labelHelper.text = helper
                self.updateState()
            }
        }

        public var iconHelper: UIImage? = nil {
            didSet {
                iconHelperImage.image = iconHelper?.withRenderingMode(.alwaysTemplate)
                iconHelperImage.isHidden = iconHelper == nil
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
                labelTitle.text = isOptional ? "\(title) (opcional)" : title
            }
        }

        public var infoMessage: String = "" {
            didSet {
                infoIconImageView.isHidden = infoMessage.isEmpty
                tooltip.message = infoMessage
            }
        }

        public var isValidCharactersRange: Bool {
            return charactersLimitValidator()
        }

        public var isSecureTextEntry: Bool = false {
            didSet {
                textField.isSecureTextEntry = isSecureTextEntry
            }
        }

        public var autocorrectionType: UITextAutocorrectionType = .default {
            didSet {
                textField.autocorrectionType = autocorrectionType
            }
        }

        public var keyboardType: UIKeyboardType = .default {
            didSet {
                textField.keyboardType = keyboardType
            }
        }

        public var autocapitalizationType: UITextAutocapitalizationType = .sentences {
            didSet {
                textField.autocapitalizationType = autocapitalizationType
            }
        }

        public var textContentType: UITextContentType? {
            didSet {
                textField.textContentType = textContentType
            }
        }

        public var maxLenght: Int? = nil

        public var charactersLimitNumber: Int? = nil {
            didSet {
                guard let limitValue = charactersLimitNumber else { return }
                maxLenght = limitValue
                labelHelper.text = "\(textField.text?.count ?? 0)/\(limitValue)"
            }
        }

        public override func becomeFirstResponder() -> Bool {
            return textField.becomeFirstResponder() == true
        }

        public override func resignFirstResponder() -> Bool {
            return textField.resignFirstResponder() == true
        }

        public var onValueChanged: ((String) -> Void)?
        public var onKeyEnterTouched: (() -> Void)?
        public var onBeginEditing: (() -> Void)?
        public var onInfoIconTouched: (() -> Void)?
        public var onHelperTextTouched: (() -> Void)?

        internal var mainStack: Ocean.StackView!
        internal var hStack: Ocean.StackView!
        internal var backgroundView: UIView!
        internal var titleStackContent: Ocean.StackView!
        internal var titleStackView: Ocean.StackView!

        private let errorEmpty = "..."

        internal lazy var textField: UITextField = {
            let view = UITextField()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.delegate = self
            view.font = .baseRegular(size: Ocean.font.fontSizeXs)
            view.textColor = Ocean.color.colorInterfaceDarkDeep
            view.heightAnchor.constraint(equalToConstant: 48).isActive = true
            view.addTarget(self, action: #selector(editingChanged(textField:)), for: .editingChanged)
            return view
        }()

        private lazy var labelTitle: UILabel = {
            let label = UILabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            label.textColor = Ocean.color.colorInterfaceDarkDown
            return label
        }()

        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private lazy var labelError: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
            label.textColor = Ocean.color.colorStatusNegativePure
            label.text = errorEmpty
            label.isHidden = true
            return label
        }()

        private lazy var infoIconImageView: UIImageView = {
            let view = UIImageView()
            view.image = Ocean.icon.informationCircleSolid?.withRenderingMode(.alwaysTemplate)
            view.tintColor = Ocean.color.colorInterfaceDarkUp
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 12.8),
                view.widthAnchor.constraint(equalToConstant: 12.8)
            ])
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoAction)))
            view.isHidden = infoMessage.isEmpty
            return view
        }()

        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.message = infoMessage
            }
        }()

        private lazy var iconHelperImage: UIImageView = {
            let icon = UIImageView()
            icon.tintColor = Ocean.color.colorInterfaceDarkUp
            icon.isHidden = iconHelper == nil
            return icon
        }()

        private lazy var labelHelper: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.text = helper
            return label
        }()

        private lazy var labelHelperStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxxs
                stack.isHidden = true

                stack.add([
                    labelHelper,
                    iconHelperImage,
                    UIView()
                ])

                stack.addTapGesture(target: self, selector: #selector(helperOnTouch))
            }
        }()

        @objc private func helperOnTouch() {
            onHelperTextTouched?()
        }

        public var rightButton: UIButton?

        public convenience init(builder: InputTextFieldBuilder) {
            self.init(frame: .zero)
            builder(self)
            makeView()
            updateState()
        }

        func makemainStack() {
            mainStack = Ocean.StackView()
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.axis = .vertical
            mainStack.alignment = .fill
            mainStack.distribution = .fill
        }

        func makeHStack() {
            hStack = Ocean.StackView()
            hStack.translatesAutoresizingMaskIntoConstraints = false
            hStack.axis = .horizontal
            hStack.alignment = .fill
            hStack.distribution = .fill
        }

        func makeTitleStackContent() {
            makeTitleStackView()
            titleStackContent = Ocean.StackView()
            titleStackContent.axis = .vertical
            titleStackContent.alignment = .leading
            titleStackContent.distribution = .fill
            titleStackContent.addArrangedSubview(titleStackView)
        }

        func makeTitleStackView() {
            titleStackView = Ocean.StackView()
            titleStackView.axis = .horizontal
            titleStackView.alignment = .center
            titleStackView.distribution = .fill
            titleStackView.spacing = 5
            titleStackView.addArrangedSubview(labelTitle)
            titleStackView.addArrangedSubview(infoIconImageView)
        }

        @objc func editingChanged(textField: UITextField) {
            guard self.text != textField.text else {
                return
            }
            self.text = textField.text ?? ""
            self.onValueChanged?(self.text)
        }

        @objc func infoAction(_ sender: Any) {
            onInfoIconTouched?()
            tooltip.show(target: infoIconImageView, presenter: self)
        }

        func updateState() {
            textField.isEnabled = isEnabled
            labelError.isHidden = true
            labelHelperStack.isHidden = true

            if labelError.text != nil && labelError.text != errorEmpty {
                labelError.isHidden = false
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorStatusNegativePure,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                backgroundView?.ocean.borderWidth.applyHairline()
            } else if textField.isFirstResponder == true {
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
                let isActivated = self.textField.text?.isEmpty == true
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

            if let limitValue = self.charactersLimitNumber {
                labelHelper.text = "\(textField.text?.count ?? 0)/\(limitValue)"
            }

            if labelError.isHidden,
               let helperText = labelHelper.text,
               !helperText.isEmpty {
                labelHelperStack.isHidden = false
            }
        }

        func changeColor(text: UIColor,
                         border: UIColor,
                         background: UIColor? = Ocean.color.colorInterfaceLightPure,
                         placeHolder: UIColor? = Ocean.color.colorInterfaceLightDeep,
                         labelTitle: UIColor) {
            self.textField.textColor = text
            self.backgroundView?.backgroundColor = background
            self.backgroundView?.layer.borderColor = border.cgColor
            self.textField.placeHolderColor = placeHolder
            self.labelTitle.textColor = labelTitle
        }

        func makeView() {
            self.makemainStack()
            self.makeHStack()
            self.makeTitleStackContent()

            textField.addSubview(imageView)

            mainStack.addArrangedSubview(titleStackContent)
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
                hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
                hStack.addArrangedSubview(rightButton)
            }

            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            backgroundView.addSubview(hStack)

            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
            mainStack.addArrangedSubview(labelError)
            mainStack.addArrangedSubview(labelHelperStack)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))

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

            iconHelperImage.oceanConstraints
                .height(constant: Ocean.size.spacingStackXs)
                .width(constant: Ocean.size.spacingStackXs)
                .make()

            updateState()
        }

        func charactersLimitValidator() -> Bool {
            guard let textCount = textField.text?.count, let limitValue = maxLenght else { return true }
            return textCount < (limitValue)
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            updateState()
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

        public func makeTextSpaced() {
            self.textField.leftView = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
            self.textField.leftViewMode = .always
            self.textField.defaultTextAttributes.updateValue(Ocean.size.spacingStackXxs,
                                                             forKey: NSAttributedString.Key.kern)
            self.textField.textAlignment = .center
        }

        public func setSkeleton() {
            self.isSkeletonable = true
        }
    }
}
