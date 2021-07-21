//
//  Ocean+ButtonPrimary.swift
//  OceanComponents
//
//  Created by Alex Gomes on 03/08/20.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ButtonPrimary: UIControl {
        public enum Size {
            case medium
            case small
            case large
        }
        
        public convenience init(builder: ButtonPrimaryBuilder) {
            self.init()
            builder(self)
            configType()
            makeView()
        }
        
        public var size: ButtonPrimary.Size = .medium {
            didSet {
                switch size {
                case .large: configLG()
                case .medium: configMD()
                case .small: configSM()
                }
            }
        }
        public var onTouch: (() -> Void)?
        public var icon: UIImage?
        public var text: String = "" {
            didSet {
                label?.text = text
            }
        }
        public var isLoading: Bool = false {
            didSet {
                if isLoading {
                    startActivityIndicator()
                } else {
                    stopActivityIndicator()
                }
            }
        }
        
        public var isBlocked: Bool = false
        
        public var isPressed: Bool = false {
            didSet {
                if isPressed {
                    self.changeColor(background: pressedBackgroundColor, label: pressedLabelColor)
                } else {
                    self.changeColor(background: activeBackgroundColor, label: activeLabelColor)
                }
            }
        }
        
        private var iconSize: CGSize = .init(width: 24, height: 24)
        private var minWidth: CGFloat = 108
        private var height: CGFloat = 48
        private var fontSize: CGFloat = Ocean.font.fontSizeXs
        private var padding: CGFloat = Ocean.size.spacingInlineSm
        private var label: UILabel!
        private var imageView: UIImageView!
        private var activityIndicator: UIActivityIndicatorView!
        
        internal var activeBackgroundColor: UIColor!
        internal var activeLabelColor: UIColor!
        internal var hoverBackgroundColor: UIColor!
        internal var hoverLabelColor: UIColor!
        internal var pressedBackgroundColor: UIColor!
        internal var pressedLabelColor: UIColor!
        internal var focusedBackgroundColor: UIColor!
        internal var focusedLabelColor: UIColor!
        internal var disabledBackgroundColor: UIColor!
        internal var disabledLabelColor: UIColor!

        private var paddingLeftConstraints: NSLayoutConstraint!
        private var paddingRightConstraints: NSLayoutConstraint!
        
        public override var isEnabled: Bool {
            didSet {
                if isEnabled {
                    active()
                } else {
                    disabled()
                }
            }
        }
        
        func configType() {
            activeBackgroundColor = Ocean.color.colorBrandPrimaryPure
            activeLabelColor = Ocean.color.colorInterfaceLightPure
            hoverBackgroundColor = Ocean.color.colorBrandPrimaryDown
            hoverLabelColor = Ocean.color.colorInterfaceLightPure
            pressedBackgroundColor = Ocean.color.colorBrandPrimaryDeep
            pressedLabelColor = Ocean.color.colorInterfaceLightPure
            focusedBackgroundColor = Ocean.color.colorBrandPrimaryDown
            focusedLabelColor = Ocean.color.colorInterfaceLightPure
            disabledBackgroundColor = Ocean.color.colorInterfaceLightDown
            disabledLabelColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func configMD() {
            iconSize = .init(width: 24, height: 24)
            minWidth = 108
            height = 48
            fontSize = Ocean.font.fontSizeXs
            padding = Ocean.size.spacingInlineSm
        }
        
        private func configSM() {
            iconSize = .init(width: 16, height: 16)
            minWidth = 96
            height = 32
            fontSize = Ocean.font.fontSizeXxs
            padding = Ocean.size.spacingInlineXs
        }
        
        private func configLG() {
            iconSize = .init(width: 24, height: 24)
            minWidth = 148
            height = 56
            fontSize = Ocean.font.fontSizeSm
            padding = Ocean.size.spacingInlineMd
        }
        
        private func makeView() {
            let contentStack = UIStackView()
            contentStack.translatesAutoresizingMaskIntoConstraints = false
            contentStack.axis = .horizontal
            contentStack.alignment = .center
            contentStack.distribution = .fill

            var labelAlignment: NSTextAlignment = .center
            if let icon = self.icon?.withRenderingMode(.alwaysTemplate) {
                imageView = UIImageView(image: icon)
                imageView.tintColor = activeLabelColor
                contentStack.addArrangedSubview(imageView)
                contentStack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
                self.imageView.isUserInteractionEnabled = false
                self.imageView.translatesAutoresizingMaskIntoConstraints = false
                self.imageView.widthAnchor.constraint(equalToConstant: self.iconSize.width).isActive = true
                self.imageView.heightAnchor.constraint(equalToConstant: self.iconSize.height).isActive = true
                labelAlignment = .left
            }
            
            label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: fontSize)
            label.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
            label.textColor = activeLabelColor
            label.text = text
            label.textAlignment = labelAlignment
            label.isUserInteractionEnabled = false
            contentStack.isUserInteractionEnabled = false
            contentStack.addArrangedSubview(label)
            self.addSubview(contentStack)
            
            self.backgroundColor = activeBackgroundColor
            self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
            self.translatesAutoresizingMaskIntoConstraints = false
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true

            self.addTarget(self, action: #selector(pressed), for: .touchDown)
            self.addTarget(self, action: #selector(touchUpInSide), for: .touchUpInside)
            self.addTarget(self, action: #selector(touchUpOutSide), for: .touchUpOutside)
            
            activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.hidesWhenStopped = true
            activityIndicator.isUserInteractionEnabled = false
            self.addSubview(activityIndicator)
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            paddingLeftConstraints = contentStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding)
            paddingRightConstraints = contentStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding)
            self.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
            
            activityIndicator.stopAnimating()
        }
        
        final public override func didMoveToSuperview() {
            if (self.isBlocked) {
                if (self.superview?.leftAnchor != nil) {
                    self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor).isActive = true
                }
                if (self.superview?.rightAnchor != nil) {
                    self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor).isActive = true
                }
            }

            paddingLeftConstraints.isActive = !isBlocked
            paddingRightConstraints.isActive = !isBlocked
            self.updateConstraintsIfNeeded()
        }
        
        private func changeColor(background: UIColor, label: UIColor? = nil) {
            self.layer.removeAllAnimations()
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                if let labelColor = label {
                    self.label.textColor = labelColor
                    self.imageView?.tintColor = labelColor
                }
                self.backgroundColor = background
            })
        }
        
        @objc func touchUpInSide() {
            onTouch?()
            active()
        }
        
        @objc func touchUpOutSide() {
            active()
        }
        
        func stopActivityIndicator() {
            self.isUserInteractionEnabled = true
            self.label.alpha = 1
            self.imageView?.alpha = 1
            self.activityIndicator.stopAnimating()
        }
        
        func startActivityIndicator() {
            self.isUserInteractionEnabled = false
            self.label.alpha = 0
            self.imageView?.alpha = 0
            activityIndicator.startAnimating()
        }
        
        func active() {
            self.changeColor(background: activeBackgroundColor, label: activeLabelColor)
        }
        
        func hover() {
            self.changeColor(background: hoverBackgroundColor, label: hoverLabelColor)
        }
        
        @objc func pressed() {
            self.changeColor(background: pressedBackgroundColor, label: pressedLabelColor)
        }
        
        func focused() {
            self.changeColor(background: focusedBackgroundColor, label: focusedLabelColor)
        }
        
        func disabled() {
            self.changeColor(background: disabledBackgroundColor, label: disabledLabelColor)
        }
    }
}
