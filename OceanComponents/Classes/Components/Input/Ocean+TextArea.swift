//
//  Ocean+TextArea.swift
//  OceanComponents
//
//  Created by Alex Gomes on 07/08/20.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class TextArea: UIControl, UITextViewDelegate {
        public var mainStack: UIStackView!
        public var textArea: UITextView!
        public var labelTitle: UILabel!
        public var labelError: UILabel!
        public var labelHelper: UILabel!
        public var hStack: UIStackView!
        public var backgroundView: UIView!
        public var labelPlaceholder: UILabel!
        public var titleStackContent: UIStackView!
        public var titleStackView: UIStackView!
        public var infoIconImageView: UIImageView!
        
        private var height: CGFloat = 78
        private let errorEmpty = "..."
        
        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.message = infoMessage
            }
        }()
        
        public var title: String  = "" {
            didSet {
                labelTitle?.text = isOptional ? "\(title) (opcional)" : title
            }
        }
        
        public var isOptional: Bool = false {
            didSet {
                labelTitle?.text = isOptional ? "\(title) (opcional)" : title
            }
        }
        
        public var infoMessage: String = "" {
            didSet {
                infoIconImageView?.isHidden = infoMessage.isEmpty
                tooltip.message = infoMessage
            }
        }

        public var keyboardType: UIKeyboardType = .default {
            didSet {
                textArea?.keyboardType = keyboardType
            }
        }
        
        public var errorMessage: String? {
            get { labelError.text ?? "" }
            
            set {
                labelError.text = newValue == nil || newValue?.isEmpty == true ? errorEmpty : newValue
                self.updateState()
            }
        }
        
        public var charactersLimitNumber: Int? = nil {
            didSet {
                guard let limitValue = charactersLimitNumber else { return }
                labelHelper?.text = "\(textArea.text?.count ?? 0)/\(limitValue)"
            }
        }
        
        public var placeholder: String = "" {
            didSet {
                setPlaceholder(text: placeholder)
            }
        }
        
        public var text: String {
            get { textArea.text ?? "" }
            
            set {
                textArea.text = newValue
                self.updateState()
            }
        }
        
        public var helper: String = " " {
            didSet {
                labelHelper?.text = helper
                self.updateState()
            }
        }
        
        public var numberOfLines: Int = 2 {
            didSet {
                if numberOfLines > 2 {
                    textArea.textContainer.maximumNumberOfLines = numberOfLines - 1
                    height = (height / 2) * CGFloat(numberOfLines)
                    makeView()
                }
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
        public var onBeginEditing: (() -> Void)?
        public var onInfoIconTouched: (() -> Void)?
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.makeView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.makeView()
        }
        
        public convenience init(builder: TextAreaBuilder) {
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
        
        func makeLabel() {
            labelTitle = UILabel()
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxs)
            labelTitle.textColor = Ocean.color.colorInterfaceDarkDown
        }
        
        func makeTextArea() {
            textArea = UITextView()
            textArea.translatesAutoresizingMaskIntoConstraints = false
            textArea.delegate = self
            textArea.isScrollEnabled = true
            textArea.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXs)
            textArea.textColor = Ocean.color.colorInterfaceDarkPure
            textArea.keyboardType = self.keyboardType
            textArea.autocorrectionType = .no
        }
        
        func makeTitleStackContent() {
            makeTitleStackView()
            titleStackContent = UIStackView()
            titleStackContent.axis = .vertical
            titleStackContent.alignment = .leading
            titleStackContent.distribution = .fillProportionally
            titleStackContent.addArrangedSubview(Spacer(space: 5))
            titleStackContent.addArrangedSubview(titleStackView)
        }
        
        func makeTitleStackView() {
            makeLabel()
            makeInfoIconImageView()
            titleStackView = UIStackView()
            titleStackView.axis = .horizontal
            titleStackView.alignment = .center
            titleStackView.distribution = .fill
            titleStackView.spacing = 5
            titleStackView.addArrangedSubview(labelTitle)
            titleStackView.addArrangedSubview(infoIconImageView)
        }
        
        private func makeInfoIconImageView() {
            infoIconImageView = UIImageView()
            infoIconImageView.image = Ocean.icon.informationCircleSolid?.withRenderingMode(.alwaysTemplate)
            infoIconImageView.tintColor = Ocean.color.colorInterfaceDarkUp
            infoIconImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                infoIconImageView.heightAnchor.constraint(equalToConstant: 12.8),
                infoIconImageView.widthAnchor.constraint(equalToConstant: 12.8)
            ])
            infoIconImageView.isUserInteractionEnabled = true
            infoIconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoAction)))
            infoIconImageView.isHidden = infoMessage.isEmpty
        }
        
        func makeLabelError() {
            labelError = UILabel()
            labelError.translatesAutoresizingMaskIntoConstraints = false
            labelError.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            labelError.textColor = Ocean.color.colorStatusNegativePure
            labelError.heightAnchor.constraint(equalToConstant: 15.5).isActive = true
            labelError.text = errorEmpty
            labelError.isHidden = true
        }
        
        func makeLabelHelper() {
            labelHelper = UILabel()
            labelHelper.translatesAutoresizingMaskIntoConstraints = false
            labelHelper.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            labelHelper.textColor = Ocean.color.colorInterfaceDarkUp
            labelHelper.text = helper
            labelHelper.isHidden = false
        }
        
        @objc func infoAction(_ sender: Any) {
            onInfoIconTouched?()
            tooltip.show(target: infoIconImageView, presenter: self)
        }
        
        func updateState() {
            textArea.isEditable = isEnabled
            labelError?.isHidden = true
            labelHelper?.isHidden = false
            
            if errorMessage != errorEmpty {
                labelError?.isHidden = false
                labelHelper?.isHidden = true
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorStatusNegativePure,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                checkPlaceholder()
                backgroundView?.ocean.borderWidth.applyHairline()
            } else if textArea.isFirstResponder {
                labelPlaceholder?.isHidden = true
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorBrandPrimaryDown,
                            labelTitle: Ocean.color.colorInterfaceDarkDown)
                backgroundView?.ocean.borderWidth.applyThin()
            } else if isActivated == false {
                checkPlaceholder()
                changeColor(text: Ocean.color.colorInterfaceLightDeep,
                            border: Ocean.color.colorInterfaceLightDeep,
                            labelTitle: Ocean.color.colorInterfaceDarkUp)
                backgroundView?.ocean.borderWidth.applyHairline()
            } else if isEnabled {
                let isActivated = self.textArea?.text?.isEmpty == true
                let color = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDeep
                let border = isActivated ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorBrandPrimaryUp
                let labelColor = Ocean.color.colorInterfaceDarkDown
                changeColor(text: color,
                            border: border,
                            labelTitle: labelColor)
                checkPlaceholder()
                backgroundView?.ocean.borderWidth.applyHairline()
            } else {
                changeColor(text: Ocean.color.colorInterfaceDarkUp,
                border: Ocean.color.colorInterfaceLightDown,
                background: Ocean.color.colorInterfaceLightDown,
                placeHolderColor: Ocean.color.colorInterfaceDarkUp,
                labelTitle: Ocean.color.colorInterfaceDarkUp)
                checkPlaceholder()
                backgroundView?.ocean.borderWidth.applyHairline()
            }
            
            if let limitValue = self.charactersLimitNumber {
                labelHelper?.text = "\(textArea.text?.count ?? 0)/\(limitValue)"
            }
        }
        
        func charactersLimitValidator() -> Bool {
            guard let textCount = textArea.text?.count, let limitValue = charactersLimitNumber else { return true }
            return textCount < limitValue
        }
        
        func changeColor(text: UIColor,
                         border: UIColor,
                         background: UIColor? = Ocean.color.colorInterfaceLightPure,
                         placeHolderColor: UIColor? = Ocean.color.colorInterfaceLightDeep,
                         labelTitle: UIColor ) {
            self.textArea.textColor = text
            self.backgroundView.backgroundColor = background
            self.textArea.backgroundColor = background
            self.backgroundView.layer.borderColor = border.cgColor
            self.labelTitle.textColor = labelTitle
            changePlaceholderColor(color: placeHolderColor!)
        }
        
        func makeView() {
            self.makemainStack()
            self.makeHStack()
            self.makeTitleStackContent()
            self.makeTextArea()
            self.makeLabelError()
            self.makeLabelHelper()
            
            mainStack.addArrangedSubview(titleStackContent)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
            
            backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.ocean.borderWidth.applyHairline()
            backgroundView.ocean.radius.applySm()
            backgroundView.backgroundColor = Ocean.color.colorInterfaceLightPure
            
            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs - 4))
            hStack.addArrangedSubview(textArea)
            hStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            
            backgroundView.addSubview(Spacer(space: Ocean.size.spacingStackXs))
            backgroundView.addSubview(hStack)
            
            mainStack.addArrangedSubview(backgroundView)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxxs))
            
            mainStack.addArrangedSubview(labelError)
            mainStack.addArrangedSubview(labelHelper)
            
            self.addSubview(mainStack)
            
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            backgroundView.heightAnchor.constraint(
                greaterThanOrEqualToConstant: height).isActive = true
            
            mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            hStack.topAnchor.constraint(
                equalTo: backgroundView.topAnchor,
                constant: Ocean.size.spacingStackXxxs).isActive = true
            hStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
            hStack.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -Ocean.size.spacingStackXxxs).isActive = true
            hStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
            
            labelPlaceholder = UILabel()
            
            if ((labelTitle?.text?.isEmpty) != nil) {
                labelPlaceholder.frame.origin = CGPoint(
                    x: Ocean.size.spacingStackXs,
                    y: Ocean.size.spacingInsetSm)
            } else {
                labelPlaceholder.frame.origin = CGPoint(
                    x: Ocean.size.spacingStackXs,
                    y: Ocean.size.spacingInsetXl)
            }
            setPlaceholder(text: placeholder)
            updateState()
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            self.onBeginEditing?()
            labelPlaceholder?.isHidden = true
            updateState()
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            updateState()
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            updateState()
            onValueChanged?(textView.text ?? "")
        }
        
        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            updateState()
            guard !text.isEmpty else { return true }
            return charactersLimitValidator()
        }
        
        public override func becomeFirstResponder() -> Bool {
            return textArea?.becomeFirstResponder() == true
        }

        public override func resignFirstResponder() -> Bool {
            return textArea?.resignFirstResponder() == true
        }
    }
}

extension Ocean.TextArea {
    func changePlaceholderColor(color: UIColor) {
        if let placeholderLabel = self.viewWithTag(222) as? UILabel {
            placeholderLabel.textColor = color
        }
    }
    
    func setPlaceholder(text: String) {
        labelPlaceholder.text = text
        labelPlaceholder.font = UIFont(
            name: Ocean.font.fontFamilyBaseWeightRegular,
            size: Ocean.font.fontSizeXs)
        labelPlaceholder.textColor = Ocean.color.colorInterfaceLightDeep
        labelPlaceholder.sizeToFit()
        labelPlaceholder.tag = 222
        
        labelPlaceholder.isHidden = !self.text.isEmpty
        
        self.addSubview(labelPlaceholder)
    }
    
    func checkPlaceholder() {
        if self.text.isEmpty == true {
            labelPlaceholder?.isHidden = false
        } else {
            labelPlaceholder?.isHidden = true
        }
    }
}
