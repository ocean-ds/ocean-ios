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
        internal var mainStack: UIStackView!
        private var textArea: UITextView!
        //private var image: UIImage!
        private var labelError: UILabel!
        private var hStack: UIStackView!
        private var backgroundView: UIView!
        private var height: CGFloat = 78
        private var labelPlaceholder: UILabel!
        
        public var keyboardType: UIKeyboardType = .default {
            didSet {
                textArea?.keyboardType = keyboardType
            }
        }
        
        public var errorMessage: String? {
            get { labelError.text ?? "" }
            
            set {
                labelError.text = newValue
                self.updateState()
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
                //checkPlaceholder()
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
        
        func makeTextArea() {
            textArea = UITextView()
            textArea.translatesAutoresizingMaskIntoConstraints = false
            textArea.delegate = self
            
            textArea.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXs)
            textArea.textColor = Ocean.color.colorInterfaceDarkPure
            textArea.keyboardType = self.keyboardType
            textArea.autocorrectionType = .no
        }
        
        func makeLabelError() {
            labelError = UILabel()
            labelError.translatesAutoresizingMaskIntoConstraints = false
            labelError.font = UIFont(
                name: Ocean.font.fontFamilyBaseWeightRegular,
                size: Ocean.font.fontSizeXxxs)
            labelError.textColor = Ocean.color.colorStatusNegativePure
            labelError.heightAnchor.constraint(equalToConstant: 15.5).isActive = true
        }
        
        func updateState() {
            textArea.isEditable = isEnabled
            
            if errorMessage?.isEmpty == false {
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorStatusNegativePure)
                checkPlaceholder()
            } else if textArea.isFirstResponder {
                labelPlaceholder?.isHidden = true
                changeColor(text: Ocean.color.colorInterfaceDarkDeep,
                            border: Ocean.color.colorBrandPrimaryDown)
            } else if isActivated == false {
                
                checkPlaceholder()
                changeColor(text: Ocean.color.colorInterfaceLightDeep,
                            border: Ocean.color.colorInterfaceLightDeep,
                            background: Ocean.color.colorInterfaceLightDown,
                            placeHolderColor: Ocean.color.colorInterfaceLightDeep)
            } else if isEnabled {
                let isEmpty = self.textArea?.text?.isEmpty == true
                let color = isEmpty ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkDeep
                let border = isEmpty ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorBrandPrimaryUp
                changeColor(text: color,
                            border: border)
                checkPlaceholder()
            } else {
                changeColor(text: Ocean.color.colorInterfaceDarkUp,
                            border: Ocean.color.colorInterfaceLightDown,
                            background: Ocean.color.colorInterfaceLightDown,
                            placeHolderColor: Ocean.color.colorInterfaceDarkUp)
                checkPlaceholder()
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
            changePlaceholderColor(color: placeHolderColor!)
        }
        
        func makeView() {
            self.makemainStack()
            self.makeHStack()
            self.makeTextArea()
            self.makeLabelError()
            
            backgroundView = UIView()
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.ocean.borderWidth.applyThin()
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
                constant: Ocean.size.spacingStackXxs).isActive = true
            hStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
            hStack.bottomAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: -(Ocean.size.spacingStackXxs * 3)).isActive = true
            hStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
            
            updateState()
            setPlaceholder(text: placeholder)
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
    }
    
    
}

extension Ocean.TextArea {
    func changePlaceholderColor(color: UIColor) {
        if let placeholderLabel = self.viewWithTag(222) as? UILabel {
            placeholderLabel.textColor = color
        }
    }
    
    func setPlaceholder(text: String) {
        if (labelPlaceholder == nil) {
            labelPlaceholder = UILabel()
        }
        labelPlaceholder.text = text
        labelPlaceholder.font = UIFont(
            name: Ocean.font.fontFamilyBaseWeightRegular,
            size: Ocean.font.fontSizeXs)
        labelPlaceholder.textColor = Ocean.color.colorInterfaceLightDeep
        labelPlaceholder.sizeToFit()
        labelPlaceholder.tag = 222
        labelPlaceholder.frame.origin = CGPoint(
            x: Ocean.size.spacingStackXs,
            y: (Ocean.size.spacingInsetSm))
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
