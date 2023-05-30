//
//  Ocean+CardGroup.swift
//  OceanComponents
//
//  Created by Vini on 08/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class CardGroup: UIView {
        public typealias CardGroupBuilder = (CardGroup) -> Void

        public var onTouch: (() -> Void)?

        struct Constants {
            static let imageSize: CGFloat = 24
            static let arrowSize: CGFloat = 20
        }

        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }

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

        public var badgeStatus: BadgeNumber.Status = .alert {
            didSet {
                updateUI()
            }
        }

        public var badgeNumber: Int? = nil {
            didSet {
                updateUI()
            }
        }

        public var cardContentView: UIView? {
            didSet {
                updateCardContentView()
            }
        }

        public var actionTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var recommend: Bool = false {
            didSet {
                updateUI()
            }
        }

        private lazy var imageView: UIImageView = {
            UIImageView { view in
                view.contentMode = .scaleAspectFit
                view.tintColor = Ocean.color.colorInterfaceDarkDeep
                view.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: Constants.imageSize)
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.text = ""
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.textAlignment = .left
                label.numberOfLines = 0
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.text = ""
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.textAlignment = .left
                label.numberOfLines = 0
            }
        }()

        private lazy var topLabelsStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .leading
            stack.spacing = Ocean.size.spacingStackXxxs

            stack.add([
                titleLabel,
                subtitleLabel
            ])
            return stack
        }()

        private lazy var badgeView = Ocean.Badge.number()

        private lazy var containerBadgeView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.addSubview(badgeView)
            view.oceanConstraints
                .width(constant: badgeView.frame.width)
                .make()

            badgeView.oceanConstraints
                .topToTop(to: view)
                .trailingToTrailing(to: view)
                .make()

            return view
        }()

        private lazy var topStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = Ocean.size.spacingStackXs
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                imageView,
                topLabelsStack,
                UIView(),
                containerBadgeView
            ])

            stack.setMargins(allMargins: Ocean.size.spacingStackXs)

            return stack
        }()

        private lazy var topDivider = Ocean.Divider(widthConstraint: self.widthAnchor)

        private lazy var groupCTA: Ocean.GroupCTA = {
            let view = Ocean.GroupCTA()
            view.text = actionTitle
            view.onTouch = {
                self.onTouch?()
            }
            return view
        }()

        private lazy var bottomDivider = Ocean.Divider(widthConstraint: self.widthAnchor)

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            stack.spacing = 0

            stack.add([
                topStack,
                bottomDivider,
                groupCTA
            ])

            return stack
        }()

        private lazy var mainView: UIView = {
            let view = UIView()
            view.ocean.radius.applyMd()
            view.ocean.borderWidth.applyHairline()
            view.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            return view
        }()

        private lazy var recommendLabel: UILabel = {
            UILabel { label in
                label.font = .baseExtraBold(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.text = "Recomendado"
            }
        }()

        private lazy var recommendView: UIView = {
            let view = recommendLabel.addMargins(horizontal: Ocean.size.spacingStackXxs)
            view.backgroundColor = Ocean.color.colorBrandPrimaryDown
            view.ocean.radius.applyMd()
            view.isHidden = true
            return view
        }()

        public convenience init(builder: CardGroupBuilder) {
            self.init()
            setupUI()
            builder(self)
        }

        private func setupUI() {
            self.backgroundColor = Ocean.color.colorInterfaceLightPure

            mainView.addSubview(mainStack)

            mainStack.oceanConstraints
                .fill(to: mainView)
                .make()

            self.addSubviews(mainView, recommendView)

            mainView.oceanConstraints
                .fill(to: self)
                .make()

            recommendView.oceanConstraints
                .topToTop(to: self, constant: -Ocean.size.spacingStackXxs)
                .leadingToLeading(to: self, constant: Ocean.size.spacingStackXs)
                .height(constant: 18)
                .make()
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.topStack.isSkeletonable = true
            self.imageView.isSkeletonable = true
            self.topLabelsStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.subtitleLabel.isSkeletonable = true
            self.containerBadgeView.isSkeletonable = true
            self.badgeView.isSkeletonable = true
            self.groupCTA.isSkeletonable = true
        }

        private func updateCardContentView() {
            guard let cardContentView = self.cardContentView else { return }
            mainStack.insertArrangedSubview(topDivider, at: 1)
            mainStack.insertArrangedSubview(cardContentView, at: 2)
        }

        private func updateUI() {
            mainView.layer.borderColor = recommend ? Ocean.color.colorBrandPrimaryUp.cgColor : Ocean.color.colorInterfaceLightDown.cgColor
            recommendView.isHidden = !recommend

            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = image == nil
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            badgeView.status = badgeStatus
            if let badgeNumber = self.badgeNumber {
                badgeView.number = badgeNumber
            }
            containerBadgeView.isHidden = badgeNumber == nil
            groupCTA.text = actionTitle
            groupCTA.isHidden = actionTitle.isEmpty
            bottomDivider.isHidden = actionTitle.isEmpty
        }
    }
}
