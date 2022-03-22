//
//  Ocean+TextListCell.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public enum TextListType {
        case normal
        case inverse
        case inverseHighlight
    }

    public class TextListCell: UIView {
        struct Constants {
            static let roundedViewHeightWidth: CGFloat = 40
        }

        public var isInverse: Bool = false

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

        public var text: String = "" {
            didSet {
                updateUI()
            }
        }

        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }

        public var arrow: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var swipe: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var badge: Bool = false {
            didSet {
                updateUI()
            }
        }

        public var buttonTitle: String? = nil {
            didSet {
                updateUI()
            }
        }

        public var onTouchButton: (() -> Void)? {
            didSet {
                updateUI()
            }
        }

        public var onTouch: (() -> Void)?

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    contentStack
                ])

                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                            left: 0,
                                            bottom: Ocean.size.spacingStackXs,
                                            right: 0)
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
                    roundedIconView,
                    roundedIconViewSpacer,
                    infoStack,
                    arrowImageViewSpacer,
                    arrowImageView,
                    button,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    swipeImageView,
                    swipeImageViewSpacer
                ])
            }
        }()

        private lazy var roundedIconViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var roundedIconView: Ocean.RoundedIcon = {
            Ocean.RoundedIcon { view in
                view.roundedBackgroundColor = Ocean.color.colorInterfaceLightUp
            }
        }()

        private lazy var arrowImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)

        private lazy var arrowImageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = Ocean.icon.chevronRightSolid
            view.contentMode = .scaleAspectFit
            return view
        }()

        private lazy var swipeImageView: UIImageView = {
            let view = UIImageView()
            view.image = Ocean.icon.swipe
            return view
        }()

        private lazy var swipeImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)

        private lazy var badgeView = Ocean.Badge.text()

        private lazy var infoStackTitle: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    badgeView
                ])
            }
        }()

        private lazy var infoStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    infoStackTitle,
                    subtitleLabel,
                    textLabel
                ])
            }
        }()

        private lazy var button: UIButton = {
            UIButton(frame: .zero)
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = 1
            }
        }()

        private lazy var textLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 1
            }
        }()

        public convenience init(type: TextListType = .normal, builder: TextListCellBuilder = nil) {
            self.init()
            if type == .inverse {
                setupInverse()
            } else if type == .inverseHighlight {
                setupInverseHighlight()
            }
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupInverse() {
            self.isInverse = true
            self.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            self.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            self.subtitleLabel.font = .baseRegular(size: Ocean.font.fontSizeXs)
            self.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkPure
            self.subtitleLabel.numberOfLines = 0
        }

        private func setupInverseHighlight() {
            self.isInverse = true
            self.titleLabel.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            self.titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            self.subtitleLabel.font = .baseBold(size: Ocean.font.fontSizeSm)
            self.subtitleLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            self.subtitleLabel.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            self.subtitleLabel.numberOfLines = 0
        }

        private func setupUI() {
            self.add(view: mainStack)

            self.addTapGesture(selector: #selector(viewTapped))
        }

        private func updateUI() {
            let imageNotExist = image == nil

            titleLabel.text = title
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.text = subtitle
            textLabel.isHidden = text.isEmpty
            textLabel.text = text
            roundedIconView.image = image
            roundedIconViewSpacer.isHidden = imageNotExist
            roundedIconView.isHidden = imageNotExist
            arrowImageViewSpacer.isHidden = !arrow
            arrowImageView.isHidden = !arrow
            swipeImageView.isHidden = !swipe
            swipeImageViewSpacer.isHidden = !swipe
            badgeView.isHidden = !badge
            button.isHidden = true

            if let title = buttonTitle {
                setupButton(title: title)
            }

            if isInverse {
                if imageNotExist {
                    mainStack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                                left: 0,
                                                bottom: Ocean.size.spacingStackXxs,
                                                right: 0)
                } else {
                    mainStack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                                left: 0,
                                                bottom: Ocean.size.spacingStackXs,
                                                right: 0)
                }
            }
        }

        private func setupButton(title: String) {
            button.isHidden = false
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            button.titleLabel?.font = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXxs)
            button.setTitleColor(Ocean.color.colorBrandPrimaryPure, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: Ocean.size.spacingInsetXs, left: Ocean.size.spacingInsetSm, bottom: Ocean.size.spacingInsetXs, right: Ocean.size.spacingInsetSm)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.6
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.roundedIconView.isSkeletonable = true
            self.roundedIconView.isSkeletonable = true
            self.infoStackTitle.isSkeletonable = true
            self.infoStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.subtitleLabel.isSkeletonable = true
            self.textLabel.isSkeletonable = true
        }

        public func setSkeletonInverse() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.infoStack.isSkeletonable = true
        }

        @objc func viewTapped() {
            self.onTouch?()
        }

        @objc private func buttonTapped() {
            self.onTouchButton?()
        }
    }
}
