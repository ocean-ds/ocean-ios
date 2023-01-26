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

        private lazy var imageView: UIImageView = {
            UIImageView { imageView in
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tintColor = Ocean.color.colorBrandPrimaryDown
            }
        }()

        private lazy var badgeView: BadgeNumber = {
            let badgeNumberView = Ocean.Badge.number()
            badgeNumberView.size = .small
            badgeNumberView.isHidden = true
            return badgeNumberView
        }()

        private lazy var titleLabel: VerticalAlignmentLabel = {
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

        private lazy var titleStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    titleLabel,
                    subtitleLabel
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

            self.contentView.addSubview(imageView)
            self.contentView.addSubview(badgeView)
            self.contentView.addSubview(titleStack)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: Ocean.size.spacingStackXs),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Ocean.size.spacingStackXs),
                imageView.widthAnchor.constraint(equalToConstant: 24),
                imageView.heightAnchor.constraint(equalToConstant: 24),
                badgeView.topAnchor.constraint(equalTo: topAnchor, constant: Ocean.size.spacingStackXxs),
                badgeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Ocean.size.spacingStackXxs),
                titleStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Ocean.size.spacingStackXxs),
                titleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Ocean.size.spacingStackXs),
                titleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Ocean.size.spacingStackXs),
                titleStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Ocean.size.spacingStackXs)
            ])
        }

        private func updateUI() {
            imageView.image = model.image?.withRenderingMode(.alwaysTemplate)
            badgeView.status = model.badgeStatus
            badgeView.isHidden = model.badgeNumber == nil
            badgeView.number = model.badgeNumber ?? 0
            titleLabel.text = model.title
            subtitleLabel.text = model.subtitle
            subtitleLabel.isHidden = model.subtitle.isEmpty
        }

        public func pressState(isPressed: Bool) {
            contentView.backgroundColor = isPressed ? Ocean.color.colorInterfaceLightDown : Ocean.color.colorInterfaceLightPure
        }
    }
}
