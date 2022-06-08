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
            static let height: CGFloat = 56
            static let eyeImageSize: CGFloat = 24
            static let arrowSize: CGFloat = 16
        }
        
        public typealias BalanceBuilder = (Balance) -> Void
        
        public enum State {
            case expanded, collapsed
        }
        
        private var state: State = .collapsed {
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
        
        public var scheduleNotBlu: Double = 0 {
            didSet {
                updateUI()
            }
        }
        
        public var scheduleNotBluActive: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var scheduleNotBluHidden: Bool = true {
            didSet {
                updateUI()
            }
        }

        public var onStateChanged: ((State) -> Void)?
        
        private lazy var titleHighlightLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorBrandPrimaryPure
                label.text = "Seu saldo"
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
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo total"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var balanceAvailableLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = balanceAvailable.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var titleStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            
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
            
            stack.add([
                titleHighlightLabel,
                eyeImageView,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                titleStack,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                arrowView
            ])
            
            stack.addTapGesture(target: self, selector: #selector(tap))
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var listBalanceAvailableTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo total"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var listBalanceAvailableLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
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
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var listCurrentBalanceTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Saldo atual"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var listCurrentBalanceLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
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
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var listScheduleBluTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Agenda"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var listScheduleBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
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
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        private lazy var listScheduleNotBluTextLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.text = "Agenda outras maquininhas"
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var listScheduleNotBluLabel: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = scheduleNotBluActive ? Ocean.color.colorInterfaceDarkDeep :
                    Ocean.color.colorInterfaceDarkUp
                label.text = scheduleNotBlu.toCurrency()
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var listScheduleNotBluStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 0
            stack.isHidden = scheduleNotBluHidden
            
            stack.add([
                listScheduleNotBluTextLabel,
                listScheduleNotBluLabel
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()

        private lazy var listScheduleNotBluDivider: UIView = {
            let view = Ocean.Divider(widthConstraint: self.widthAnchor)
            view.isHidden = scheduleNotBluHidden
            return view
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
                listScheduleBluStack,
                listScheduleNotBluDivider,
                listScheduleNotBluStack
            ])
            
            return stack
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.spacing = 0
            
            stack.add([
                headerStack,
                listStack
            ])
            
            return stack
        }()
        
        public override var intrinsicContentSize: CGSize {
            return CGSize(width: frame.width, height: Constants.height)
        }

        public convenience init(builder: BalanceBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            add(view: mainStack)
        }
        
        private func updateUI() {
            balanceAvailableLabel.text = balanceAvailable.toCurrency()
            listBalanceAvailableLabel.text = balanceAvailable.toCurrency()
            listCurrentBalanceLabel.text = currentBalance.toCurrency()
            listScheduleBluLabel.text = scheduleBlu.toCurrency()
            listScheduleNotBluLabel.text = scheduleNotBlu.toCurrency()
            listScheduleNotBluLabel.textColor = scheduleNotBluActive ? Ocean.color.colorInterfaceDarkDeep :
                Ocean.color.colorInterfaceDarkUp
            listScheduleNotBluStack.isHidden = scheduleNotBluHidden
            listScheduleNotBluDivider.isHidden = scheduleNotBluHidden
        }
        
        private func updateVisibleUI() {
            balanceAvailableLabel.text = isVisible ? balanceAvailable.toCurrency() :
                "R$ ••••••"
            eyeImageView.image = isVisible ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate) :
                Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate)
        }
        
        private func animateUI() {
            switch self.state {
            case .collapsed:
                UIView.animate(withDuration: 0.3) {
                    self.listStack.isHidden = true
                    self.titleHighlightLabel.isHidden = true
                    self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                    self.arrowView.tintColor = Ocean.color.colorInterfaceDarkUp
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.eyeImageView.alpha = 1
                        self.titleStack.alpha = 1
                    }
                }
            case .expanded:
                UIView.animate(withDuration: 0.3) {
                    self.eyeImageView.alpha = 0
                    self.titleStack.alpha = 0
                    self.arrowView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                    self.arrowView.tintColor = Ocean.color.colorBrandPrimaryPure
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.listStack.isHidden = false
                    } completion: { _ in
                        UIView.animate(withDuration: 0.3) {
                            self.titleHighlightLabel.isHidden = false
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
