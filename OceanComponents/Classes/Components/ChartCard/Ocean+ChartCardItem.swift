//
//  Ocean+ChartCardItem.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 17/05/23.
//

import Foundation
import OceanTokens

extension Ocean {
    
    public enum ValueRepresentationType {
        case percent
        case decimal
        case monetary
    }
    
    public class ChartCardItem: UIView {
        
        struct Constants {
            static let chartCardItemHeight = 53.0
            static let iconLegendImageSpaceLeading = 5.6
            static let iconLegendImageWidth = 20.0
            static let iconLegendImageHeight = 20.0
        }
        
        // MARK: - Properties
        
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
        
        public var tooltipMessage: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var value: Double = 0 {
            didSet {
                updateUI()
            }
        }
        
        public var color: UIColor = .white {
            didSet {
                updateUI()
            }
        }
        
        public var valueRepresentationType: ValueRepresentationType = .percent {
            didSet {
                updateValueType()
            }
        }
        
        public var onLegendTapped: ((ChartCardItem) -> Void)? = nil
        
        // MARK: - Properties private
        
        private(set) var isActive: Bool  = true
        
        private lazy var dotLegendView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = Ocean.size.borderRadiusSm
            view.isSkeletonable = true
            view.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            view.skeletonCornerRadius = Float(Ocean.size.borderRadiusSm)
            
            return view
        }()
        
        private lazy var titleLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.isSkeletonable = true
            label.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            return label
        }()
        
        private lazy var iconLegendImage: UIImageView = {
            let image = UIImageView()
            image.image = Ocean.icon.infoSolid?.withTintColor(Ocean.color.colorInterfaceLightDeep)
            image.addTapGesture(target: self, selector: #selector(tooltipClick))
            image.isSkeletonable = true
            image.isUserInteractionDisabledWhenSkeletonIsActive = true
            image.isHiddenWhenSkeletonIsActive = true
            
            return image
        }()
        
        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.indicatorMargin = Ocean.size.spacingStackXxxs
                component.message = ""
            }
        }()
        
        private lazy var subtitleLegendLabel: UILabel = {
            let label = Ocean.Typography.caption()
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.isSkeletonable = true
            label.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            return label
        }()
        
        private lazy var valueLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.isSkeletonable = true
            label.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            return label
        }()
        
        // MARK: - Constructors
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Functions
        
        public func activated() {
            isActive = true
        }
        
        public func inactivated() {
            isActive = false
        }
        
        public func setOpacity(opacity: CGFloat) {
            dotLegendView.backgroundColor = color.withAlphaComponent(opacity)
            titleLegendLabel.textColor = titleLegendLabel.textColor.withAlphaComponent(opacity)
            subtitleLegendLabel.textColor = subtitleLegendLabel.textColor.withAlphaComponent(opacity)
            iconLegendImage.tintColor = iconLegendImage.backgroundColor?.withAlphaComponent(opacity)
            valueLegendLabel.textColor = valueLegendLabel.textColor.withAlphaComponent(opacity)
        }
        
        // MARK: - Functions private
        
        private func setupUI() {
            translatesAutoresizingMaskIntoConstraints = false
            self.isSkeletonable = true
            self.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            addSubview(dotLegendView)
            addSubview(iconLegendImage)
            addSubview(titleLegendLabel)
            addSubview(subtitleLegendLabel)
            addSubview(valueLegendLabel)
            
            setupConstraints()
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.addGestureRecognizer(tapGesture)
        }
        
        private func setupConstraints() {
            self.oceanConstraints
                .height(constant: Constants.chartCardItemHeight)
                .make()
            
            dotLegendView.oceanConstraints
                .centerY(to: titleLegendLabel)
                .leadingToLeading(to: self, constant: Ocean.size.spacingStackXs)
                .height(constant: Ocean.size.spacingStackXxs)
                .width(constant: Ocean.size.spacingStackXxs)
                .make()
            
            titleLegendLabel.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingStackXxs)
                .leadingToTrailing(to: dotLegendView, constant: Ocean.size.spacingStackXxs)
                .make()
            
            iconLegendImage.oceanConstraints
                .leadingToTrailing(to: titleLegendLabel,
                                   constant: Constants.iconLegendImageSpaceLeading)
                .centerY(to: titleLegendLabel)
                .width(constant: Constants.iconLegendImageWidth)
                .height(constant: Constants.iconLegendImageHeight)
                .make()
            
            subtitleLegendLabel.oceanConstraints
                .topToBottom(to: titleLegendLabel, constant: Ocean.size.spacingStackXxxs)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingStackXxs)
                .leadingToLeading(to: titleLegendLabel)
                .make()
            
            valueLegendLabel.oceanConstraints
                .centerY(to: self)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingStackXs)
                .make()
        }
        
        private func updateUI() {
            updateDotView()
            updateTitle()
            updateSubtitle()
            updateTooltip()
            updateValueType()
        }
        
        private func updateDotView() {
            dotLegendView.backgroundColor = color
        }
        
        private func updateTitle() {
            titleLegendLabel.text = title
        }
        
        private func updateSubtitle() {
            subtitleLegendLabel.text = subtitle
            subtitleLegendLabel.isHidden = subtitle.isEmpty
        }
        
        private func updateTooltip() {
            tooltip.message = tooltipMessage
            iconLegendImage.isHidden = tooltipMessage.isEmpty
        }
        
        private func updateValueType() {
            switch valueRepresentationType {
            case .decimal:
                valueLegendLabel.text = value.toDecimal()
            case .percent:
                valueLegendLabel.text = "\(value.toPercent())%"
            case .monetary:
                valueLegendLabel.text = value.toCurrency(symbolSpace: true)
            }
        }
        
        @objc private func tooltipClick() {
            tooltip.show(target: iconLegendImage,
                         position: .top,
                         presenter: self.superview ?? self)
        }
        
        @objc private func handleTap() {
            onLegendTapped?(self)
        }
    }
}
