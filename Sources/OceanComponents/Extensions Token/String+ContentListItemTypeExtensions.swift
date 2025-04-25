//
//  String+ContentListItemTypeExtensions.swift
//  OceanComponents
//
//  Created by Celso Farias on 25/04/25.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanContentType() -> OceanSwiftUI.SettingsListItemParameters.ContentListItemType? {
        switch self.lowercased() {
        case "inverted": return OceanSwiftUI.SettingsListItemParameters.ContentListItemType.inverted
        case "inactive": return OceanSwiftUI.SettingsListItemParameters.ContentListItemType.inactive
        case "highlight": return OceanSwiftUI.SettingsListItemParameters.ContentListItemType.highlight
        case "default": return OceanSwiftUI.SettingsListItemParameters.ContentListItemType.default
        default: return nil
        }
    }
}
