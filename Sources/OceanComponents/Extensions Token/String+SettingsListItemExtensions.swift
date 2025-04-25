//
//  String+SettingsListItemExtensions.swift
//  OceanComponents
//
//  Created by Celso Farias on 25/04/25.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanSettingsListItemType() -> OceanSwiftUI.SettingsListItem.type? {
        switch self.lowercased() {
        case "button": return OceanSwiftUI.SettingsListItem.type.button
        case "tag": return OceanSwiftUI.SettingsListItem.type.tag
        case "blocked": return OceanSwiftUI.SettingsListItem.type.blocked
        default: return nil
        }
    }
}
