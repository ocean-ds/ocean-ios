//
//  OceanSwiftUI+OrderedListItemBuilder.swift
//  Charts
//
//  Created by Acassio Mendonça on 29/11/23.
//

import Foundation
import OceanTokens

extension OceanSwiftUI.OrderedListItem {
    public static func orderedDefault(builder: OceanSwiftUI.OrderedListItem.Builder? = nil) -> OceanSwiftUI.OrderedListItem {
        return OceanSwiftUI.OrderedListItem { alert in
            alert.parameters.style = .ordered
            alert.parameters.status = .info
            builder?(alert)
        }
    }
    
    public static func orderedNegative(builder: OceanSwiftUI.OrderedListItem.Builder? = nil) -> OceanSwiftUI.OrderedListItem {
        return OceanSwiftUI.OrderedListItem { alert in
            alert.parameters.style = .ordered
            alert.parameters.status = .negative
            builder?(alert)
        }
    }
    
    public static func unorderedDefault(builder: OceanSwiftUI.OrderedListItem.Builder? = nil) -> OceanSwiftUI.OrderedListItem {
        return OceanSwiftUI.OrderedListItem { alert in
            alert.parameters.style = .unordered
            alert.parameters.status = .info
            builder?(alert)
        }
    }
    
    public static func unorderedNegative(builder: OceanSwiftUI.OrderedListItem.Builder? = nil) -> OceanSwiftUI.OrderedListItem {
        return OceanSwiftUI.OrderedListItem { alert in
            alert.parameters.style = .unordered
            alert.parameters.status = .negative
            builder?(alert)
        }
    }
}
