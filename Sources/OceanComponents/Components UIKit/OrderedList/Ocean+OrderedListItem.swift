//
//  Ocean+OrderedListItem.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 06/12/22.
//

import UIKit
import OceanTokens

extension Ocean {
    public class OrderedListItem: UIView {
        public typealias OrderedListItemBuilder = ((OrderedListItem) -> Void)?

        struct Constants {
            static let roundedViewHeightWidthLg: CGFloat = 24
        }

        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        public var titleAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }

        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var subtitleAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }

        public var number: Int? = nil {
            didSet {
                updateUI()
            }
        }

        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var roundedBackgroundColor: UIColor = Ocean.color.colorInterfaceLightUp {
            didSet {
                updateUI()
            }
        }

        public var roundedTintColor: UIColor = Ocean.color.colorBrandPrimaryDown {
            didSet {
                updateUI()
            }
        }

        public var imageSize: CGSize = CGSize(width: Ocean.size.spacingInsetSm,
                                              height: Ocean.size.spacingInsetSm) {
            didSet {
                imageView.removeConstraints(imageView.constraints)

                imageView.oceanConstraints
                    .center(to: roundedView)
                    .width(constant: imageSize.width)
                    .height(constant: imageSize.height)
                    .make()
            }
        }

        private lazy var numberLabel: UILabel = {
            let label = UILabel()
            label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.textAlignment = .center

            return label
        }()

        private lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit

            return imageView
        }()

        private lazy var roundedView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
            view.backgroundColor = roundedBackgroundColor

            view.addSubviews(numberLabel, imageView)

            return view
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
            }
        }()

        private lazy var labelStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill
                stack.spacing = Ocean.size.spacingStackXxxs

                stack.add([
                    titleLabel,
                    subtitleLabel
                ])
            }
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .top
                stack.spacing = Ocean.size.spacingStackXxs

                stack.add([
                    roundedView,
                    labelStack
                ])
            }
        }()

        public convenience init(builder: OrderedListItemBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            updateUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            add(view: contentStack)

            roundedView.oceanConstraints
                .width(constant: Constants.roundedViewHeightWidthLg)
                .height(constant: Constants.roundedViewHeightWidthLg)
                .make()

            numberLabel.oceanConstraints
                .fill(to: roundedView)
                .make()

            imageView.oceanConstraints
                .center(to: roundedView)
                .width(constant: imageSize.width)
                .height(constant: imageSize.height)
                .make()
        }

        private func updateUI() {
            if let attributedText = titleAttributedString {
                titleLabel.attributedText = attributedText
            } else {
                titleLabel.text = title
            }

            if let attributedText = subtitleAttributedString {
                subtitleLabel.attributedText = attributedText
            } else {
                subtitleLabel.text = subtitle
            }

            titleLabel.isHidden = titleAttributedString == nil && title.isEmpty
            subtitleLabel.isHidden = subtitleAttributedString == nil && subtitle.isEmpty

            numberLabel.text = number?.description ?? "1"
            imageView.image = image?.withRenderingMode(.alwaysTemplate)

            roundedView.backgroundColor = roundedBackgroundColor
            numberLabel.textColor = roundedTintColor
            imageView.tintColor = roundedTintColor

            numberLabel.isHidden = number == nil
            imageView.isHidden = image == nil
        }
    }
}
