//
//  Ocean+InformativeCardInfoListItemView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 19/05/23.
//

import UIKit
import OceanTokens

extension Ocean {
    class InformativeCardInfoListItemView: UIView {
        
        // MARK: Private properties
        
        private var model: Ocean.InformativeCardSubItemModel
        
        // MARK: Views
        
        private lazy var label: UILabel = {
            Ocean.Typography.caption { [weak self] label in
                guard let self = self else { return }
                
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = -1
            }
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = true
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.addTapGesture(target: self, selector: #selector(showTooltip))
            
            return imageView
        }()
        
        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { tooltip in
                tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
            }
        }()
        
        private lazy var valueLabel: UILabel = {
            Ocean.Typography.description { [weak self] label in
                guard let self = self else { return }
                
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = -1
            }
        }()
        
        // MARK: Constructors
        
        public init(frame: CGRect, model: Ocean.InformativeCardSubItemModel) {
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
            addSubviews(
                label,
                iconImageView,
                valueLabel
            )
            
            label.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingStackXxs)
                .leadingToLeading(to: self)
                .make()
            
            iconImageView.oceanConstraints
                .topToTop(to: label)
                .leadingToTrailing(to: label, constant: Ocean.size.spacingInlineXxxs)
                .trailingToTrailing(to: self, type: .lessThanOrEqualTo)
                .width(constant: 16)
                .height(constant: 16)
                .make()
            
            valueLabel.oceanConstraints
                .topToBottom(to: label)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .bottomToBottom(to: self)
                .make()
        }
        
        // MARK: Public methods
        
        @objc
        public func showTooltip() {
            tooltip.show(target: iconImageView, position: .bottom, presenter: getRootSuperview())
        }
        
        // MARK: Private methods
        
        private func updateUI() {
            label.text = model.labelText
            valueLabel.text = model.valueText
            tooltip.message = model.tooltipMessage
            iconImageView.isHidden = model.tooltipMessage.isEmpty
        }
    }
}
