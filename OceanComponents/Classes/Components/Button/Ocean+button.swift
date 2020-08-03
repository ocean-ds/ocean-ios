//
//  ButtonPrimary.swift
//  Blu
//
//  Created by Victor C Tavernari on 09/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

extension Ocean {
    public typealias ButtonPrimaryBuilder = (ButtonPrimary) -> Void
    public typealias ButtonSecondaryBuilder = (ButtonSecondary) -> Void
    
    
    public struct Button {
        
        public static func primarySM(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .small
                builder( button )
            }
        }
        
        public static func primaryMD(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .medium
                
                builder( button )
            }
        }
        
        public static func primaryLG(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .large
                builder( button )
            }
        }
        
        public static func secondarySM(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .small
                builder( button )
            }
        }
        
        public static func secondaryMD(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .medium
                
                builder( button )
            }
        }
        
        public static func secondaryLG(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .large
                builder( button )
            }
        }
    }
    
    public class ButtonPrimary: UIControl {
        public enum Size {
            case medium
            case small
            case large
        }
        
        public convenience init(builder: (ButtonPrimary) -> Void) {
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
        
        private var iconSize: CGSize = .init(width: 16, height: 16)
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
            iconSize = .init(width: 16, height: 16)
            minWidth = 108
            height = 48
            fontSize = Ocean.font.fontSizeXs
            padding = Ocean.size.spacingInlineSm
        }
        
        private func configSM() {
            iconSize = .init(width: 10, height: 10)
            minWidth = 96
            height = 32
            fontSize = Ocean.font.fontSizeXxs
            padding = Ocean.size.spacingInlineXs
        }
        
        private func configLG() {
            iconSize = .init(width: 16, height: 16)
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
            stack.distribution = .fillProportionally
            
            stack.addArrangedSubview(Spacer(space: padding))
            
            if let icon = self.icon?.withRenderingMode(.alwaysTemplate) {
                imageView = UIImageView(image: icon)
                stack.addArrangedSubview(imageView)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
                
                self.imageView.translatesAutoresizingMaskIntoConstraints = false
                self.imageView.widthAnchor.constraint(equalToConstant: self.iconSize.width).isActive = true
                self.imageView.heightAnchor.constraint(equalToConstant: self.iconSize.height).isActive = true
            }
            
            label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: fontSize)
            label.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
            label.textColor = activeLabelColor
            label.text = text
            label.textAlignment = .center
            
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
            self.activityIndicator.stopAnimating()
        }
        
        func startActivityIndicator() {
            self.isUserInteractionEnabled = false
            self.label.alpha = 0
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
    
    public class ButtonSecondary: UIControl {
        public enum Size {
            case medium
            case small
            case large
        }
        
        public convenience init(builder: (ButtonSecondary) -> Void) {
            self.init()
            builder(self)
            configType()
            makeView()
        }
        
        public var size: ButtonSecondary.Size = .medium {
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
        
        private var iconSize: CGSize = .init(width: 16, height: 16)
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
            activeBackgroundColor = Ocean.color.colorInterfaceLightUp
            activeLabelColor = Ocean.color.colorBrandPrimaryPure
            hoverBackgroundColor = Ocean.color.colorHighlightDown
            hoverLabelColor = Ocean.color.colorBrandPrimaryPure
            pressedBackgroundColor = Ocean.color.colorInterfaceDarkUp
            pressedLabelColor = Ocean.color.colorBrandPrimaryPure
            focusedBackgroundColor = Ocean.color.colorInterfaceLightDown
            focusedLabelColor = Ocean.color.colorBrandPrimaryPure
            disabledBackgroundColor = Ocean.color.colorInterfaceLightDown
            disabledLabelColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func configMD() {
            iconSize = .init(width: 16, height: 16)
            minWidth = 108
            height = 48
            fontSize = Ocean.font.fontSizeXs
            padding = Ocean.size.spacingInlineSm
        }
        
        private func configSM() {
            iconSize = .init(width: 10, height: 10)
            minWidth = 96
            height = 32
            fontSize = Ocean.font.fontSizeXxs
            padding = Ocean.size.spacingInlineXs
        }
        
        private func configLG() {
            iconSize = .init(width: 16, height: 16)
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
            stack.distribution = .fillProportionally
            
            stack.addArrangedSubview(Spacer(space: padding))
            
            if let icon = self.icon?.withRenderingMode(.alwaysTemplate) {
                imageView = UIImageView(image: icon)
                stack.addArrangedSubview(imageView)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
                
                self.imageView.translatesAutoresizingMaskIntoConstraints = false
                self.imageView.widthAnchor.constraint(equalToConstant: self.iconSize.width).isActive = true
                self.imageView.heightAnchor.constraint(equalToConstant: self.iconSize.height).isActive = true
            }
            
            label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: fontSize)
            label.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
            label.textColor = activeLabelColor
            label.text = text
            label.textAlignment = .center
            
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
            self.activityIndicator.stopAnimating()
        }
        
        func startActivityIndicator() {
            self.isUserInteractionEnabled = false
            self.label.alpha = 0
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
