//
//  Ocean+OptionCard.swift
//  OceanComponents
//
//  Created by Vini on 23/07/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class OptionCard: UIControl {
        struct Constants {
            static let heightLg: CGFloat = 96
            static let heightSm: CGFloat = 64
            static let roundedViewHeightWidthLg: CGFloat = 40
            static let roundedViewHeightWidthSm: CGFloat = 32
            static let iconHeightWidthLg: CGFloat = 16
            static let iconHeightWidthSm: CGFloat = 14
            static let lockWidth: CGFloat = 32
            static let recommendWidth: CGFloat = 84
            static let recommendHeight: CGFloat = 20
        }
        
        public typealias OptionCardBuilder = (OptionCard) -> Void
        
        private var heightConstraint: NSLayoutConstraint?
        private var imageHeightConstraint: NSLayoutConstraint?
        private var imageWidthConstraint: NSLayoutConstraint?
        private var iconHeightConstraint: NSLayoutConstraint?
        private var iconWidthConstraint: NSLayoutConstraint?
        
        private let generator = UISelectionFeedbackGenerator()
        
        public lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fillProportionally
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isUserInteractionEnabled = true
                
                stack.add([
                    headStack,
                    lockView
                ])
            }
        }()
        
        public lazy var headStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fillProportionally
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    recommendView,
                    contentStack
                ])
            }
        }()
        
        public lazy var recommendView: UIView = {
            let recommendLabel = UILabel { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.clipsToBounds = true
                label.font = .baseBold(size: 10)
                label.textColor = .white
                label.text = "Recomendado"
                label.textAlignment = .center
                label.backgroundColor = Ocean.color.colorComplementaryPure
                label.layer.cornerRadius = 8
                if #available(iOS 11.0, *) {
                    label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
                }
            }
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(recommendLabel)
            view.isHidden = true
            
            NSLayoutConstraint.activate([
                recommendLabel.widthAnchor.constraint(equalToConstant: Constants.recommendWidth),
                recommendLabel.heightAnchor.constraint(equalToConstant: Constants.recommendHeight),
                recommendLabel.topAnchor.constraint(equalTo: view.topAnchor),
                recommendLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            return view
        }()
        
        public lazy var contentStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fillProportionally
                stack.spacing = 0
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    roundedIconView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    textStack
                ])
                
                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackSm,
                                            left: Ocean.size.spacingStackSm,
                                            bottom: Ocean.size.spacingStackSm,
                                            right: Ocean.size.spacingStackSm)
            }
        }()
        
        public lazy var lockView: UIView = {
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
                lockIcon.widthAnchor.constraint(equalToConstant: Constants.iconHeightWidthLg),
                lockIcon.heightAnchor.constraint(equalToConstant: Constants.iconHeightWidthLg),
                view.widthAnchor.constraint(equalToConstant: Constants.lockWidth)
            ])
            
            return view
        }()
        
        public lazy var roundedIconView: UIView = {
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
        
        public lazy var iconView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            return view
        }()
        
        public lazy var textStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fillProportionally
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    titleLabel,
                    subtitleLabelSpacer,
                    subtitleLabel
                ])
            }
        }()
        
        public lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var subtitleLabelSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)
        
        public lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        public var onTouch: (() -> Void)?
        public var onTouchDisabled: (() -> Void)?

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
            }
        }
        
        public var isError: Bool = false {
            didSet {
                updateState()
            }
        }
        
        private func updateUI() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabelSpacer.isHidden = subtitle.isEmpty
            iconView.image = image?.withRenderingMode(.alwaysTemplate)
            
            roundedIconView.layer.cornerRadius = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm / 2 : Constants.roundedViewHeightWidthLg / 2
            
            heightConstraint?.constant = subtitle.isEmpty ? Constants.heightSm : Constants.heightLg
            imageHeightConstraint?.constant = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm : Constants.roundedViewHeightWidthLg
            imageWidthConstraint?.constant = subtitle.isEmpty ? Constants.roundedViewHeightWidthSm : Constants.roundedViewHeightWidthLg
            iconHeightConstraint?.constant = subtitle.isEmpty ? Constants.iconHeightWidthSm : Constants.iconHeightWidthLg
            iconWidthConstraint?.constant = subtitle.isEmpty ? Constants.iconHeightWidthSm : Constants.iconHeightWidthLg
            
            let margin = subtitle.isEmpty ? Ocean.size.spacingStackXs : Ocean.size.spacingStackSm
            contentStack.layoutMargins = .init(top: margin,
                                               left: margin,
                                               bottom: margin,
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

        func makeView() {
            self.clipsToBounds = true
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            self.ocean.borderWidth.applyHairline()
            self.ocean.radius.applyMd()
            
            add(view: mainStack)
            
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
            self.addPressGesture(selector: #selector(pressed(gesture:)))
        }
        
        @objc func pressed(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                if !isDisabled {
                    pressState()
                }
            } else if gesture.state == .ended {
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
