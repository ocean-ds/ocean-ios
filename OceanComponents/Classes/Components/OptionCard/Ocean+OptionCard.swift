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
                stack.axis = .vertical
                stack.distribution = .fillProportionally
                stack.spacing = 0
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isUserInteractionEnabled = true
                stack.backgroundColor = Ocean.color.colorInterfaceLightPure
                stack.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
                stack.ocean.borderWidth.applyHairline()
                stack.ocean.radius.applyMd()
                
                stack.add([
                    contentStack
                ])
            }
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
                updateState()
            }
        }

        public override var isEnabled: Bool {
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
            contentStack.layoutMargins = .init(top: margin, left: margin, bottom: margin, right: margin)
        }

        private func updateState() {
            mainStack.backgroundColor = isSelected ? Ocean.color.colorInterfaceLightUp : Ocean.color.colorInterfaceLightPure
            mainStack.layer.borderColor = isSelected ? Ocean.color.colorBrandPrimaryUp.cgColor : Ocean.color.colorInterfaceLightDown.cgColor
            roundedIconView.backgroundColor = isSelected ? Ocean.color.colorBrandPrimaryDown : Ocean.color.colorInterfaceLightUp
            iconView.tintColor = isSelected ? .white : Ocean.color.colorBrandPrimaryDown
        }

        func makeView() {
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
                mainStack.backgroundColor = Ocean.color.colorInterfaceLightDown
                mainStack.layer.borderColor = Ocean.color.colorBrandPrimaryUp.cgColor
                roundedIconView.backgroundColor = Ocean.color.colorBrandPrimaryDown
                iconView.tintColor = .white
            } else {
                isSelected = true
                onTouch?()
                generator.selectionChanged()
            }
        }
    }
}
