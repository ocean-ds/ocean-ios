//
//  String+BadgeExtensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 14/12/23.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanBadgeStatus() -> OceanSwiftUI.BadgeParameters.Status? {
        switch self.lowercased() {
        case "primary": return OceanSwiftUI.BadgeParameters.Status.primary
        case "primaryinverted": return OceanSwiftUI.BadgeParameters.Status.primaryInverted
        case "warning": return OceanSwiftUI.BadgeParameters.Status.warning
        case "highlight": return OceanSwiftUI.BadgeParameters.Status.highlight
        case "disabled": return OceanSwiftUI.BadgeParameters.Status.disabled
        default: return nil
        }
    }
}
