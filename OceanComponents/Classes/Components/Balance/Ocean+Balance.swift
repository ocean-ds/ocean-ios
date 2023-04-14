//
//  Ocean+Balance.swift
//  OceanComponents
//
//  Created by Vini on 30/08/21.
//

import OceanTokens

extension Ocean {
    final public class Balance: UIView {
        struct Constants {
            static let height: CGFloat = 105
            static let heightLg: CGFloat = 230
            static let eyeImageSize: CGFloat = 24
            static let arrowSize: CGFloat = 16
        }

        public typealias BalanceBuilder = (Balance) -> Void

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

        public var balanceNotBlu: Double = 0 {
            didSet {
                updateUI()
            }
        }

        public var onStateChanged: ((State) -> Void)?
        public var howToUseTouch: (() -> Void)?

        private lazy var heightConstraint: NSLayoutConstraint = {
            self.heightAnchor.constraint(equalToConstant: Constants.height)
        }()

        private lazy var titleHighlightLabel: UILabel = {
            UILabel { label in
                label.font = .highlightBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorBrandPrimaryPure
                label.text = "Saldo na Blu"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isHidden = true
            }
        }()

        private lazy var eyeImageView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.isSkeletonable = true

                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: Constants.eyeImageSize),
                    imageView.heightAnchor.constraint(equalToConstant: Constants.eyeImageSize)
                ])

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

                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: Constants.arrowSize),
                    imageView.heightAnchor.constraint(equalToConstant: Constants.arrowSize)
                ])
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

        private lazy var titleNotBluHighlightLabel: UILabel = {
            UILabel { label in
                label.font = .highlightBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorBrandPrimaryPure
                label.text = "Em outras maquininhas"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isHidden = true
            }
        }()

        private lazy var notBluSpacer = Ocean.Spacer(space: Constants.eyeImageSize)

        private lazy var titleNotBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.text = "Em outras maquininhas"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()

        private lazy var balanceNotBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: balanceNotBlu)
                label.text = balanceAvailable.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()

        private lazy var titleNotBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            stack.isSkeletonable = true

            stack.add([
                titleNotBluLabel,
                balanceNotBluLabel
            ])

            return stack
        }()

        private lazy var howToUseButton: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { button in
                button.text = "Como usar"
                button.onTouch = self.howToUseTouch
                button.isSkeletonable = true
            }
        }()

        private lazy var headerNotBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isSkeletonable = true

            stack.add([
                titleNotBluHighlightLabel,
                notBluSpacer,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                titleNotBluStack,
                UIView(),
                howToUseButton
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var notBluDivider = Ocean.Divider(widthConstraint: self.widthAnchor)

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
                Ocean.Divider(widthConstraint: self.widthAnchor),
                listCurrentBalanceStack,
                Ocean.Divider(widthConstraint: self.widthAnchor),
                listScheduleBluStack
            ])

            return stack
        }()

        private lazy var listNotBluTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo total"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listNotBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = getColorValue(value: balanceNotBlu)
                label.text = balanceNotBlu.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var listBalanceNotBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0

            stack.add([
                listNotBluTextLabel,
                listNotBluLabel
            ])

            stack.setMargins(top: Ocean.size.spacingStackXxs,
                             left: Ocean.size.spacingStackXs,
                             bottom: Ocean.size.spacingStackXxs,
                             right: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var listNotBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.isHidden = true

            stack.add([
                listBalanceNotBluStack
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
                listStack,
                notBluDivider,
                headerNotBluStack,
                listNotBluStack
            ])

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
            balanceNotBluLabel.text = balanceNotBlu.toCurrency()
            balanceNotBluLabel.textColor = getColorValue(value: balanceNotBlu)
            listNotBluLabel.text = balanceNotBlu.toCurrency()
            listNotBluLabel.textColor = getColorValue(value: balanceNotBlu)
        }

        private func updateVisibleUI() {
            balanceAvailableLabel.text = isVisible ? balanceAvailable.toCurrency() : "R$ ••••••"
            balanceNotBluLabel.text = isVisible ? balanceNotBlu.toCurrency() : "R$ ••••••"
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
                self.listStack.isHidden = true
                self.titleHighlightLabel.isHidden = true
                self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                self.arrowView.tintColor = Ocean.color.colorInterfaceDarkUp
                self.eyeImageView.alpha = 1
                self.titleStack.alpha = 1
                self.notBluDivider.alpha = 1
                self.listNotBluStack.isHidden = true
                self.titleNotBluHighlightLabel.isHidden = true
                self.titleNotBluStack.alpha = 1
                self.howToUseButton.alpha = 1
            case .expanded:
                UIView.animate(withDuration: 0.3) {
                    self.eyeImageView.alpha = 0
                    self.titleStack.alpha = 0
                    self.arrowView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                    self.arrowView.tintColor = Ocean.color.colorBrandPrimaryPure
                    self.notBluDivider.alpha = 0
                    self.titleNotBluStack.alpha = 0
                    self.howToUseButton.alpha = 0
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.listStack.isHidden = false
                        self.listNotBluStack.isHidden = false
                        self.heightConstraint.constant = Constants.heightLg
                    } completion: { _ in
                        UIView.animate(withDuration: 0.3) {
                            self.titleHighlightLabel.isHidden = false
                            self.titleNotBluHighlightLabel.isHidden = false
                        }
                    }
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
