//
//  Ocean+textlist.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public typealias TextListCellBuilder = ((TextListCell) -> Void)?
    
    public struct TextList {
        public static func cell(builder: TextListCellBuilder = nil) -> TextListCell {
            return TextListCell(builder: builder)
        }
        
        public static func cellInverse(builder: TextListCellBuilder = nil) -> TextListCell {
            return TextListCell(type: .inverse, builder: builder)
        }
        
        public static func cellInverseHighlight(builder: TextListCellBuilder = nil) -> TextListCell {
            return TextListCell(type: .inverseHighlight, builder: builder)
        }
    }
}
