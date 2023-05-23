//
//  Ocean+ChartCardItemModel.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 21/05/23.
//

import Foundation
import OceanTokens

extension Ocean {
    
    public enum ValueType {
        case percent
        case decimal
        case monetary
    }

    public struct ChartCardItemModel: Equatable {
        public var title: String
        public var subtitle: String
        public var toltipMessage: String
        public var value: Double
        public var color: UIColor
        public var valueType: ValueType
        
        public init(title: String,
                    subtitle: String = "",
                    toltipMessage: String = "",
                    value: Double,
                    color: UIColor,
                    valueType: ValueType) {
            self.title = title
            self.subtitle = subtitle
            self.toltipMessage = toltipMessage
            self.value = value
            self.color = color
            self.valueType = valueType
        }
    }
}
