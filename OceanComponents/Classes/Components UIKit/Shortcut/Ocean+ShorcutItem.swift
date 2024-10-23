//
//  Ocean+ShortcutCell.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public class ShorcutItem: UIView {

        // MARK: Public properties

        public var model: ShortcutModel = .init(title: "") {
            didSet {
                updateUI()
            }
        }

        public var onTouch: ((ShortcutModel) -> Void)?

        // MARK: Private properties

        private var size: Shortcut.Size = .small

        private var orientation: Shortcut.Orientation = .horizontal

        // MARK: Views

        private lazy var iconImageView: UIImageView = {
            UIImageView { imageView in
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tintColor = Ocean.color.colorBrandPrimaryDown
            }
        }()

        private lazy var horizontalTitleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.numberOfLines = 1
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var tagLabel: Tag = {
            Ocean.Tag { view in
                view.status = .highlightImportant
                view.isHidden = true
            }
        }()

        private lazy var badgeNumber: BadgeNumber = {
            let badgeNumber = Ocean.Badge.number()
            badgeNumber.size = .small
            badgeNumber.isHidden = true
            return badgeNumber
        }()

        private lazy var blockedImageView: UIImageView = {
            UIImageView { imageView in
                imageView.contentMode = .scaleAspectFit
                imageView.image = Ocean.icon.lockClosedSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var accessoriesStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    tagLabel,
                    badgeNumber,
                    blockedImageView
                ])
            }
        }()

        private lazy var verticalTitleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 2
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 0
            }
        }()

        private lazy var spacer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()

        private lazy var titleStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    verticalTitleLabel,
                    subtitleLabel,
                    spacer
                ])
            }
        }()

        // MARK: Constructors

        init(frame: CGRect = .zero,
             orientation: Shortcut.Orientation = .horizontal,
             size: Shortcut.Size = .tiny) {
            self.orientation = orientation
            self.size = size
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: Setup

        private func setupUI() {
            isSkeletonable = true
            skeletonCornerRadius = Float(layer.cornerRadius)

            clipsToBounds = true
            self.ocean.radius.applyMd()
            self.ocean.borderWidth.applyHairline()
            backgroundColor = Ocean.color.colorInterfaceLightPure
            layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            isSkeletonable = true
            self.addTapGesture(selector: #selector(tapped))

            addSubviews(iconImageView,
                        horizontalTitleLabel,
                        accessoriesStack,
                        titleStack)

            iconImageView.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingInsetSm)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .width(constant: 24)
                .height(constant: 24)
                .make()

            horizontalTitleLabel.oceanConstraints
                .centerY(to: iconImageView)
                .leadingToTrailing(to: iconImageView,
                                   constant: Ocean.size.spacingInsetXs)
                .trailingToLeading(to: accessoriesStack,
                                   constant: -Ocean.size.spacingInsetXs,
                                   type: .lessThanOrEqualTo)
                .make()

            blockedImageView.oceanConstraints
                .width(constant: 16)
                .height(constant: 16)
                .make()

            accessoriesStack.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingInsetXs)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetXs)
                .make()

            titleStack.oceanConstraints
                .topToBottom(to: iconImageView, constant: Ocean.size.spacingInsetSm)
                .bottomToBottom(to: self)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
                .make()
        }

        // MARK: Public properties

        public func pressState(isPressed: Bool) {
            backgroundColor = isPressed ? Ocean.color.colorInterfaceLightDown : Ocean.color.colorInterfaceLightPure
        }

        // MARK: Private properties

        private func updateUI() {
            iconImageView.image = (model.image ?? Ocean.icon.placeholderOutline)?.withRenderingMode(.alwaysTemplate)
            horizontalTitleLabel.text = orientation == .horizontal ? model.title : ""
            tagLabel.title = model.tagLabel ?? ""
            badgeNumber.status = model.badgeStatus
            badgeNumber.number = model.badgeNumber ?? 0
            verticalTitleLabel.text = orientation == .vertical ? model.title : ""
            subtitleLabel.text = model.subtitle

            horizontalTitleLabel.isHidden = orientation != .horizontal || model.title.isEmpty
            verticalTitleLabel.isHidden = orientation != .vertical || model.title.isEmpty
            subtitleLabel.isHidden = size != .medium || model.subtitle.isEmpty
            tagLabel.isHidden = (size == .tiny && orientation == .horizontal) || (model.tagLabel == nil || model.blocked)
            badgeNumber.isHidden = model.badgeNumber == nil || model.blocked
            blockedImageView.isHidden = !model.blocked
            spacer.isHidden = orientation != .vertical && model.subtitle.isEmpty
        }

        @objc
        private func tapped() {
            onTouch?(model)
        }
    }
}
