//
//  Ocean+RadioButton.swift
//  OceanComponents
//
//  Created by Vini on 18/06/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class RadioButton: UIControl {
        public typealias RadioButtonBuilder = (RadioButton) -> Void
        
        internal let generator = UISelectionFeedbackGenerator()
        
        private var mainStack: Ocean.StackView!
        private var radioBkgView: UIControl!
        private var radioStack: Ocean.StackView!
        private var textLabel: UILabel!

        public var label: String = "" {
            didSet {
                textLabel?.text = label
                textLabel?.isHidden = label.isEmpty
            }
        }

        public var isInteractionEnabled: Bool = true {
            didSet {
                updateState()
            }
        }

        public var onTouch: (() -> Void)?

        override init(frame: CGRect) {
            super.init(frame: frame)
            makeView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            makeView()
        }

        public convenience init(builder: RadioButtonBuilder) {
            self.init(frame: .zero)
            builder(self)
        }

        public override var isSelected: Bool {
            didSet {
                updateState()
            }
        }

        public override var isEnabled: Bool {
            didSet {
                updateState()
            }
        }

        public override var isUserInteractionEnabled: Bool {
            didSet {
                updateState()
            }
        }

        private var backgroundCircleLayer: CAShapeLayer!
        private var foregroundCircleLayer: CAShapeLayer!

        internal var size: CGFloat = 24
        
        internal var withAnimation: Bool {
            get {
                return true
            }
        }

        internal var backgroundPath: CGPath {
            get {
                return UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).cgPath
            }
        }

        internal var foregroundShrinkPath: CGPath {
            get {
                let circleSize = size * 0.3
                let center = size * 0.5 - circleSize * 0.5
                return UIBezierPath(ovalIn: CGRect(x: center, y: center, width: circleSize, height: circleSize)).cgPath
            }
        }

        internal var foregroundExpandPath: CGPath {
            get {
                let circleSize = size * 0.9
                let center = size * 0.5 - circleSize * 0.5
                return UIBezierPath(ovalIn: CGRect(x: center, y: center, width: circleSize, height: circleSize)).cgPath
            }
        }

        @objc internal func toogleRadio() {
            isSelected = true
            onTouch?()
            generator.selectionChanged()
        }

        private func updateState() {
            if isSelected {
                changeToChecked()
            } else {
                changeToUnchecked()
            }
            
            textLabel.textColor = isEnabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorInterfaceLightDeep
        }

        func makeView() {
            mainStack = Ocean.StackView()
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.axis = .vertical
            mainStack.alignment = .leading
            mainStack.distribution = .fillProportionally
            mainStack.isUserInteractionEnabled = true

            radioStack = Ocean.StackView()
            radioStack.translatesAutoresizingMaskIntoConstraints = false
            radioStack.axis = .horizontal
            radioStack.alignment = .center
            radioStack.distribution = .fill
            mainStack.addArrangedSubview(radioStack)

            radioBkgView = UIControl()
            radioBkgView.translatesAutoresizingMaskIntoConstraints = false

            if backgroundColor == nil || backgroundColor == UIColor.clear {
                backgroundColor = Ocean.color.colorInterfaceLightPure
            }

            radioBkgView.heightAnchor.constraint(equalToConstant: size).isActive = true
            radioBkgView.widthAnchor.constraint(equalToConstant: size).isActive = true

            backgroundCircleLayer = CAShapeLayer()
            backgroundCircleLayer.path = backgroundPath
            backgroundCircleLayer.fillColor = Ocean.color.colorInterfaceLightPure.cgColor

            foregroundCircleLayer = CAShapeLayer()
            foregroundCircleLayer.path = foregroundShrinkPath
            foregroundCircleLayer.fillColor = Ocean.color.colorInterfaceLightPure.cgColor

            radioBkgView.layer.addSublayer(backgroundCircleLayer)
            radioBkgView.layer.addSublayer(foregroundCircleLayer)

            textLabel = Ocean.Typography.paragraph { paragraph in
                paragraph.translatesAutoresizingMaskIntoConstraints = false
                paragraph.text = self.label
                paragraph.isHidden = self.label.isEmpty
            }

            radioStack.addArrangedSubview(radioBkgView)
            radioStack.addArrangedSubview(Ocean.Spacer(space: Ocean.size.spacingInsetXxs))
            radioStack.addArrangedSubview(textLabel)

            self.addSubview(mainStack)
            let tapIconGesture = UITapGestureRecognizer(target: self, action: #selector(toogleRadio))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapIconGesture)

            mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            radioStack.heightAnchor.constraint(equalToConstant: 24).isActive = true
            radioStack.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true

            self.updateState()
        }

        private func changeToChecked() {
            changeForegroundCircle(path: foregroundShrinkPath)
            let color = isEnabled ? Ocean.color.colorComplementaryPure : Ocean.color.colorInterfaceLightDown
            changeShapeColorOf(layer: backgroundCircleLayer, color: color)
            radioBkgView.isUserInteractionEnabled = self.isInteractionEnabled
        }

        private func changeToUnchecked() {
            changeForegroundCircle(path: foregroundExpandPath)
            let backgroundCircleColor = isEnabled ? Ocean.color.colorInterfaceDarkUp : Ocean.color.colorInterfaceLightDown
            changeShapeColorOf(layer: backgroundCircleLayer, color: backgroundCircleColor)

            if let foregroundCircleColor = isEnabled ? Ocean.color.colorInterfaceLightPure : backgroundColor {
                changeShapeColorOf(layer: foregroundCircleLayer, color: foregroundCircleColor)
            }

            radioBkgView.isUserInteractionEnabled = self.isInteractionEnabled
        }

        internal func changeForegroundCircle(path: CGPath) {
            guard path != foregroundCircleLayer.path else {
                return
            }
            
            let key = "foregroundRadioPath"
            layer.removeAnimation(forKey: key)

            if withAnimation {
                let animation = CABasicAnimation(keyPath: "path")
                animation.duration = 0.3
                animation.fromValue = foregroundCircleLayer.path
                animation.toValue = path
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                foregroundCircleLayer.add(animation, forKey: key)
            }
            
            foregroundCircleLayer.path = path
        }

        private func changeShapeColorOf(layer: CAShapeLayer, color: UIColor) {
            guard layer.fillColor != color.cgColor else {
                return
            }

            let key = "backgroundRadioColor"
            layer.removeAnimation(forKey: key)

            let animation = CABasicAnimation(keyPath: "fillColor")
            animation.duration = 0.6
            animation.fromValue = layer.fillColor
            animation.toValue = color.cgColor
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            layer.fillColor = color.cgColor
            layer.add(animation, forKey: key)
        }
        
        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.radioBkgView.isSkeletonable = true
            self.radioStack.isSkeletonable = true
            self.textLabel.isSkeletonable = true
        }
    }
}
