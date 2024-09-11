//
//  String+ButtonExtensions.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 10/09/24.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanButtonStyle() -> OceanSwiftUI.ButtonParameters.Style? {
        switch self.lowercased() {
        case "primary": return OceanSwiftUI.ButtonParameters.Style.primary
        case "secondary": return OceanSwiftUI.ButtonParameters.Style.secondary
        case "tertiary": return OceanSwiftUI.ButtonParameters.Style.tertiary
        case "primarycritical": return OceanSwiftUI.ButtonParameters.Style.primaryCritical
        case "secondarycritical": return OceanSwiftUI.ButtonParameters.Style.secondaryCritical
        case "tertiarycritical": return OceanSwiftUI.ButtonParameters.Style.tertiaryCritical
        case "primaryinverse": return OceanSwiftUI.ButtonParameters.Style.primaryInverse
        case "warning": return OceanSwiftUI.ButtonParameters.Style.warning
        default: return nil
        }
    }
}
