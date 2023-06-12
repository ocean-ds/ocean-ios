//
//  Ocean+ShortcutCell.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public class ShortcutCell: UICollectionViewCell {
        static let cellId = "ShortcutCell"

        public var model: ShortcutModel = .init(title: "") {
            didSet {
                updateUI()
            }
        }

        public var orientation: Shortcut.Orientation = .horizontal

        private lazy var imageView: UIImageView = {
            UIImageView { imageView in
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tintColor = Ocean.color.colorBrandPrimaryDown
            }
        }()

        private lazy var horizontalTitleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 1
                label.textColor = Ocean.color.colorInterfaceDarkDeep
            }
        }()

        private lazy var badgeView: BadgeNumber = {
            let badgeNumberView = Ocean.Badge.number()
            badgeNumberView.size = .small
            badgeNumberView.isHidden = true
            return badgeNumberView
        }()

        private lazy var verticalTitleLabel: VerticalAlignmentLabel = {
            let label = VerticalAlignmentLabel()
            label.font = .highlightBold(size: Ocean.font.fontSizeXxs)
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.numberOfLines = 2
            label.contentMode = .bottom
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var subtitleLabel: VerticalAlignmentLabel = {
            let label = VerticalAlignmentLabel()
            label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = 2
            label.contentMode = .bottom
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var spacer: Ocean.Spacer = Ocean.Spacer(space: 0)

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


        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func prepareForReuse() {
            super.prepareForReuse()
            badgeView.isHidden = true
            imageView.image = nil
        }

        private func setupUI() {
            self.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)

            self.contentView.clipsToBounds = true
            self.contentView.ocean.radius.applyMd()
            self.contentView.ocean.borderWidth.applyHairline()
            self.contentView.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.contentView.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            self.contentView.isSkeletonable = true

            self.contentView.addSubviews(imageView, horizontalTitleLabel, badgeView, titleStack)

            imageView.oceanConstraints
                .topToTop(to: contentView, constant: Ocean.size.spacingStackXs)
                .leadingToLeading(to: contentView, constant: Ocean.size.spacingStackXs)
                .width(constant: 24)
                .height(constant: 24)
                .make()

            horizontalTitleLabel.oceanConstraints
                .centerY(to: imageView)
                .leadingToTrailing(to: imageView, constant: Ocean.size.spacingInsetXs)
                .trailingToLeading(to: badgeView, constant: -Ocean.size.spacingInsetXs, type: .lessThanOrEqualTo)
                .make()

            badgeView.oceanConstraints
                .topToTop(to: contentView, constant: Ocean.size.spacingStackXxs)
                .trailingToTrailing(to: contentView, constant: -Ocean.size.spacingStackXxs)
                .make()

            titleStack.oceanConstraints
                .topToBottom(to: imageView, constant: Ocean.size.spacingStackXxs)
                .bottomToBottom(to: contentView)
                .leadingToLeading(to: contentView, constant: Ocean.size.spacingStackXs)
                .trailingToTrailing(to: contentView, constant: -Ocean.size.spacingStackXs)
                .make()
        }

        private func updateUI() {
            imageView.image = model.image?.withRenderingMode(.alwaysTemplate)
            badgeView.status = model.badgeStatus
            badgeView.number = model.badgeNumber ?? 0
            horizontalTitleLabel.text = model.title
            verticalTitleLabel.text = model.title
            subtitleLabel.text = model.subtitle
            subtitleLabel.isHidden = model.subtitle.isEmpty

            sizeToFit()

            badgeView.isHidden = model.badgeNumber == nil
            horizontalTitleLabel.isHidden = orientation != .horizontal || model.title.isEmpty
            verticalTitleLabel.isHidden = orientation != .vertical || model.title.isEmpty
            spacer.isHidden = orientation != .vertical && model.subtitle.isEmpty

            if verticalTitleLabel.isHidden {
                subtitleLabel.numberOfLines = 0
            } else if subtitleLabel.isHidden {
                verticalTitleLabel.numberOfLines = 0
            } else {
                verticalTitleLabel.numberOfLines = 2
                subtitleLabel.numberOfLines = 2
            }
        }

        public func pressState(isPressed: Bool) {
            contentView.backgroundColor = isPressed ? Ocean.color.colorInterfaceLightDown : Ocean.color.colorInterfaceLightPure
        }
    }
}
