//
//  Ocean+Banner.swift
//  FSCalendar
//
//  Created by Leticia Fernandes on 16/05/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class Banner: UIView {

        struct Constants {
            static let buttonHeight: CGFloat = 44
            static let iconWidth: CGFloat = 79
        }

        public typealias BannerBuilder = ((Banner) -> Void)?

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

        public var icon: UIImage? {
            didSet {
                updateUI()
            }
        }

        public var buttonTitle: String = "" {
            didSet {
                updateUI()
            }
        }

        public var onTouchButton: (() -> Void)?

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    contentStack
                ])

                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: 0,
                                            left: 0,
                                            bottom: 0,
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
                    roundedView
                ])
            }
        }()

        private lazy var roundedView: UIView = { 
            let view = UIView()
            view.clipsToBounds = true
            view.layer.cornerRadius = 8
            view.layer.borderWidth = 1
            view.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            return view
        }()


        lazy var gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.colors = [Ocean.color.colorBrandPrimaryPure.cgColor,
                               Ocean.color.colorComplementaryDown.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0.2)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            return gradient
        }()

        private lazy var horizontalStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .fill

                stack.add([
                    infoVerticalStack,
                    imageView
                ])
            }
        }()

        private lazy var infoVerticalStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
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
            view.clipsToBounds = true
            view.backgroundColor = Ocean.color.colorInterfaceLightPure
            return view
        }()

        private lazy var button: Ocean.ButtonText = {
            Ocean.Button.textSM { buttonText in
                buttonText.leftIcon = Ocean.icon.plusOutline
                buttonText.onTouch = {
                    self.onTouchButton?()
                }
            }
        }()

        public convenience init(builder: BannerBuilder = nil) {
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

            if (roundedView.layer.sublayers?.contains(gradient) ?? false) {
                roundedView.layer.sublayers?.remove(at: 0)
                addGradient()
            } else {
                addGradient()
            }
        }

        private func setupUI() {
            self.add(view: mainStack)
            roundedView.addSubviews(horizontalStack, containerButtonView)
            containerButtonView.addSubview(button)
            setupConstraints()
        }

        public func addGradient() {
            layoutIfNeeded()
            gradient.frame = roundedView.bounds
            roundedView.layer.insertSublayer(gradient, at: 0)
        }

        private func setupConstraints() {
            horizontalStack.setConstraints(([.topToTop(Ocean.size.spacingStackXs),
                                             .horizontalMargin(Ocean.size.spacingStackXs)], toView: roundedView))

            containerButtonView.setConstraints(([.topToBottom(Ocean.size.spacingStackXs)], toView: horizontalStack),
                                  ([.height(Constants.buttonHeight),
                                   .horizontalMargin(.zero),
                                   .bottomToBottom(.zero)], toView: roundedView))

            button.setConstraints(([.height(Constants.buttonHeight),
                                    .verticalMargin(.zero),
                                    .centerHorizontally], toView: containerButtonView))

            imageView.setConstraints((.width(Constants.iconWidth), toView: nil))
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.isSkeletonable = !subtitle.isEmpty
            imageView.image = icon
            imageView.isHidden = icon == nil
            imageView.isSkeletonable = icon != nil
            button.text = buttonTitle
        }

        public func setSkeleton() {
            self.isSkeletonable = true
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.roundedView.isSkeletonable = true
            self.horizontalStack.isSkeletonable = true
            self.infoVerticalStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
        }
    }
}
