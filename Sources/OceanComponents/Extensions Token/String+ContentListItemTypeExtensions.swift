//
//  String+ContentListItemTypeExtensions.swift
//  OceanComponents
//
//  Created by Celso Farias on 25/04/25.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanContentType() -> OceanSwiftUI.ContentListParameters.ContentListItemType? {
        switch self.lowercased() {
        case "inverted": return OceanSwiftUI.ContentListParameters.ContentListItemType.inverted
        case "inactive": return OceanSwiftUI.ContentListParameters.ContentListItemType.inactive
        case "highlight": return OceanSwiftUI.ContentListParameters.ContentListItemType.highlight
        case "default": return OceanSwiftUI.ContentListParameters.ContentListItemType.default
        default: return nil
        }
    }
}
