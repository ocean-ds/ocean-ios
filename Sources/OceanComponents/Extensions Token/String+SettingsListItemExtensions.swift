//
//  String+SettingsListItemExtensions.swift
//  OceanComponents
//
//  Created by Celso Farias on 25/04/25.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanSettingsListItemType() -> OceanSwiftUI.SettingsListItemParameters.SettingsListItemType? {
        switch self.lowercased() {
        case "button": return OceanSwiftUI.SettingsListItemParameters.SettingsListItemType.button
        case "tag": return OceanSwiftUI.SettingsListItemParameters.SettingsListItemType.tag
        case "blocked": return OceanSwiftUI.SettingsListItemParameters.SettingsListItemType.blocked
        default: return nil
        }
    }
}
