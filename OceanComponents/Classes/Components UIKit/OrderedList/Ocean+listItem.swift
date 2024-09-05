//
//  Ocean+listItem.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 30/05/23.
//

import OceanTokens
import UIKit

extension Ocean {
    public typealias OrderedListItemBuilder = ((OrderedListItem) -> Void)?
    
    public struct ListItem {
        public static func ordered(builder: OrderedListItemBuilder = nil) -> OrderedListItem {
            let item = OrderedListItem(builder: builder)
            item.roundedBackgroundColor = Ocean.color.colorInterfaceLightUp
            item.roundedTintColor = Ocean.color.colorBrandPrimaryDown
            
            return item
        }
        
        public static func unordered(builder: OrderedListItemBuilder = nil) -> OrderedListItem {
            let item = OrderedListItem(builder: builder)
            item.image = Ocean.icon.chevronRightSolid
            item.roundedBackgroundColor = Ocean.color.colorStatusNegativeUp
            item.roundedTintColor = Ocean.color.colorStatusNegativePure
            
            return item
        }
        
        public static func unorderedDefault(builder: OrderedListItemBuilder = nil) -> OrderedListItem {
            let item = OrderedListItem(builder: builder)
            item.image = Ocean.icon.chevronRightSolid
            item.roundedBackgroundColor = Ocean.color.colorInterfaceLightUp
            item.roundedTintColor = Ocean.color.colorBrandPrimaryDown
            
            return item
        }
    }
}
