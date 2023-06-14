//
//  Ocean+InformativeCardEmptyView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 19/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    class InformativeCardEmptyView: UIView {
        
        // MARK: Private properties
        
        var model: Ocean.InformativeCardModel {
            didSet {
                updateUI()
            }
        }
        
        // MARK: Views
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.isSkeletonable = true
            imageView.tintColor = Ocean.color.colorInterfaceDarkUp
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading4 { label in
                label.isSkeletonable = true
                label.numberOfLines = -1
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.isSkeletonable = true
                label.numberOfLines = -1
                label.textAlignment = .center
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.alignment = .center
                stack.axis = .vertical
                stack.distribution = .fill
                stack.isSkeletonable = true
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXl),
                    iconImageView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                    descriptionLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXl)
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
            backgroundColor = Ocean.color.colorInterfaceLightUp
            isSkeletonable = true
            addSubviews(contentStack)
            setupConstraints()
        }
        
        private func setupConstraints() {
            iconImageView.oceanConstraints
                .width(constant: 24)
                .height(constant: 24)
                .make()
            
            contentStack.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingInsetSm)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingInsetSm)
                .make()
        }
        
        // MARK: Private methods
        
        private func updateUI() {
            iconImageView.image = model.iconImage.withRenderingMode(.alwaysTemplate)
            titleLabel.text = model.titleText
            descriptionLabel.text = model.descriptionText
            descriptionLabel.isHidden = model.descriptionText.isEmpty
        }
    }
}
