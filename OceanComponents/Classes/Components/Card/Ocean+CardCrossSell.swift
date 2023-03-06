//
//  Ocean+CardCrossSell.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 16/05/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class CardCrossSell: UIView {
        struct Constants {
            static let minHeight: CGFloat = 96
            static let iconSize: CGFloat = 72
        }

        public typealias CardCrossSellBuilder = ((CardCrossSell) -> Void)?

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

        public var titleColor: UIColor? = Ocean.color.colorInterfaceLightPure {
            didSet {
                updateUI()
            }
        }

        public var subtitleColor: UIColor? = Ocean.color.colorInterfaceLightUp {
            didSet {
                updateUI()
            }
        }

        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }

        public var buttonTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var buttonIcon: UIImage? = Ocean.icon.chevronRightSolid {
            didSet {
                updateUI()
            }
        }

        public var isLoading: Bool = false {
            didSet {
                groupCTA.isLoading = isLoading
            }
        }

        public var cardBackgroundColor: UIColor? = Ocean.color.colorInterfaceLightPure {
            didSet {
                backgroundView.layoutIfNeeded()
                backgroundView.backgroundColor = cardBackgroundColor
            }
        }

        public var cardBackgroundColors: [UIColor] = [] {
            didSet {
                backgroundView.backgroundColor = .clear
                backgroundView.layoutIfNeeded()
                gradientLayer.removeFromSuperlayer()
                gradientLayer.frame = backgroundView.bounds
                backgroundView.layer.insertSublayer(gradientLayer, at: 0)
            }
        }

        public var onTouchCard: (() -> Void)?

        private lazy var gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = cardBackgroundColors.map({ $0.cgColor })
            layer.locations = [0, 1]
            layer.startPoint = CGPoint(x: 0.25, y: 0.5)
            layer.endPoint = CGPoint(x: 0.75, y: 0.5)
            layer.cornerRadius = Ocean.size.borderRadiusMd
            return layer
        }()

        private lazy var backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = cardBackgroundColor
            view.ocean.radius.applyMd()
            return view
        }()

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.spacing = 0
                stack.distribution = .fill
                stack.alignment = .fill
                stack.ocean.radius.applyMd()
                stack.ocean.borderWidth.applyHairline()
                stack.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor

                stack.add([
                    contentStack,
                    Ocean.Divider(widthConstraint: self.widthAnchor),
                    groupCTA
                ])
            }
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.spacing = Ocean.size.spacingStackXs
                stack.addTapGesture(target: self, selector: #selector(handleOnTouch))

                stack.add([
                    infoVerticalStack,
                    imageView,
                ])

                stack.setMargins(top: Ocean.size.spacingStackXxs,
                                 left: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXxs,
                                 right: Ocean.size.spacingStackXs)

                stack.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.minHeight).isActive = true
            }
        }()

        private lazy var infoVerticalStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading
                stack.spacing = Ocean.size.spacingStackXxxs

                stack.add([
                    titleLabel,
                    subtitleLabel,
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.textColor = self.titleColor
                label.numberOfLines = 0
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = self.subtitleColor
                label.numberOfLines = 0
            }
        }()

        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit

            view.oceanConstraints
                .width(constant: Constants.iconSize)
                .height(constant: Constants.iconSize)
                .make()

            return view
        }()

        private lazy var groupCTA: Ocean.GroupCTA = {
            let view = Ocean.GroupCTA()
            view.text = buttonTitle
            view.icon = buttonIcon
            view.onTouch = {
                self.onTouchCard?()
            }
            return view
        }()

        public convenience init(builder: CardCrossSellBuilder = nil) {
            self.init()
            builder?(self)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func layoutSubviews() {
            super.layoutSubviews()
            self.gradientLayer.frame = self.backgroundView.bounds
        }

        private func setupUI() {
            self.add(view: backgroundView)
            self.add(view: mainStack)
        }

        private func updateUI() {
            titleLabel.text = title
            titleLabel.textColor = titleColor
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = subtitleColor
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.isSkeletonable = !subtitle.isEmpty
            imageView.image = image
            imageView.isHidden = image == nil
            imageView.isSkeletonable = image != nil
            groupCTA.text = buttonTitle
            groupCTA.icon = buttonIcon
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.infoVerticalStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.groupCTA.isSkeletonable = true
        }

        @objc func handleOnTouch() {
            self.onTouchCard?()
        }
    }
}
