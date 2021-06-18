//
//  Ocean+Switch.swift
//  OceanComponents
//
//  Created by Vini on 10/06/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class Switch: UIControl {
        public typealias SwitchBuilder = (Switch) -> Void
        
        public var onValueChanged: ((Bool) -> Void)?
        
        private var privateIsOn: Bool = true
        public var isOn: Bool {
            get {
                return privateIsOn
            }
            set {
                self.setOn(on: newValue, animated: true)
            }
        }
        
        private let generator = UISelectionFeedbackGenerator()
        private var animationDelay: Double = 0
        private var animationSpriteWithDamping = CGFloat(0.7)
        private var initialSpringVelocity = CGFloat(0.5)
        private var animationOptions: UIView.AnimationOptions = [.curveEaseOut,
                                                                .beginFromCurrentState,
                                                                .allowUserInteraction]
        private var animationDuration: Double = 0.5
        private var padding: CGFloat = 4
        private var onTintColor: UIColor = Ocean.color.colorComplementaryPure
        private var offTintColor: UIColor = Ocean.color.colorInterfaceLightPure
        private var onThumbTintColor: UIColor = .white
        private var offThumbTintColor: UIColor = Ocean.color.colorInterfaceDarkUp
        private var onBorderTintColor: UIColor = Ocean.color.colorComplementaryPure
        private var offBorderTintColor: UIColor = Ocean.color.colorInterfaceDarkUp
        private var cornerRadius: CGFloat = 0.5
        private var thumbCornerRadius: CGFloat = 0.5
        private var thumbSize: CGSize = CGSize.zero
        private var thumbView = UIView(frame: CGRect.zero)
        private var onPoint = CGPoint.zero
        private var offPoint = CGPoint.zero
        private var isAnimating = false
        
        public convenience init(builder: SwitchBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: 44, height: 24)
            }
        }
        
        fileprivate func setupUI() {
            self.clear()
            
            self.clipsToBounds = false
            
            self.thumbView.backgroundColor = self.isOn ? self.onThumbTintColor : self.offThumbTintColor
            self.thumbView.isUserInteractionEnabled = false
            
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            self.layer.borderWidth = Ocean.size.borderWidthHairline
            self.layer.borderColor = self.isOn ? self.onBorderTintColor.cgColor : self.offBorderTintColor.cgColor
            
            self.addSubview(self.thumbView)
            
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: 44),
                self.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
        
        private func clear() {
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
        
        override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
            super.beginTracking(touch, with: event)
            
            self.animate()
            self.onValueChanged?(self.privateIsOn)
            generator.selectionChanged()
            
            return true
        }
        
        private func setOn(on: Bool, animated: Bool) {
            switch animated {
            case true:
                self.animate(on: on)
            case false:
                self.privateIsOn = on
                self.setupViewsOnAction()
                self.completeAction()
            }
            
            self.onValueChanged?(self.privateIsOn)
            generator.selectionChanged()
        }
        
        fileprivate func animate(on: Bool? = nil) {
            self.privateIsOn = on ?? !self.isOn
            
            self.isAnimating = true
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
                self.setupViewsOnAction()
            }, completion: { _ in
                self.completeAction()
            })
        }
        
        private func setupViewsOnAction() {
            self.thumbView.backgroundColor = self.isOn ? self.onThumbTintColor : self.offThumbTintColor
            self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            self.layer.borderColor = self.isOn ? self.onBorderTintColor.cgColor : self.offBorderTintColor.cgColor
        }

        private func completeAction() {
            self.isAnimating = false
            self.sendActions(for: UIControl.Event.valueChanged)
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            if !self.isAnimating {
                self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
                self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
                
                let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 8, height: self.bounds.height - 8)
                let yPostition = (self.bounds.size.height - thumbSize.height) / 2
                
                self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
                self.offPoint = CGPoint(x: self.padding, y: yPostition)
                
                self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
                self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            }
        }
    }
}
