//
//  InputTextField.swift
//  Blu
//
//  Created by Lucas Silveira on 01/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

enum InputTextFieldState {
    case disabled
    case error
}

public class InputTextField: UIControl, UITextFieldDelegate, Renderable {
    var mainStack: UIStackView!

    private var labelTitle: UILabel!
    private var textField: UITextField!
    private var image: UIImage!
    private var labelError: UILabel!
    private var hStack: UIStackView!
    private var backgroundView: UIView!
    public var errorMessage: String? {
        didSet {
            labelError.text = errorMessage
            self.updateState()
        }
    }

    public var title: String  = "" {
        didSet {
            labelTitle?.text = title
        }
    }

    public var placeholder: String = "" {
        didSet {
            textField?.placeholder = placeholder
        }
    }

    public var text: String = ""{
        didSet {
            textField?.text = text
        }
    }

    public var isActivated: Bool = true {
        didSet {
            isEnabled = isActivated
        }
    }

    public var isSecureTextEntry: Bool = false {
        didSet {
            textField?.isSecureTextEntry = isSecureTextEntry
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

    var textContentType: UITextContentType? {
        didSet {
            if #available(iOS 12.0, *) {
                textField.textContentType = textContentType
            }
        }
    }

    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }

    public var onValueChanged: ((String) -> Void)?
    public var onKeyEnterTouched: (() -> Void)?

    public var rightButton: UIButton?

    public convenience init(builder: ((InputTextField) -> Void)? = nil) {
        self.init()
        builder?(self)
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

    func makeLabel() {
        labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont(
            name: Ocean.font.fontFamilyHighlightWeightRegular,
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
    }

    func updateState() {
        textField.isEnabled = isEnabled

        if errorMessage?.isEmpty == false {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorStatusNegativePure)
        } else if textField.isFirstResponder {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorBrandPrimaryDown)
        } else if isActivated == false {
            changeColor(text: Ocean.color.colorInterfaceLightDeep,
                        border: Ocean.color.colorInterfaceLightDeep,
                        placeHolder: Ocean.color.colorInterfaceLightDeep)
        } else if isEnabled {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorBrandPrimaryUp)
        } else {
            changeColor(text: Ocean.color.colorInterfaceDarkUp,
                        border: Ocean.color.colorInterfaceLightDown,
                        background: Ocean.color.colorInterfaceLightDown,
                        placeHolder: Ocean.color.colorInterfaceDarkUp)
        }
    }

    func changeColor(text: UIColor,
                     border: UIColor,
                     background: UIColor? = Ocean.color.colorInterfaceLightPure,
                     placeHolder: UIColor? = Ocean.color.colorInterfaceLightUp) {
        self.textField.textColor = text
        self.backgroundView.backgroundColor = background
        self.backgroundView.layer.borderColor = border.cgColor
    }

    func makeView() {
        self.makemainStack()
        self.makeHStack()
        self.makeLabel()
        self.makeTextField()
        self.makeLabelError()

        mainStack.addArrangedSubview(labelTitle)
        mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))

        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = Ocean.size.borderRadiusSm
        backgroundView.layer.borderWidth = Ocean.size.borderWidthThin
        backgroundView.layer.borderColor = UIColor.blue.cgColor
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

        mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
        mainStack.addArrangedSubview(labelError)

        self.addSubview(mainStack)

        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        hStack.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        hStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        hStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true

        labelTitle.text = self.title
        textField.text = self.text
        textField.placeholder = self.placeholder
        textField.isSecureTextEntry = self.isSecureTextEntry
        textField.keyboardType = self.keyboardType
        textField.autocapitalizationType = self.autocapitalizationType

        updateState()
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateState()
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
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
