//
//  OceanSwiftUI+FilterBarBuilder.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 09/01/24.
//

import OceanTokens

extension OceanSwiftUI.FilterBar {
    public static func filterBar(builder: OceanSwiftUI.FilterBar.Builder? = nil) -> OceanSwiftUI.FilterBar {
        return OceanSwiftUI.FilterBar { filterBar in
            builder?(filterBar)
        }
    }
}
