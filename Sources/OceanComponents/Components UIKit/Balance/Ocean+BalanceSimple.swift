//
//  Ocean+BalanceSimple.swift
//  OceanComponents
//
//  Created by Vini on 30/08/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class BalanceSimple: UIView {
        struct Constants {
            static let height: CGFloat = 60
            static let heightLg: CGFloat = 190
            static let headerHeight: CGFloat = 56
            static let headerHeightSm: CGFloat = 36
            static let eyeImageSize: CGFloat = 24
            static let arrowSize: CGFloat = 16
        }

        public typealias BalanceBuilder = (BalanceSimple) -> Void

        public enum State {
            case expanded, collapsed
        }

        public var state: State = .collapsed {
            didSet {
                animateUI()
                self.onStateChanged?(state)
            }
        }

        public var isVisible: Bool = true {
            didSet {
                updateVisibleUI()
            }
        }

        public var balanceAvailable: Double = 0 {
            didSet {
                updateUI()
            }
        }

        public var currentBalance: Double = 0 {
            didSet {
                updateUI()
            }
        }

        public var scheduleBlu: Double = 0 {
            didSet {
                updateUI()
            }
        }

        public var onStateChanged: ((State) -> Void)?

        private lazy var heightConstraint: NSLayoutConstraint = {
            self.heightAnchor.constraint(equalToConstant: Constants.height)
        }()

        private lazy var heightHeaderConstraint: NSLayoutConstraint = {
            self.headerStack.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        }()

        private lazy var titleHighlightLabel: UILabel = {
            UILabel { label in
                label.font = .highlightBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorBrandPrimaryPure
                label.text = "Saldo na Blu"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isHidden = true
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }()

        private lazy var eyeImageView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.isSkeletonable = true

                imageView.addTapGesture(target: self, selector: #selector(tapEye))
            }
        }()

        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.text = "Saldo na Blu"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            }
        }()

        private lazy var balanceAvailableLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: balanceAvailable)
                label.text = balanceAvailable.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()

        private lazy var titleStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            stack.isSkeletonable = true

            stack.add([
                titleLabel,
                balanceAvailableLabel
            ])

            return stack
        }()

        private lazy var arrowView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var headerStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isSkeletonable = true

            stack.add([
                titleHighlightLabel,
                eyeImageView,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                titleStack,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                arrowView
            ])

            stack.addTapGesture(target: self, selector: #selector(tap))

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var listBalanceAvailableTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo total"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listBalanceAvailableLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: balanceAvailable)
                label.text = balanceAvailable.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listBalanceAvailableStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0

            stack.add([
                listBalanceAvailableTextLabel,
                UIView(),
                listBalanceAvailableLabel
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var listCurrentBalanceTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo atual"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listCurrentBalanceLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: currentBalance)
                label.text = currentBalance.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listCurrentBalanceStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0

            stack.add([
                listCurrentBalanceTextLabel,
                UIView(),
                listCurrentBalanceLabel
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var listScheduleBluTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Agenda"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listScheduleBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: scheduleBlu)
                label.text = scheduleBlu.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listScheduleBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0

            stack.add([
                listScheduleBluTextLabel,
                UIView(),
                listScheduleBluLabel
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var listStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isHidden = true

            stack.add([
                listBalanceAvailableStack,
                Ocean.Divider(widthConstraint: self.widthAnchor)
                    .addMargins(horizontal: Ocean.size.spacingStackXs),
                listCurrentBalanceStack,
                Ocean.Divider(widthConstraint: self.widthAnchor)
                    .addMargins(horizontal: Ocean.size.spacingStackXs),
                listScheduleBluStack
            ])

            return stack
        }()

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            stack.isSkeletonable = true

            stack.add([
                headerStack,
                listStack
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             bottom: Ocean.size.spacingStackXxxs)

            return stack
        }()

        public convenience init(builder: BalanceBuilder) {
            self.init()
            builder(self)
            setupUI()
            setupConstraints()
        }

        private func setupUI() {
            self.isSkeletonable = true
            add(view: mainStack)
        }

        private func setupConstraints() {
            self.heightConstraint.isActive = true
            self.heightHeaderConstraint.isActive = true

            self.listBalanceAvailableStack.oceanConstraints
                .height(constant: 48)
                .make()

            self.listCurrentBalanceStack.oceanConstraints
                .height(constant: 48)
                .make()

            self.listScheduleBluStack.oceanConstraints
                .height(constant: 48)
                .make()

            self.eyeImageView.oceanConstraints
                .width(constant: Constants.eyeImageSize)
                .height(constant: Constants.eyeImageSize)
                .make()

            self.arrowView.oceanConstraints
                .width(constant: Constants.arrowSize)
                .height(constant: Constants.arrowSize)
                .make()
        }

        private func updateUI() {
            balanceAvailableLabel.text = balanceAvailable.toCurrency()
            balanceAvailableLabel.textColor = getColorValue(value: balanceAvailable)
            listBalanceAvailableLabel.text = balanceAvailable.toCurrency()
            listBalanceAvailableLabel.textColor = getColorValue(value: balanceAvailable)
            listCurrentBalanceLabel.text = currentBalance.toCurrency()
            listCurrentBalanceLabel.textColor = getColorValue(value: currentBalance)
            listScheduleBluLabel.text = scheduleBlu.toCurrency()
            listScheduleBluLabel.textColor = getColorValue(value: scheduleBlu)
        }

        private func updateVisibleUI() {
            balanceAvailableLabel.text = isVisible ? balanceAvailable.toCurrency() : "R$ ••••••"
            eyeImageView.image = isVisible ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate) :
            Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate)
        }

        private func getColorValue(value: Double) -> UIColor {
            return value < 0 ? Ocean.color.colorStatusNegativePure : Ocean.color.colorInterfaceDarkDeep
        }

        private func animateUI() {
            switch self.state {
            case .collapsed:
                self.heightConstraint.constant = Constants.height
                self.heightHeaderConstraint.constant = Constants.headerHeight
                self.listStack.isHidden = true
                self.titleHighlightLabel.isHidden = true
                self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                self.arrowView.tintColor = Ocean.color.colorInterfaceDarkUp
                self.eyeImageView.alpha = 1
                self.titleStack.alpha = 1
            case .expanded:
                UIView.animate(withDuration: 0.3) {
                    self.eyeImageView.alpha = 0
                    self.titleStack.alpha = 0
                    self.arrowView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                    self.arrowView.tintColor = Ocean.color.colorBrandPrimaryPure
                } completion: { _ in
                    self.titleHighlightLabel.isHidden = false
                    self.listStack.isHidden = false
                    self.heightConstraint.constant = Constants.heightLg
                    self.heightHeaderConstraint.constant = Constants.headerHeightSm
                }
            }
        }

        @objc private func tap() {
            state = state == .collapsed ? .expanded : .collapsed
        }

        @objc private func tapEye() {
            isVisible = !isVisible
        }
    }
}
