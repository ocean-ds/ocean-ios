//
//  Ocean+ChardCardModel.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 21/05/23.
//

import Foundation
import OceanTokens

extension Ocean {
    
    public struct ChartCardModel {
        public var title: String
        public var subtitle: String
        public var valueCenterDonut: String
        public var labelCenterDonut: String
        public var items: [ChartCardItemModel]
        public var showLegend: Bool = true
        public var onSelect: ((ChartCardItemModel?) -> Void)?
        public var onDeselect: ((ChartCardItemModel?) -> Void)?
        public var ctaText: String
        public var ctaAction: (() -> Void)? = nil
        
        public init(title: String,
                    subtitle: String,
                    valueCenterDonut: String,
                    labelCenterDonut: String = "",
                    items: [ChartCardItemModel],
                    showLegend: Bool = true,
                    onSelect: ((ChartCardItemModel?) -> Void)? = nil,
                    onDeselect: ((ChartCardItemModel?) -> Void)? = nil,
                    ctaText: String = "",
                    ctaAction: (() -> Void)? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.valueCenterDonut = valueCenterDonut
            self.labelCenterDonut = labelCenterDonut
            self.items = items
            self.showLegend = showLegend
            self.onSelect = onSelect
            self.onDeselect = onDeselect
            self.ctaText = ctaText
            self.ctaAction = ctaAction
        }
    }
}
