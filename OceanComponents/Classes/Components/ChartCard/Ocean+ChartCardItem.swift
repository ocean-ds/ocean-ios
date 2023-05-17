//
//  Ocean+ChartCardItem.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 17/05/23.
//

import Foundation
import OceanTokens

extension Ocean {

    public struct ChartCardItemModel {
        public var title: String
        public var subtitle: String
        public var toltipMessage: String
        public var value: Double
        public var color: UIColor
        
        public init(title: String,
                    subtitle: String,
                    toltipMessage: String,
                    value: Double,
                    color: UIColor) {
            self.title = title
            self.subtitle = subtitle
            self.toltipMessage = toltipMessage
            self.value = value
            self.color = color
        }
    }
    
    public class ChartCardItem: UIView {
        
        public var chartCardItemModel: ChartCardItemModel? = nil {
            didSet {
                updateUI()
            }
        }
        
        private lazy var dotLegendView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 5
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 8).isActive = true
            view.widthAnchor.constraint(equalToConstant: 8).isActive = true
           
            return view
        }()
        
        private lazy var titleLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            
            return label
        }()
        
        private lazy var iconLegendImage: UIImageView = {
            let image = UIImageView()
            image.image = Ocean.icon.infoSolid?.withTintColor(Ocean.color.colorInterfaceDarkDeep)
            image.addTapGesture(target: self, selector: #selector(tooltipClick))
            
            image.oceanConstraints
                .width(constant: 20)
                .height(constant: 20)
                .make()
            
            return image
        }()
        
        private lazy var tooltip: Ocean.Tooltip = {
            Ocean.Tooltip { component in
                component.message = ""
            }
        }()
        
        private lazy var subtitleLegendLabel: UILabel = {
            let label = Ocean.Typography.caption()
            
            return label
        }()
        
        private lazy var valueLegendLabel: UILabel = {
            let label = Ocean.Typography.description()
            
            return label
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(dotLegendView)
            addSubview(iconLegendImage)
            addSubview(titleLegendLabel)
            addSubview(subtitleLegendLabel)
            addSubview(valueLegendLabel)
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            
            dotLegendView.oceanConstraints
                .topToTop(to: self, constant: 8)
                .leadingToLeading(to: self)
                .make()
            
            titleLegendLabel.oceanConstraints
                .topToTop(to: self)
                .leadingToTrailing(to: dotLegendView, constant: 8)
                .make()
            
            iconLegendImage.oceanConstraints
                .leadingToTrailing(to: titleLegendLabel, constant: 5.6)
                .centerY(to: titleLegendLabel)
                .make()
            
            subtitleLegendLabel.oceanConstraints
                .topToBottom(to: titleLegendLabel)
                .bottomToBottom(to: self, constant: 8)
                .leadingToLeading(to: titleLegendLabel)
                .make()
            
            valueLegendLabel.oceanConstraints
                .centerY(to: self)
                .trailingToTrailing(to: self)
                .make()
        }
        
        private func updateUI() {
            guard let chartCardItemModel = chartCardItemModel else { return }
            
            dotLegendView.backgroundColor = .white //chartCardItemModel.color
            titleLegendLabel.text = chartCardItemModel.title
            subtitleLegendLabel.text = chartCardItemModel.subtitle
            tooltip.message = chartCardItemModel.toltipMessage
            valueLegendLabel.text = chartCardItemModel.value.toCurrency()
            self.backgroundColor = chartCardItemModel.color
        }
        
        @objc private func tooltipClick() {
            tooltip.show(target: iconLegendImage, position: .top, presenter: self.superview ?? self)
        }
    }
}
