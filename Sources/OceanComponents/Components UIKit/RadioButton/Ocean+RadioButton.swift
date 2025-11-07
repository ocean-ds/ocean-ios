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

        public var text: String = "" {
            didSet {
                textLabel.text = text
                textLabel.numberOfLines = 0
                textLabel.isHidden = text.isEmpty

                textView.isHidden = true

                textStack.isHidden = textLabel.isHidden && textView.isHidden && descriptionLabel.isHidden
            }
        }

        public var attributedText: NSAttributedString? = nil {
            didSet {
                textView.attributedText = attributedText
                textView.isHidden = attributedText?.length == .zero

                textLabel.isHidden = true

                textStack.isHidden = textLabel.isHidden && textView.isHidden && descriptionLabel.isHidden
            }
        }

        public var descriptionText: String = "" {
            didSet {
                descriptionLabel.text = descriptionText
                descriptionLabel.numberOfLines = 0
                descriptionLabel.isHidden = descriptionText.isEmpty

                stackAlignment = descriptionText.isEmpty ? .top : .center

                textStack.isHidden = textLabel.isHidden && textView.isHidden && descriptionLabel.isHidden
            }
        }

        public var buttonTitle: String? = nil {
            didSet {
                button.setTitle(buttonTitle, for: .normal)
                buttonContainer.isHidden = buttonTitle?.isEmpty == true
            }
        }

        public var badgeNumber: Int? {
            didSet {
                updateBadge()
            }
        }

        public var stackAlignment: UIStackView.Alignment = .top {
            didSet {
                radioStack.alignment = stackAlignment
            }
        }

        public var errorMessage: String = "" {
            didSet {
                errorLabel.text = errorMessage.isEmpty ? errorEmpty : errorMessage
                updateState()
            }
        }

        public var isInteractionEnabled: Bool = true {
            didSet {
                updateState()
            }
        }

        public var textIsRight: Bool = false {
            didSet {
                rebuildStackForTextPosition()
            }
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

        public var onTouch: (() -> Void)?
        public var onTouchButton: (() -> Void)?

        private let errorEmpty = "..."

        internal let generator = UISelectionFeedbackGenerator()
        internal var size: CGFloat = 20
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

        private lazy var backgroundCircleLayer: CAShapeLayer = {
            let shape = CAShapeLayer()
            shape.path = backgroundPath
            shape.fillColor = Ocean.color.colorInterfaceLightPure.cgColor
            return shape
        }()

        private lazy var foregroundCircleLayer: CAShapeLayer = {
            let shape = CAShapeLayer()
            shape.path = foregroundShrinkPath
            shape.fillColor = Ocean.color.colorInterfaceLightPure.cgColor
            return shape
        }()

        private lazy var radioBkgView: UIControl = {
            let view = UIControl()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.addSublayer(backgroundCircleLayer)
            view.layer.addSublayer(foregroundCircleLayer)
            return view
        }()

        private lazy var textLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.text = self.text
                label.isHidden = self.text.isEmpty
            }
        }()

        private lazy var textView: UITextView = {
            let view = UITextView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = .baseRegular(size: Ocean.font.fontSizeXs)
            view.textColor = Ocean.color.colorInterfaceDarkPure
            view.tintColor = Ocean.color.colorBrandPrimaryPure
            view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            view.isScrollEnabled = false
            view.isEditable = false
            view.text = self.text
            view.isHidden = self.attributedText?.length == .zero
            return view
        }()

        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
                label.text = self.descriptionText
                label.isHidden = self.descriptionText.isEmpty
            }
        }()

        private lazy var badgeView: Ocean.BadgeNumber = {
            let badge = Ocean.Badge.number()
            badge.status = .warning
            badge.size = .small
            badge.translatesAutoresizingMaskIntoConstraints = false
            badge.isHidden = true
            return badge
        }()

        private lazy var textStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = 0

                stack.add([
                    textLabel,
                    textView,
                    descriptionLabel
                ])
            }
        }()

        private lazy var trailingStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.alignment = .center
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXs

                stack.add([
                    badgeView,
                    radioBkgView
                ])
            }
        }()

        private lazy var radioStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.alignment = self.stackAlignment
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXs

                stack.add([
                    textStack,
                    trailingStack
                ])
            }
        }()

        private lazy var button: UIButton = {
            let button = UIButton()
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(Ocean.color.colorBrandPrimaryPure, for: .normal)
            button.titleLabel?.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return button
        }()

        private lazy var buttonContainer: UIView = {
            let view = button.addMargins(left: size + Ocean.size.spacingStackXs)
            view.isHidden = true
            return view
        }()

        private lazy var errorLabel: UILabel = {
            UILabel { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorStatusNegativePure
                label.text = errorEmpty
                label.isHidden = true
            }
        }()

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    radioStack,
                    buttonContainer,
                    errorLabel
                ])
            }
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
            setupConstraints()
        }

        public convenience init(builder: RadioButtonBuilder) {
            self.init(frame: .zero)
            builder(self)
        }

        private func rebuildStackForTextPosition() {
            textStack.removeFromSuperview()
            trailingStack.removeFromSuperview()

            radioStack.arrangedSubviews.forEach { radioStack.removeArrangedSubview($0); $0.removeFromSuperview() }

            if textIsRight {
                radioStack.addArrangedSubview(trailingStack)
                radioStack.addArrangedSubview(textStack)
            } else {
                radioStack.addArrangedSubview(textStack)
                radioStack.addArrangedSubview(Ocean.Spacer())
                radioStack.addArrangedSubview(trailingStack)
            }

            radioStack.setNeedsLayout()
            radioStack.layoutIfNeeded()
        }

        private func updateBadge() {
            if let number = badgeNumber, number > 0 {
                badgeView.isHidden = false
                badgeView.number = number
            } else {
                badgeView.isHidden = true
            }
        }

        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightPure

            self.addSubview(mainStack)
            self.addTapGesture(target: self, selector: #selector(toogleRadio))

            textStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
            textStack.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            trailingStack.setContentHuggingPriority(.required, for: .horizontal)
            trailingStack.setContentCompressionResistancePriority(.required, for: .horizontal)
            badgeView.setContentHuggingPriority(.required, for: .horizontal)
            badgeView.setContentCompressionResistancePriority(.required, for: .horizontal)

            self.updateState()
        }

        private func setupConstraints() {
            radioBkgView.oceanConstraints
                .width(constant: size)
                .height(constant: size)
                .make()

            mainStack.oceanConstraints
                .fill(to: self)
                .make()
        }

        @objc internal func toogleRadio() {
            isSelected = true
            onTouch?()
            generator.selectionChanged()
        }

        @objc private func buttonTapped() {
            self.onTouchButton?()
        }

        private func updateState() {
            if isSelected {
                changeToChecked()
            } else {
                changeToUnchecked()
                if let errorText = errorLabel.text, errorText != errorEmpty {
                    changeToError()
                }
            }

            textLabel.textColor = isEnabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorInterfaceLightDeep
        }

        private func changeToChecked() {
            errorLabel.text = errorEmpty
            errorLabel.isHidden = true

            changeForegroundCircle(path: foregroundShrinkPath)
            let color = isEnabled ? Ocean.color.colorComplementaryPure : Ocean.color.colorInterfaceLightDown
            changeShapeColorOf(layer: backgroundCircleLayer, color: color)
            radioBkgView.isUserInteractionEnabled = self.isInteractionEnabled
        }

        private func changeToUnchecked() {
            errorLabel.text = errorEmpty
            errorLabel.isHidden = true

            changeForegroundCircle(path: foregroundExpandPath)
            let backgroundCircleColor = isEnabled ? Ocean.color.colorInterfaceDarkUp : Ocean.color.colorInterfaceLightDown
            changeShapeColorOf(layer: backgroundCircleLayer, color: backgroundCircleColor)

            if let foregroundCircleColor = isEnabled ? Ocean.color.colorInterfaceLightPure : backgroundColor {
                changeShapeColorOf(layer: foregroundCircleLayer, color: foregroundCircleColor)
            }

            radioBkgView.isUserInteractionEnabled = self.isInteractionEnabled
        }

        private func changeToError() {
            errorLabel.isHidden = false

            changeForegroundCircle(path: foregroundExpandPath)
            let backgroundCircleColor = Ocean.color.colorStatusNegativePure
            changeShapeColorOf(layer: backgroundCircleLayer, color: backgroundCircleColor)

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
            self.textView.isSkeletonable = true
        }
    }
}
