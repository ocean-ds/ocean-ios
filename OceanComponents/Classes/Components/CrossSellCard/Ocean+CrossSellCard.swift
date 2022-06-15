//
//  Ocean+CrossSellCard.swift
//  FSCalendar
//
//  Created by Leticia Fernandes on 16/05/22.
//

import Foundation
import OceanTokens
import UIKit
import SkeletonView

extension Ocean {
    public class CrossSellCard: UIView {

        struct Constants {
            static let buttonHeight: CGFloat = 44
            static let iconWidth: CGFloat = 80
        }

        public typealias CrossSellCardBuilder = ((CrossSellCard) -> Void)?

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
                updateUI()
            }
        }

        public var onTouchCard: (() -> Void)?

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

        private lazy var mainButton: UIButton = {
            let button = UIButton()
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(self.handleOnTouch), for: .touchUpInside)
            return button
        }()

        public convenience init(builder: CrossSellCardBuilder = nil) {
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
            self.add(view: mainStack)
            roundedView.addSubviews(horizontalStack, containerButtonView)
            self.addSubview(mainButton)

            setupConstraints()
        }

        private func setupConstraints() {
            horizontalStack.setConstraints(([.topToTop(Ocean.size.spacingStackXs),
                                             .horizontalMargin(Ocean.size.spacingStackXs)], toView: roundedView))

            containerButtonView.setConstraints(([.topToBottom(Ocean.size.spacingStackXs)], toView: horizontalStack),
                                  ([.height(Constants.buttonHeight),
                                   .horizontalMargin(.zero),
                                   .bottomToBottom(.zero)], toView: roundedView))

            imageView.setConstraints((.width(Constants.iconWidth), toView: nil))

            mainButton.setConstraints((.fillSuperView, toView: horizontalStack))
        }

        private func updateUI() {
            roundedView.backgroundColor = cardBackgroundColor
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
            self.mainStack.isSkeletonable = true
            self.contentStack.isSkeletonable = true
            self.roundedView.isSkeletonable = true
            self.horizontalStack.isSkeletonable = true
            self.infoVerticalStack.isSkeletonable = true
            self.titleLabel.isSkeletonable = true
            self.containerButtonView.isSkeletonable = true
        }

        @objc
        func handleOnTouch() {
            self.onTouchCard?()
        }
    }
}
