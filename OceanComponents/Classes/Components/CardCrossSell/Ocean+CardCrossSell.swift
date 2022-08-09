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
            static let buttonHeight: CGFloat = 48
            static let iconSize: CGFloat = 80
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

        public var cardBackgroundColor: UIColor? = Ocean.color.colorBrandPrimaryPure {
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
            view.ocean.borderWidth.applyHairline()
            view.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            return view
        }()

        private lazy var infoVerticalStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading

                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingInsetXxs),
                    subtitleLabel,
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading3 { label in
                label.textColor = Ocean.color.colorInterfaceLightPure
                label.numberOfLines = 0
                label.textAlignment = .left
            }
        }()

        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceLightUp
                label.numberOfLines = 0
                label.textAlignment = .left
            }
        }()

        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }()

        private lazy var containerButtonView: UIView = {
            let view = UIView()
            view.backgroundColor = Ocean.color.colorInterfaceLightPure
            return view
        }()

        private lazy var mainButton: UIButton = {
            let button = UIButton()
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(self.handleOnTouch), for: .touchUpInside)
            return button
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

        private func setupUI() {
            self.add(view: backgroundView)
            backgroundView.addSubviews(infoVerticalStack, imageView, containerButtonView)
            self.addSubview(mainButton)

            setupConstraints()
        }

        private func setupConstraints() {
            infoVerticalStack.setConstraints(([.topToTop(Ocean.size.spacingStackXs),
                                               .leadingToLeading(Ocean.size.spacingStackXs)], toView: backgroundView),
                                             ([.trailingToLeading(Ocean.size.spacingStackXs)], toView: imageView))

            imageView.setConstraints(([.squareSize(Constants.iconSize),
                                       .trailingToTrailing(Ocean.size.spacingStackXs)], toView: backgroundView),
                                     ([.centerVertically], toView: infoVerticalStack))

            containerButtonView.setConstraints(([.topToBottom(Ocean.size.spacingStackXs)], toView: infoVerticalStack),
                                               ([.height(Constants.buttonHeight),
                                                 .horizontalMargin(.zero),
                                                 .bottomToBottom(.zero)], toView: backgroundView))

            mainButton.setConstraints(([.verticalMargin(.zero),
                                        .bondToLeading], toView: infoVerticalStack),
                                      ([.bondToTrailing], toView: imageView))
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.isSkeletonable = !subtitle.isEmpty
            imageView.image = image
            imageView.isHidden = image == nil
            imageView.isSkeletonable = image != nil

            if !buttonTitle.isEmpty, let btnIcon = buttonIcon {
                let buttonText = Ocean.Button.textSM { button in
                    button.text = buttonTitle
                    button.rightIcon = btnIcon
                    button.isRounded = false
                    button.onTouch = {
                        self.onTouchCard?()
                    }
                }
                containerButtonView.removeSubviews()
                containerButtonView.addSubview(buttonText)
                buttonText.setConstraints((.fillSuperView, toView: containerButtonView))
            }
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.backgroundView.isSkeletonable = true
            self.infoVerticalStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.containerButtonView.isSkeletonable = true
        }

        @objc func handleOnTouch() {
            self.onTouchCard?()
        }
    }
}
