//
//  Ocean+InformativeCardSellView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 19/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    class InformativeCardSellView: UIView {
        
        // MARK: Private properties
        
        private var model: Ocean.InformativeCardModel
        
        // MARK: Views
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.isSkeletonable = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        private lazy var iconImageContainer: UIView = {
            let view = UIView()
            view.isSkeletonable = true
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(iconImageView)
            
            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.isSkeletonable = true
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.isSkeletonable = true
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.alignment = .fill
                stack.axis = .vertical
                stack.distribution = .fill
                stack.isSkeletonable = true
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    iconImageContainer,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                    descriptionLabel
                ])
            }
        }()
        
        // MARK: Constructors
        
        public init(frame: CGRect, model: Ocean.InformativeCardModel) {
            self.model = model
            super.init(frame: frame)
            
            setupUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            
            addSubviews(contentStack)
            
            iconImageView.oceanConstraints
                .topToTop(to: iconImageContainer)
                .bottomToBottom(to: iconImageContainer)
                .centerX(to: iconImageContainer)
                .width(constant: 80)
                .height(constant: 80)
                .make()
            
            contentStack.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingInsetSm)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingInsetSm)
                .make()
        }
        
        // MARK: Public methods
        
        func update(model: InformativeCardModel) {
            self.model = model
            
            updateUI()
        }
        
        func updateUI() {
            iconImageView.image = model.iconImage
            titleLabel.text = model.titleText
            descriptionLabel.text = model.descriptionText
            descriptionLabel.isHidden = model.descriptionText.isEmpty
        }
    }
}
