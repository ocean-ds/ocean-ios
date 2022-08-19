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

        public var image: UIImage? {
            didSet {
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
            }
        }

        public var badgeStatus: BadgeNumber.Status = .alert {
            didSet {
                badgeView.status = badgeStatus
            }
        }

        public var badgeNumber: Int? = nil {
            didSet {
                guard let number = badgeNumber else { return }
                badgeView.isHidden = false
                badgeView.number = number
            }
        }

        public var title: String = "" {
            didSet {
                titleLabel.text = title
            }
        }

        public var isHighlight: Bool = false {
            didSet {
                updateState()
            }
        }

        private lazy var imageView: UIImageView = {
            UIImageView { imageView in
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var badgeView: BadgeNumber = {
            let badgeNumberView = Ocean.Badge.number()
            badgeNumberView.isHidden = true
            return badgeNumberView
        }()

        private lazy var titleLabel: VerticalAlignmentLabel = {
            let label = VerticalAlignmentLabel()
            label.font = .baseBold(size: Ocean.font.fontSizeXxs)
            label.numberOfLines = 2
            label.contentMode = .bottom
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            updateState()
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
            self.clipsToBounds = true
            self.ocean.radius.applyMd()
            self.ocean.borderWidth.applyHairline()

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
            contentView.addSubview(imageView)
            contentView.addSubview(badgeView)
            contentView.addSubview(titleLabel)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 11),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Ocean.size.spacingStackXs),
                imageView.widthAnchor.constraint(equalToConstant: 24),
                imageView.heightAnchor.constraint(equalToConstant: 24),
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Ocean.size.spacingStackXxs),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Ocean.size.spacingStackXs),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Ocean.size.spacingStackXs),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11)
            ])

            badgeView.setConstraints((.sameCenter, toView: imageView))
        }

        private func updateState() {
            contentView.backgroundColor = isHighlight ? Ocean.color.colorBrandPrimaryDown : Ocean.color.colorInterfaceLightPure
            contentView.layer.borderColor = isHighlight ? Ocean.color.colorBrandPrimaryDown.cgColor : Ocean.color.colorInterfaceLightDown.cgColor
            imageView.tintColor = isHighlight ? Ocean.color.colorInterfaceLightPure : Ocean.color.colorBrandPrimaryPure
            titleLabel.textColor = isHighlight ? Ocean.color.colorInterfaceLightPure : Ocean.color.colorInterfaceDarkDown
        }

        public func pressState(isPressed: Bool) {
            if isPressed {
                contentView.backgroundColor = isHighlight ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceLightDown
            } else {
                contentView.backgroundColor = isHighlight ? Ocean.color.colorBrandPrimaryDown : Ocean.color.colorInterfaceLightPure
            }
        }
    }
}
