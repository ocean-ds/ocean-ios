//
//  Ocean+BalanceScrollView.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/05/23.
//

import OceanTokens

extension Ocean {
    public class BalanceScrollView: UIView {
        public var onOpen: (() -> Void)?

        public var model: BalanceModel = .empty() {
            didSet {
                updateUI()
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
            view.isSkeletonable = false
            view.addTapGesture(target: self, selector: #selector(tapEye))
            return view
        }()

        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorBrandPrimaryUp
            }
        }()
        
        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceLightDown
                label.numberOfLines = 2
                label.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }()

        private lazy var valueLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.isSkeletonable = true
            }
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
                    descriptionLabel,
                    valueLabel
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

        private lazy var footerButton: Ocean.ButtonSecondary = {
            Ocean.Button.secondarySM { button in
                button.onTouch = { self.model.action?() }
                button.isHidden = true
            }
        }()

        private lazy var headerStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .center
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

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.alignment = .center
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxs
                stack.isSkeletonable = true

                stack.add([
                    headerStack,
                    footerButton
                ])

                stack.setMargins(top: Ocean.size.spacingStackXxs,
                                 left: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXxs,
                                 right: Ocean.size.spacingStackXs)
            }
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
            self.backgroundColor = Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)

            self.isSkeletonable = true
            self.addSubview(contentStack)
        }

        private func setupConstraints() {
            contentStack.oceanConstraints
                .fill(to: self)
                .make()
        }

        private func updateUI() {
            if model.cellType == .balance {
                setupBalanceCell()
            } else {
                setupBalanceWithoutValueCell()
            }
        }
        
        private func setupBalanceCell() {
            titleLabel.text = model.title
            titleLabel.isHidden = false
            descriptionLabel.isHidden = true
            footerButton.text = model.actionCTA
            footerButton.isHidden = true
            valueLabel.text = model.value?.toCurrency()
            valueLabel.isHidden = false
            eyeContainerView.isHidden = false
            arrowView.isHidden = false
        }
        
        private func setupBalanceWithoutValueCell() {
            descriptionLabel.text = model.description
            descriptionLabel.isHidden = false
            footerButton.text = model.actionCTACollapsed
            footerButton.isHidden = false
            titleLabel.isHidden = true
            arrowView.isHidden = true
            valueLabel.isHidden = true
            eyeContainerView.isHidden = true
        }

        private func updateVisibleUI() {
            self.valueLabel.text = isVisible ? model.value?.toCurrency() : "R$ ••••••"
            self.eyeImageView.image = isVisible ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate) :
            Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate)
        }

        @objc private func tap() {
            if !model.item1Title.isEmpty && !model.item2Title.isEmpty {
                self.onOpen?()
            }
        }

        @objc private func tapEye() {
            isVisible = !isVisible
        }
    }
}
