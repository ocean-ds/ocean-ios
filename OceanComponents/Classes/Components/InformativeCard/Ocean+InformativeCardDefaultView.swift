//
//  Ocean+InformativeCardDefaultView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 19/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    class InformativeCardDefaultView: UIView {
        
        // MARK: Private properties
        
        private var model: Ocean.InformativeCardModel
        
        // MARK: Views
        
        private lazy var leftIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isSkeletonable = true
            
            return imageView
        }()
        
        private lazy var rightIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = true
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isSkeletonable = true
            imageView.isHiddenWhenSkeletonIsActive = true
            
            imageView.addTapGesture(target: self, selector: #selector(showTooltip))
            
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()
        
        private lazy var valueSpacer: Ocean.Spacer = {
            let spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.isSkeletonable = false
            
            return spacer
        }()
        
        private lazy var valueLabel: UILabel = {
            Ocean.Typography.lead { label in
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()
        
        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()
        
        private lazy var subItemsStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.alignment = .fill
                stack.axis = .vertical
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isHiddenWhenSkeletonIsActive = true
                stack.isSkeletonable = true
            }
        }()
        
        private lazy var additionalInformationSpacer: Ocean.Spacer = {
            let spacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
            spacer.isSkeletonable = false
            
            return spacer
        }()
        
        private lazy var additionalInformationLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = -1
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isSkeletonable = true
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.alignment = .fill
                stack.axis = .vertical
                stack.backgroundColor = Ocean.color.colorInterfaceLightPure
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.isSkeletonable = true
                
                stack.add([
                    titleLabel,
                    valueSpacer,
                    valueLabel,
                    descriptionLabel,
                    subItemsStack,
                    additionalInformationSpacer,
                    additionalInformationLabel
                ])
            }
        }()
        
        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { tooltip in
                tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
            }
        }()
        
        // MARK: Constructors
        
        public init(frame: CGRect, model: Ocean.InformativeCardModel) {
            self.model = model
            super.init(frame: frame)
            
            setupUI()
            updateUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            
            addSubviews(leftIconImageView, rightIconImageView, contentStack)
            
            leftIconImageView.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingInsetSm)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .width(constant: 24)
                .height(constant: 24)
                .make()
            
            rightIconImageView.oceanConstraints
                .centerY(to: leftIconImageView)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
                .width(constant: 20)
                .height(constant: 20)
                .make()
            
            contentStack.oceanConstraints
                .topToBottom(to: leftIconImageView, constant: Ocean.size.spacingStackXxs)
                .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingInsetSm)
                .make()
        }
        
        // MARK: Public methods
        
        @objc
        public func showTooltip() {
            tooltip.show(target: rightIconImageView, position: .bottom, presenter: getRootSuperview())
        }
        
        func update(model: InformativeCardModel) {
            self.model = model
            
            updateUI()
        }
        
        func updateUI() {
            leftIconImageView.image = model.iconImage.withRenderingMode(.alwaysTemplate)
            tooltip.message = model.tooltipMessage
            rightIconImageView.isHidden = model.tooltipMessage.isEmpty
            titleLabel.text = model.titleText
            valueLabel.text = model.valueText
            descriptionLabel.text = model.descriptionText
            descriptionLabel.isHidden = model.descriptionText.isEmpty
            additionalInformationLabel.text = model.additionalInformationText
            additionalInformationLabel.isHidden = model.additionalInformationText.isEmpty
            additionalInformationSpacer.isHidden = additionalInformationLabel.isHidden
            
            removeSubItems()
            model.subItems.forEach { addSubItem(model: $0) }
        }
        
        // MARK: Private methods
        
        private func addSubItem(model: Ocean.InformativeCardSubItemModel) {
            let itemView = InformativeCardInfoListItemView(frame: .zero, model: model)
            
            subItemsStack.addArrangedSubview(itemView)
        }
        
        private func removeSubItem(at index: Int) {
            guard subItemsStack.arrangedSubviews.indices.contains(index) else {
                return
            }
            
            subItemsStack.removeArrangedSubview(subItemsStack.arrangedSubviews[index])
        }
        
        private func removeSubItems() {
            subItemsStack.removeAllArrangedSubviews()
        }
    }
}
