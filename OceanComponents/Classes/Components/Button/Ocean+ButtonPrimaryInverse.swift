//
//  Ocean+ButtonPrimaryInverse.swift
//  OceanComponents
//
//  Created by Alex Gomes on 04/08/20.
//

import Foundation
import OceanTokens

extension Ocean {
    final public class ButtonPrimaryInverse: UIControl {
        public enum Size {
            case medium
            case small
            case large
        }
        
        public convenience init(builder: ButtonPrimaryInverseBuilder) {
            self.init()
            builder(self)
            configType()
            makeView()
        }
        
        final public var size: ButtonPrimaryInverse.Size = .medium {
            didSet {
                switch size {
                case .large: configLG()
                case .medium: configMD()
                case .small: configSM()
                }
            }
        }
        final public var onTouch: (() -> Void)?
        final public var icon: UIImage?
        final public var text: String = "" {
            didSet {
                label?.text = text
            }
        }
        final public var isLoading: Bool = false {
            didSet {
                if isLoading {
                    startActivityIndicator()
                } else {
                    stopActivityIndicator()
                }
            }
        }
        
        final public var isBlocked: Bool = false
        
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
        private var stack: UIStackView!
        private var label: UILabel!
        private var imageView: UIImageView!
        private var activityIndicator: UIActivityIndicatorView!
        private var activeBackgroundColor: UIColor!
        private var activeLabelColor: UIColor!
        private var hoverBackgroundColor: UIColor!
        private var hoverLabelColor: UIColor!
        private var pressedBackgroundColor: UIColor!
        private var pressedLabelColor: UIColor!
        private var focusedBackgroundColor: UIColor!
        private var focusedLabelColor: UIColor!
        private var disabledBackgroundColor: UIColor!
        private var disabledLabelColor: UIColor!
        
        final public override var isEnabled: Bool {
            didSet {
                if isEnabled {
                    active()
                } else {
                    disabled()
                }
            }
        }
        
        final func configType() {
            activeBackgroundColor = Ocean.color.colorComplementaryPure
            activeLabelColor = Ocean.color.colorInterfaceLightPure
            hoverBackgroundColor = Ocean.color.colorComplementaryDown
            hoverLabelColor = Ocean.color.colorInterfaceLightPure
            pressedBackgroundColor = Ocean.color.colorComplementaryDeep
            pressedLabelColor = Ocean.color.colorInterfaceLightPure
            focusedBackgroundColor = Ocean.color.colorComplementaryDown
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
            stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fill
            
            stack.addArrangedSubview(Spacer(space: padding))
            var labelAlignment : NSTextAlignment = .center
            if let icon = self.icon?.withRenderingMode(.alwaysTemplate) {
                imageView = UIImageView(image: icon)
                imageView.tintColor = activeLabelColor
                stack.addArrangedSubview(imageView)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
                
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
            
            stack.addArrangedSubview(label)
            
            stack.addArrangedSubview(Spacer(space: padding))
            
            self.addSubview(stack)
            
            stack.topSuperview()
            stack.bottomSuperview()
            stack.leadingSuperview()
            stack.trailingSuperview()
            
            self.backgroundColor = activeBackgroundColor
            self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
            self.translatesAutoresizingMaskIntoConstraints = false
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
            
            self.stack.isUserInteractionEnabled = false
            
            self.addTarget(self, action: #selector(pressed), for: .touchDown)
            self.addTarget(self, action: #selector(touchUpInSide), for: .touchUpInside)
            self.addTarget(self, action: #selector(touchUpOutSide), for: .touchUpOutside)
            
            activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.hidesWhenStopped = true
            
            self.addSubview(activityIndicator)
            
            activityIndicator.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
            
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
        
        @objc final func touchUpInSide() {
            onTouch?()
            active()
        }
        
        @objc final func touchUpOutSide() {
            active()
        }
        
        final func stopActivityIndicator() {
            self.isUserInteractionEnabled = true
            self.label.alpha = 1
            self.imageView?.alpha = 1
            self.activityIndicator.stopAnimating()
        }
        
        final func startActivityIndicator() {
            self.isUserInteractionEnabled = false
            self.label.alpha = 0
            self.imageView?.alpha = 0
            activityIndicator.startAnimating()
        }
        
        final func active() {
            self.changeColor(background: activeBackgroundColor, label: activeLabelColor)
        }
        
        final func hover() {
            self.changeColor(background: hoverBackgroundColor, label: hoverLabelColor)
        }
        
        @objc final func pressed() {
            self.changeColor(background: pressedBackgroundColor, label: pressedLabelColor)
        }
        
        final func focused() {
            self.changeColor(background: focusedBackgroundColor, label: focusedLabelColor)
        }
        
        final func disabled() {
            self.changeColor(background: disabledBackgroundColor, label: disabledLabelColor)
        }
    }
}
