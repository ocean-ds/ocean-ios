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
    
    public class ButtonPrimary: UIControl {
        
        public enum Size {
            case medium
            case small
            case large
        }
        
        convenience init(builder: (ButtonPrimary) -> Void) {
            self.init()
            builder(self)
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
        private var fontSize: CGFloat = Ocean.font.fontSizeSm
        private var padding: CGFloat = Ocean.size.spacingInlineLg
        private var stack: UIStackView!
        private var label: UILabel!
        private var imageView: UIImageView!
        private var activityIndicator: UIActivityIndicatorView!
        
        public override var isEnabled: Bool {
            didSet {
                if isEnabled {
                    active()
                } else {
                    disabled()
                }
            }
        }
        
        func configMD() {
            iconSize = .init(width: 16, height: 16)
            minWidth = 108
            height = 48
            fontSize = Ocean.font.fontSizeSm
            padding = Ocean.size.spacingInlineLg
        }
        
        func configSM() {
            iconSize = .init(width: 10, height: 10)
            minWidth = 96
            height = 32
            fontSize = Ocean.font.fontSizeXxs
            padding = Ocean.size.spacingInlineMd
        }
        
        func configLG() {
            iconSize = .init(width: 16, height: 16)
            minWidth = 148
            height = 56
            fontSize = Ocean.font.fontSizeSm
            padding = Ocean.size.spacingInlineXl
        }
        
        func makeView() {
            stack = createStack()
            stack.addArrangedSubview(Spacer(space: padding))
            
            if let icon = self.icon?.withRenderingMode(.alwaysTemplate) {
                imageView = UIImageView(image: icon)
                stack.addArrangedSubview(imageView)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
                
                self.imageView.translatesAutoresizingMaskIntoConstraints = false
                self.imageView.widthAnchor.constraint(equalToConstant: self.iconSize.width).isActive = true
                self.imageView.heightAnchor.constraint(equalToConstant: self.iconSize.height).isActive = true
            }
            label = createLabel()
            
            stack.addArrangedSubview(label)
            
            stack.addArrangedSubview(Spacer(space: padding))
            
            self.addSubview(stack)
            
            stack.topSuperview()
            stack.bottomSuperview()
            stack.leadingSuperview()
            stack.trailingSuperview()
            
            self.backgroundColor = Ocean.color.colorBrandPrimaryPure
            self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
            self.translatesAutoresizingMaskIntoConstraints = false
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
            
            self.stack.isUserInteractionEnabled = false
            
            self.addTargets()
            
            let activityIndicator = self.createActivityIndicator()
            
            self.addSubview(activityIndicator)
            
            activityIndicator.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
            
            activityIndicator.stopAnimating()
        }
        
        private func createActivityIndicator() -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.hidesWhenStopped = true
            return activityIndicator
        }
        
        private func addTargets() {
            self.addTarget(self, action: #selector(pressed), for: .touchDown)
            self.addTarget(self, action: #selector(touchUpInSide), for: .touchUpInside)
            self.addTarget(self, action: #selector(touchUpOutSide), for: .touchUpOutside)
        }
        
        private func createStack() -> UIStackView {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillProportionally
            return stack
        }
        
        private func createLabel() -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: Ocean.font.fontSizeXs)
            label.textColor = Ocean.color.colorInterfaceLightPure
            label.text = text
            label.textAlignment = .center
            label.setLineHeight(lineHeight: Ocean.font.lineHeightTight)
            return label
        }
        
        private func changeColor(background: UIColor, label: UIColor? = nil) {
            
            guard self.label.textColor != label
                && backgroundColor != background else {
                    return
            }
            
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
            self.changeColor(background: Ocean.color.colorBrandPrimaryPure, label: Ocean.color.colorInterfaceLightPure)
        }
        
        func hover() {
            self.changeColor(background: Ocean.color.colorBrandPrimaryDown, label: Ocean.color.colorInterfaceLightPure)
        }
        
        @objc func pressed() {
            self.changeColor(background: Ocean.color.colorBrandPrimaryDeep, label: Ocean.color.colorInterfaceLightPure)
        }
        
        func focused() {
            self.changeColor(background: Ocean.color.colorBrandPrimaryDown, label: Ocean.color.colorInterfaceLightPure)
        }
        
        func disabled() {
            self.changeColor(background: Ocean.color.colorInterfaceLightDown, label: Ocean.color.colorInterfaceDarkUp)
        }
    }
}
