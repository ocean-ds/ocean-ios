//
//  Ocean+ChartCardItem.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 17/05/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ChartCardItem: UIView {
        
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
        
        public var valueRepresentationType: ValueType = .percent {
            didSet {
                updateValueType()
            }
        }
        
        public var onSelect: ((ChartCardItem?) -> Void)?
        
        public var onDeselect: ((ChartCardItem?) -> Void)?
        
        // MARK: - Properties private
        
        private(set) var isSelected: Bool  = false
        
        private lazy var dotLegendView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = Ocean.size.borderRadiusSm
            view.isSkeletonable = true
            view.skeletonCornerRadius = 4
            
            return view
        }()
        
        private lazy var titleLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.isSkeletonable = true
            
            return label
        }()
        
        private lazy var iconLegendImage: UIImageView = {
            let image = UIImageView()
            image.image = Ocean.icon.infoSolid?.withTintColor(Ocean.color.colorInterfaceLightDeep)
            image.addTapGesture(target: self, selector: #selector(tooltipClick))
            image.isSkeletonable = true
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
            
            return label
        }()
        
        private lazy var valueLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.isSkeletonable = true
            
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
        
        public func highlight() {
            self.backgroundColor = Ocean.color.colorInterfaceLightDown
            isSelected = true
            print("ASDF - highlight - \(title)")
        }
        
        public func unhighlight() {
            self.backgroundColor = .white
            isSelected = false
            print("ASDF - unhighlight - \(title)")
        }
        
        // MARK: - Functions private
        
        private func setupUI() {
            translatesAutoresizingMaskIntoConstraints = false
            self.isSkeletonable = true
            
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
                .height(constant: 53)
                .make()
            
            dotLegendView.oceanConstraints
                .centerY(to: titleLegendLabel)
                .leadingToLeading(to: self, constant: Ocean.size.spacingStackXs)
//                .leadingToLeading(to: self)
                .height(constant: Ocean.size.spacingStackXxs)
                .width(constant: Ocean.size.spacingStackXxs)
                .make()
            
            titleLegendLabel.oceanConstraints
                .topToTop(to: self, constant: Ocean.size.spacingStackXxs)
                .leadingToTrailing(to: dotLegendView, constant: Ocean.size.spacingStackXxs)
                .make()
            
            iconLegendImage.oceanConstraints
                .leadingToTrailing(to: titleLegendLabel, constant: 5.6)
                .centerY(to: titleLegendLabel)
                .width(constant: 20)
                .height(constant: 20)
                .make()
            
            subtitleLegendLabel.oceanConstraints
                .topToBottom(to: titleLegendLabel, constant: Ocean.size.spacingStackXxxs)
                .bottomToBottom(to: self, constant: -Ocean.size.spacingStackXxs)
                .leadingToLeading(to: titleLegendLabel)
                .make()
            
            valueLegendLabel.oceanConstraints
                .centerY(to: self)
                .trailingToTrailing(to: self, constant: -Ocean.size.spacingStackXs)
//                .trailingToTrailing(to: self)
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
        
        private func updateSelectionState() {
            isSelected ? highlight() : unhighlight()
        }
        
        @objc private func tooltipClick() {
            tooltip.show(target: iconLegendImage, position: .top, presenter: self.superview ?? self)
        }
        
        private var isTouchLegend: Bool = false
        
        public func legendTouch() -> Bool {
            return isTouchLegend
        }
        
        @objc private func handleTap() {
            isTouchLegend = true
            print("\n\nASDF - <<<<<<< TOQUE NA LEGENDA >>>>>>\n\n")
            if isSelected {
                updateSelectionState()
                onDeselect?(self)
            } else {
                updateSelectionState()
                onSelect?(self)
            }
        }
    }
}

