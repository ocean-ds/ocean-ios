//
//  View+tooltip.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 05/03/24.
//

import SwiftUI
import OceanTokens

public extension View {
    func tooltip(_ tooltip: OceanSwiftUI.Tooltip) -> ModifiedContent<Self, OceanSwiftUI.Tooltip> {
        return modifier(tooltip)
    }
}
