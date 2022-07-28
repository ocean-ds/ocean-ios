//
//  Ocean+CardOption.swift
//  OceanComponents
//
//  Created by Vini on 23/07/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class CardOption: UIControl {
        struct Constants {
            static let heightLg: CGFloat = 96
            static let heightSm: CGFloat = 64
            static let roundedViewHeightWidthLg: CGFloat = 40
            static let roundedViewHeightWidthSm: CGFloat = 32
            static let iconHeightWidthLg: CGFloat = 24
            static let iconHeightWidthSm: CGFloat = 20
            static let lockImageSize: CGFloat = 16
            static let lockWidth: CGFloat = 32
        }

        public typealias OptionCardBuilder = (CardOption) -> Void

        private var heightConstraint: NSLayoutConstraint?
        private var imageHeightConstraint: NSLayoutConstraint?
        private var imageWidthConstraint: NSLayoutConstraint?
        private var iconHeightConstraint: NSLayoutConstraint?
        private var iconWidthConstraint: NSLayoutConstraint?

        private let generator = UISelectionFeedbackGenerator()

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

        public override var isSelected: Bool {
            didSet {
                isError = false
                updateState()
            }
        }

        private var isDisabled: Bool = false
        public override var isEnabled: Bool {
            get {
                return true
            }
            set {
                isDisabled = !newValue
                recommendView.isHidden = isDisabled
                updateState()
            }
        }

        public var isRecommend: Bool = false {
            didSet {
                recommendView.isHidden = !isRecommend
                updateUI()
            }
        }

        public var recommendTitle: String = "Recomendado" {
            didSet {
                updateUI()
            }
        }

        public var recommendTitleColor: UIColor = Ocean.color.colorInterfaceLightPure {
            didSet {
                updateUI()
            }
        }

        public var recommendBackgroundColor: UIColor = Ocean.color.colorComplementaryPure {
            didSet {
                updateUI()
            }
        }

        public var isError: Bool = false {
            didSet {
                updateState()
            }
        }

        public var onTouch: (() -> Void)?
        public var onTouchDisabled: (() -> Void)?

        private lazy var mainStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isUserInteractionEnabled = true

                stack.add([
                    contentStack,
                    lockView
                ])
            }
        }()

        private lazy var recommendLabel: UILabel = {
            UILabel { label in
                label.clipsToBounds = true
                label.font = .baseExtraBold(size: 10)
                label.textAlignment = .center
            }
        }()

        private lazy var recommendView: UIView = {
            let view = UIView()
            view.clipsToBounds = true
            view.layer.cornerRadius = 8
            view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
            view.addSubview(recommendLabel)
            view.isHidden = true

            self.recommendLabel.setConstraints(([.horizontalMargin(Ocean.size.spacingStackXxs),
                                                 .verticalMargin(Ocean.size.spacingStackXxxs)], toView: view))

            return view
        }()

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.spacing = 0

                stack.add([
                    roundedIconView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    textStack
                ])
            }
        }()

        private lazy var lockView: UIView = {
            let lockIcon = UIImageView { imageView in
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.image = Ocean.icon.lockClosedSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
            }

            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
            view.addSubview(lockIcon)
            view.isHidden = true

            NSLayoutConstraint.activate([
                lockIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                lockIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                lockIcon.widthAnchor.constraint(equalToConstant: Constants.lockImageSize),
                lockIcon.heightAnchor.constraint(equalToConstant: Constants.lockImageSize),
                view.widthAnchor.constraint(equalToConstant: Constants.lockWidth)
            ])

            return view
        }()

        private lazy var roundedIconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
            view.addSubview(iconView)

            NSLayoutConstraint.activate([
                iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

            return view
        }()

        private lazy var iconView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            return view
        }()

        private lazy var textStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.spacing = 0

                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                    subtitleLabel
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()


        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = 2
                label.translatesAutoresizingMaskIntoConstraints = false
                label.setContentCompressionResistancePriority(.required, for: .vertical)
            }
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            makeView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            makeView()
        }

        public convenience init(builder: OptionCardBuilder) {
            self.init(frame: .zero)
            builder(self)
        }

        private func makeView() {
            self.clipsToBounds = true
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            self.ocean.borderWidth.applyHairline()
            self.ocean.radius.applyMd()

            add(view: mainStack)
            addSubview(recommendView)

            recommendView.setConstraints(([.topToTop(.zero),
                                           .trailingToTrailing(.zero)],
                                          toView: self))

            heightConstraint = mainStack.heightAnchor.constraint(equalToConstant: Constants.heightLg)
            imageHeightConstraint = roundedIconView.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg)
            imageWidthConstraint = roundedIconView.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg)
            iconHeightConstraint = iconView.heightAnchor.constraint(equalToConstant: Constants.iconHeightWidthLg)
            iconWidthConstraint = iconView.widthAnchor.constraint(equalToConstant: Constants.iconHeightWidthLg)
            heightConstraint?.isActive = true
            imageHeightConstraint?.isActive = true
            imageWidthConstraint?.isActive = true
            iconHeightConstraint?.isActive = true
            iconWidthConstraint?.isActive = true

            self.isUserInteractionEnabled = true
            self.addTapGesture(selector: #selector(tapped(sender:)))
            self.addLongPressGesture(selector: #selector(longPressed(sender:)))
        }

        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            iconView.image = image?.withRenderingMode(.alwaysTemplate)
            recommendLabel.text = recommendTitle
            recommendLabel.textColor = recommendTitleColor
            recommendView.backgroundColor = recommendBackgroundColor

            roundedIconView.layer.cornerRadius = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm / 2 : Constants.roundedViewHeightWidthLg / 2

            heightConstraint?.constant = subtitle.isEmpty ? Constants.heightSm : Constants.heightLg
            imageHeightConstraint?.constant = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm : Constants.roundedViewHeightWidthLg
            imageWidthConstraint?.constant = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm : Constants.roundedViewHeightWidthLg
            iconHeightConstraint?.constant = subtitle.isEmpty ? Constants.iconHeightWidthSm : Constants.iconHeightWidthLg
            iconWidthConstraint?.constant = subtitle.isEmpty ? Constants.iconHeightWidthSm : Constants.iconHeightWidthLg

            let margin = subtitle.isEmpty ? Ocean.size.spacingStackXs : Ocean.size.spacingStackSm
            contentStack.setMargins(top: isRecommend ? 20 : Ocean.size.spacingStackXs,
                                    left: margin,
                                    bottom: isRecommend ? Ocean.size.spacingStackXs : Ocean.size.spacingStackXs,
                                    right: margin)
        }

        private func updateState() {
            self.backgroundColor = isSelected ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure
            self.layer.borderColor = isSelected ? Ocean.color.colorBrandPrimaryUp.cgColor : isError ? Ocean.color.colorStatusNegativePure.cgColor : Ocean.color.colorInterfaceLightDown.cgColor
            roundedIconView.backgroundColor = isSelected ? Ocean.color.colorBrandPrimaryDown : Ocean.color.colorInterfaceLightUp
            iconView.tintColor = isSelected ? .white : isDisabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown
            titleLabel.textColor = isDisabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown

            lockView.isHidden = !isDisabled
        }

        private func pressState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightDown
            self.layer.borderColor = Ocean.color.colorBrandPrimaryUp.cgColor
            roundedIconView.backgroundColor = Ocean.color.colorBrandPrimaryDown
            iconView.tintColor = .white
            titleLabel.textColor = Ocean.color.colorBrandPrimaryDown
        }

        private func animateShake(completion: (() -> Void)?) {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                completion?()
            })

            let animation = CAKeyframeAnimation(keyPath: "position.x")
            animation.values = [ 0, 10, -10, 10, 0 ]
            animation.keyTimes = [ 0, NSNumber(value: (1 / 6.0)), NSNumber(value: (3 / 6.0)), NSNumber(value: (5 / 6.0)), 1 ]
            animation.duration = 0.4
            animation.isAdditive = true
            self.layer.add(animation, forKey: "shake")

            CATransaction.commit()
        }

        @objc func tapped(sender: UITapGestureRecognizer){
            if !isDisabled {
                isSelected = true
                onTouch?()
                generator.selectionChanged()
            } else {
                animateShake(completion: self.onTouchDisabled)
            }
        }

        @objc func longPressed(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                if !isDisabled {
                    pressState()
                }
            } else if sender.state == .ended {
                if !isDisabled {
                    isSelected = true
                    onTouch?()
                    generator.selectionChanged()
                } else {
                    animateShake(completion: self.onTouchDisabled)
                }
            }
        }
    }
}
