//
//  Ocean+BalanceCell.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/05/23.
//

import OceanTokens

extension Ocean {
    public class BalanceCell: UICollectionViewCell {
        static let identifier = "BalanceCellIdentifier"

        public var onStateChanged: ((BalanceState) -> Void)?

        public var model: BalanceModel = .empty() {
            didSet {
                updateUI()
            }
        }

        private var _state: BalanceState = .collapsed
        public var state: BalanceState {
            get { _state }
            set {
                _state = newValue
                updateState()
            }
        }

        private var isVisible: Bool = true {
            didSet {
                updateVisibleUI()
            }
        }

        private lazy var eyeImageView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorBrandPrimaryUp
                imageView.contentMode = .scaleAspectFit
            }
        }()

        private lazy var eyeContainerView: UIView = {
            let view = eyeImageView.addMargins(right: Ocean.size.spacingStackXs)
            view.addTapGesture(target: self, selector: #selector(tapEye))
            view.isSkeletonable = false
            return view
        }()

        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorBrandPrimaryUp
            }
        }()

        private lazy var valueLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeSm)
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.isSkeletonable = true
            }
        }()

        private lazy var placeholderValueView: UIView = {
            let view = UIView()
            view.backgroundColor = Ocean.color.colorBrandPrimaryDown
            view.clipsToBounds = true
            view.ocean.radius.applySm()
            return view
        }()

        private lazy var placeholderValueContainer: UIView = {
            let view = UIView()
            view.addSubview(placeholderValueView)
            view.isHidden = true
            return view
        }()

        private lazy var titleStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = 0
                stack.isSkeletonable = true

                stack.add([
                    titleLabel,
                    valueLabel,
                    placeholderValueContainer
                ])
            }
        }()

        private lazy var arrowView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceLightPure
                imageView.contentMode = .scaleAspectFit
            }
        }()

        private lazy var headerStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxs
                stack.isSkeletonable = true

                stack.add([
                    eyeContainerView,
                    titleStack,
                    UIView(),
                    arrowView
                ])

                stack.addTapGesture(target: self, selector: #selector(tap))
            }
        }()

        private lazy var item1TitleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }()

        private lazy var item1ValueLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.isSkeletonable = true
            }
        }()

        private lazy var item1Stack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = 0
                stack.isSkeletonable = true

                stack.add([
                    item1TitleLabel,
                    UIView(),
                    item1ValueLabel
                ])
            }
        }()

        private lazy var item2TitleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }()

        private lazy var item2ValueLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.isSkeletonable = true
            }
        }()

        private lazy var item2Stack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = 0
                stack.isSkeletonable = true

                stack.add([
                    item2TitleLabel,
                    UIView(),
                    item2ValueLabel
                ])
            }
        }()

        private lazy var headerDetailsStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXs
                stack.isSkeletonable = true
                stack.alpha = 0

                stack.add([
                    item1Stack,
                    Ocean.Divider(widthConstraint: stack.widthAnchor,
                                  color: Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)),
                    item2Stack
                ])

                stack.setMargins(vertical: Ocean.size.spacingStackXxs)
            }
        }()

        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceLightDown
                label.numberOfLines = 2
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }()

        private lazy var footerButton: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { button in
                button.onTouch = { self.model.action?() }
            }
        }()

        private lazy var footerStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .center
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    descriptionLabel,
                    footerButton
                ])
            }
        }()

        private lazy var contentContainerView: UIView = {
            let view = UIView()
            view.isSkeletonable = true
            let divider = Ocean.Divider(widthConstraint: view.widthAnchor,
                                        color: Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4))
            view.addSubviews(headerStack, headerDetailsStack, divider, footerStack)

            headerStack.oceanConstraints
                .topToTop(to: view, constant: Ocean.size.spacingStackXs)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs)
                .make()

            headerDetailsStack.oceanConstraints
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs)
                .height(constant: 87)
                .make()

            divider.oceanConstraints
                .topToBottom(to: headerDetailsStack, constant: Ocean.size.spacingStackXxs)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs)
                .make()

            footerStack.oceanConstraints
                .topToBottom(to: divider, constant: Ocean.size.spacingStackXxs)
                .leadingToLeading(to: view, constant: Ocean.size.spacingStackXs)
                .trailingToTrailing(to: view, constant: -Ocean.size.spacingStackXs)
                .make()

            return view
        }()

        private lazy var contentContainer: UIView = {
            let view = UIView()
            view.backgroundColor = Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)
            view.clipsToBounds = true
            view.ocean.radius.applyMd()
            view.isSkeletonable = true
            view.addSubview(contentContainerView)

            contentContainerView.oceanConstraints
                .fill(to: view)
                .make()

            self.skeletonCornerRadius = Float(view.layer.cornerRadius)
            return view
        }()

        private lazy var mainView: UIView = {
            let view = UIView()
            view.isSkeletonable = true
            view.addSubview(contentContainer)

            contentContainer.oceanConstraints
                .topToTop(to: view)
                .leadingToLeading(to: view)
                .trailingToTrailing(to: view)
                .make()

            return view
        }()

        private lazy var contentContainerHeightConstraint: NSLayoutConstraint = {
            self.contentContainerView.heightAnchor.constraint(equalToConstant: 130)
        }()

        private lazy var headerDetailTopConstraint: NSLayoutConstraint = {
            self.headerDetailsStack.topAnchor.constraint(equalTo: contentContainerView.topAnchor,
                                                         constant: -30)
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.backgroundColor = .clear

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.contentView.addSubviews(mainView)
        }

        private func setupConstraints() {
            mainView.oceanConstraints
                .fill(to: contentView)
                .make()

            placeholderValueView.oceanConstraints
                .width(constant: 40)
                .height(constant: 6)
                .centerY(to: placeholderValueContainer)
                .leadingToLeading(to: placeholderValueContainer)
                .make()

            placeholderValueContainer.oceanConstraints
                .height(constant: 27)
                .make()

            descriptionLabel.oceanConstraints
                .height(constant: 42)
                .make()

            contentContainerHeightConstraint.isActive = true
            headerDetailTopConstraint.isActive = true
        }

        private func updateUI() {
            self.titleLabel.text = model.title
            self.valueLabel.text = model.value?.toCurrency()
            self.valueLabel.isHidden = model.value == nil
            self.placeholderValueContainer.isHidden = model.value != nil
            self.eyeContainerView.isHidden = model.value == nil

            self.arrowView.isHidden = model.item1Title.isEmpty && model.item2Title.isEmpty
            self.item1TitleLabel.text = model.item1Title
            self.item1ValueLabel.text = model.item1Value.toCurrency()
            self.item2TitleLabel.text = model.item2Title
            self.item2ValueLabel.text = model.item2Value.toCurrency()

            self.descriptionLabel.text = model.description
            self.footerButton.text = model.actionCTA
        }

        private func updateVisibleUI() {
            self.valueLabel.text = isVisible ? model.value?.toCurrency() : "R$ ••••••"
            self.item1ValueLabel.text = isVisible ? model.item1Value.toCurrency() : "R$ ••••••"
            self.item2ValueLabel.text = isVisible ? model.item2Value.toCurrency() : "R$ ••••••"
            self.eyeImageView.image = isVisible ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate) :
            Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate)
        }

        private func updateState() {
            switch self._state {
            case .collapsed:
                self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                self.contentContainerHeightConstraint.constant = 130
                self.headerDetailTopConstraint.constant = -30
                self.headerDetailsStack.alpha = 0
            case .expanded:
                self.arrowView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                self.contentContainerHeightConstraint.constant = 230
                self.headerDetailTopConstraint.constant = self.headerStack.frame.height + Ocean.size.spacingStackXs + Ocean.size.spacingStackXxs
                self.headerDetailsStack.alpha = 1
            default:
                break
            }
        }

        private func animateState(completion: @escaping () -> Void) {
            switch self._state {
            case .collapsed:
                self.contentContainerHeightConstraint.constant = 130
                self.headerDetailTopConstraint.constant = -30
                self.headerDetailsStack.alpha = 1
                UIView.animate(withDuration: 0.2) {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                    self.headerDetailsStack.alpha = 0
                    self.layoutIfNeeded()
                } completion: { _ in
                    completion()
                }
            case .expanded:
                self.contentContainerHeightConstraint.constant = 230
                self.headerDetailTopConstraint.constant = self.headerStack.frame.height + Ocean.size.spacingStackXs + Ocean.size.spacingStackXxs
                self.headerDetailsStack.alpha = 0
                UIView.animate(withDuration: 0.2) {
                    self.arrowView.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
                    self.headerDetailsStack.alpha = 1
                    self.layoutIfNeeded()
                }
                completion()
            default:
                break
            }
        }

        @objc private func tap() {
            if !model.item1Title.isEmpty && !model.item2Title.isEmpty {
                _state = _state == .collapsed ? .expanded : .collapsed
                animateState {
                    self.onStateChanged?(self.state)
                }
            }
        }

        @objc private func tapEye() {
            isVisible = !isVisible
        }
    }
}
