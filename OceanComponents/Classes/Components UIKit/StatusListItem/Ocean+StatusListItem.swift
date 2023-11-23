//
//  Ocean+StatusListItem.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/11/23.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class StatusListItem: UIView {
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

        public var caption: String = "" {
            didSet {
                updateUI()
            }
        }

        public var tagTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var tagStatus: Ocean.Tag.Status = .neutral {
            didSet {
                updateUI()
            }
        }

        public var iconTrailing: UIImage? {
            didSet {
                updateUI()
            }
        }

        public var hasDivider: Bool = true {
            didSet {
                updateUI()
            }
        }

        public var onTouchButton: (() -> Void)?

        lazy var titleLabel = Ocean.Typography.paragraph()

        lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = 0
            }
        }()

        lazy var captionLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
            }
        }()

        lazy var infoTag: Ocean.Tag = {
            Ocean.Tag { view in
                view.status = .warning
            }
        }()

        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.tintColor = Ocean.color.colorInterfaceDarkUp

            return view
        }()

        private lazy var divider = Ocean.Divider()

        private lazy var captionSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    titleLabel,
                    subtitleLabel,
                    captionSpacer,
                    captionLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    infoStack,
                    infoTag,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    imageView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .fill

                stack.add([
                    contentStack,
                    divider
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

        private func setupUI() {
            add(view: mainStack)
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            captionLabel.text = caption
            captionLabel.isHidden = caption.isEmpty
            captionSpacer.isHidden = caption.isEmpty
            infoTag.title = tagTitle
            infoTag.status = tagStatus
            infoTag.isHidden = tagTitle.isEmpty
            imageView.image = iconTrailing?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = iconTrailing == nil
            divider.isHidden = !hasDivider
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.mainStack.isSkeletonable = true

            titleLabel.isSkeletonable = true
            subtitleLabel.isSkeletonable = true
            captionLabel.isSkeletonable = true
            infoTag.setSkeleton()
        }
    }
}
