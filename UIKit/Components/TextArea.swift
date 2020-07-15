//
//  TextArea.swift
//  Blu
//
//  Created by Lucas Silveira on 09/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

enum TextAreaState {
    case disabled
    case error
}

public class TextArea: UIControl, UITextViewDelegate, Renderable {
    internal var mainStack: UIStackView!
    private var textArea: UITextView!
    private var image: UIImage!
    private var labelError: UILabel!
    private var hStack: UIStackView!
    private var backgroundView: UIView!
    private var height: CGFloat = 48
    public var errorMessage: String? {
        get { labelError.text ?? "" }

        set {
            labelError.text = newValue
            self.updateState()
        }
    }

    public var placeholder: String = "" {
        didSet {
            textArea.setPlaceholder(text: placeholder)
        }
    }

    public var text: String {
        get { textArea.text ?? "" }

        set {
            textArea.text = newValue
            textArea.checkPlaceholder()
            self.updateState()
        }
    }

    public var numberOfLines: Int = 2 {
        didSet {
            textArea.textContainer.maximumNumberOfLines = numberOfLines - 1
            height = height * CGFloat((numberOfLines - 1))
            makeView()
        }
    }

    public var isActivated: Bool = true {
        didSet {
            isEnabled = isActivated
        }
    }

    var textContentType: UITextContentType? {
        didSet {
            if #available(iOS 12.0, *) {
                textArea.textContentType = textContentType
            }
        }
    }

    public var onValueChanged: ((String) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.makeView()
    }

    public convenience init(builder: ((TextArea) -> Void)? = nil) {
        self.init(frame: .zero)
        builder?(self)
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

    func makeTextArea() {
        textArea = UITextView()
        textArea.translatesAutoresizingMaskIntoConstraints = false
        textArea.delegate = self

        textArea.font = UIFont(
            name: Ocean.font.fontFamilyBaseWeightRegular,
            size: Ocean.font.fontSizeXs)
        textArea.textColor = Ocean.color.colorInterfaceDarkDeep
        textArea.textContainerInset = UIEdgeInsets(top: 13,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0)
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
        textArea.isEditable = isEnabled

        if errorMessage?.isEmpty == false {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorStatusNegativePure)
        } else if textArea.isFirstResponder {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorBrandPrimaryDown)
        } else if isActivated == false {
            changeColor(text: Ocean.color.colorInterfaceLightDeep,
                        border: Ocean.color.colorInterfaceLightDeep,
                        background: Ocean.color.colorInterfaceLightDown,
                        placeHolderColor: Ocean.color.colorInterfaceDarkUp)
        } else if isEnabled {
            changeColor(text: Ocean.color.colorInterfaceLightDeep,
                        border: Ocean.color.colorBrandPrimaryUp)
        } else {
            changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                        border: Ocean.color.colorBrandPrimaryDown)
        }
    }

    func changeColor(text: UIColor,
                     border: UIColor,
                     background: UIColor? = Ocean.color.colorInterfaceLightPure,
                     placeHolderColor: UIColor? = Ocean.color.colorInterfaceLightDeep) {
        self.textArea.textColor = text
        self.backgroundView.backgroundColor = background
        self.textArea.backgroundColor = background
        self.backgroundView.layer.borderColor = border.cgColor
        self.textArea.changePlaceholderColor(color: placeHolderColor!)
    }

    func makeView() {
        self.makemainStack()
        self.makeHStack()
        self.makeTextArea()
        self.makeLabelError()

        mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))

        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = Ocean.size.borderRadiusSm
        backgroundView.layer.borderWidth = Ocean.size.borderWidthHairline
        backgroundView.layer.borderColor = UIColor.blue.cgColor
        backgroundView.backgroundColor = Ocean.color.colorInterfaceLightPure

        hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        hStack.addArrangedSubview(textArea)
        hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))

        backgroundView.addSubview(Spacer(space: Ocean.size.spacingStackXxs))
        backgroundView.addSubview(hStack)
        mainStack.addArrangedSubview(backgroundView)

        mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
        mainStack.addArrangedSubview(labelError)

        self.addSubview(mainStack)

        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.heightAnchor.constraint(
            greaterThanOrEqualToConstant: height).isActive = true

        mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        hStack.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        hStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        hStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        hStack.heightAnchor.constraint(equalTo: backgroundView.heightAnchor).isActive = true

        updateState()
        textArea.setPlaceholder(text: placeholder)
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        updateState()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        updateState()
    }

    public func textViewDidChange(_ textView: UITextView) {
        updateState()
        onValueChanged?(textView.text ?? "")
        textArea.checkPlaceholder()
    }
}

extension UITextView {
    func changePlaceholderColor(color: UIColor) {
        if let placeholderLabel = self.viewWithTag(222) as? UILabel {
            placeholderLabel.textColor = color
        }
    }

    func setPlaceholder(text: String) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = text
        placeholderLabel.font = UIFont(
            name: Ocean.font.fontFamilyBaseWeightRegular,
            size: Ocean.font.fontSizeXs)
        placeholderLabel.textColor = Ocean.color.colorInterfaceDarkDeep
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 12)
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
    }

    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(222) as? UILabel
        placeholderLabel?.isHidden = !self.text.isEmpty
    }

}
