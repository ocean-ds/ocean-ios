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
        private var padding: CGFloat = 2
        private let width: CGFloat = 40
        private let height: CGFloat = 20
        private var onTintColor: UIColor = Ocean.color.colorComplementaryPure
        private var offTintColor: UIColor = Ocean.color.colorInterfaceLightPure
        private var onThumbTintColor: UIColor = .white
        private var offThumbTintColor: UIColor = Ocean.color.colorInterfaceDarkUp
        private var onBorderTintColor: UIColor = Ocean.color.colorComplementaryPure
        private var offBorderTintColor: UIColor = Ocean.color.colorInterfaceDarkUp
        private var cornerRadius: CGFloat = 0.5
        private var thumbCornerRadius: CGFloat = 0.5
        private var thumbSize: CGSize = CGSize(width: 14, height: 14)
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
                return CGSize(width: width, height: height)
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
                self.widthAnchor.constraint(equalToConstant: width),
                self.heightAnchor.constraint(equalToConstant: height)
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
                
                let yPostition = (self.bounds.size.height - self.thumbSize.height) / 2
                
                self.onPoint = CGPoint(x: self.bounds.size.width - self.thumbSize.width - self.padding, y: yPostition)
                self.offPoint = CGPoint(x: self.padding, y: yPostition)
                
                self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: self.thumbSize)
                self.thumbView.layer.cornerRadius = self.thumbSize.height * self.thumbCornerRadius
            }
        }

        public func setOn(on: Bool, animated: Bool) {
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
    }
}
