//
//  Ocean+ParentChildTextListChildCell.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/03/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class ParentChildTextListChildCell: UITableViewCell {
        struct Constants {
            static let height: CGFloat = 66
            static let roundedViewHeightWidth: CGFloat = 40
        }

        static let identifier = "ParentChildTextListChildCell"

        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var swipe: Bool = false {
            didSet {
                updateUI()
            }
        }

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill

                stack.add([
                    contentStack
                ])

                stack.setMargins(top: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXs)
            }
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    roundedIconView,
                    roundedIconViewSpacer,
                    infoStack,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    swipeImageView,
                    swipeImageViewSpacer
                ])
            }
        }()

        private lazy var roundedIconViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var roundedIconView: Ocean.RoundedIcon = {
            Ocean.RoundedIcon { view in
                view.roundedBackgroundColor = Ocean.color.colorInterfaceLightPure
            }
        }()

        private lazy var swipeImageView: UIImageView = {
            let view = UIImageView()
            view.image = Ocean.icon.swipe
            return view
        }()

        private lazy var swipeImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    titleLabel,
                    subtitleLabel
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
            }
        }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            self.contentView.add(view: mainStack)
            self.contentView.setConstraints(([.width(UIScreen.main.bounds.width),
                                              .height(Constants.height)], toView: nil))
            self.selectionStyle = .none
        }

        private func updateUI() {
            let imageNotExist = image == nil

            titleLabel.text = title
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.text = subtitle
            roundedIconView.image = image?.withRenderingMode(.alwaysTemplate)
            roundedIconViewSpacer.isHidden = imageNotExist
            roundedIconView.isHidden = imageNotExist
            swipeImageView.isHidden = !swipe
            swipeImageViewSpacer.isHidden = !swipe
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.subtitleLabel.isSkeletonable = true
        }
    }
}
