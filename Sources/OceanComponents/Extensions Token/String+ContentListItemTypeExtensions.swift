//
//  String+ContentListItemTypeExtensions.swift
//  OceanComponents
//
//  Created by Celso Farias on 25/04/25.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanContentType() -> OceanSwiftUI.ContentListItemType? {
        switch self.lowercased() {
        case "inverted": return OceanSwiftUI.ContentListItemType.inverted
        case "inactive": return OceanSwiftUI.ContentListItemType.inactive
        case "highlight": return OceanSwiftUI.ContentListItemType.highlight
        case "default": return OceanSwiftUI.ContentListItemType.default
        default: return nil
        }
    }
}
