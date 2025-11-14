//
//  View+hideIf.swift
//  Ocean
//
//  Created by Celso Oliveira Farias on 14/11/25.
//

import SwiftUI

struct HideModifier: ViewModifier {
    let isHidden: Bool

    func body(content: Content) -> some View {
        Group {
            if !isHidden {
                content
            }
        }
    }
}

extension View {
    func hideIf(_ condition: Bool) -> some View {
        modifier(HideModifier(isHidden: condition))
    }

    func hideIfEqualZero(_ value: Double?) -> some View {
        modifier(HideModifier(isHidden: (value ?? 0) == 0))
    }

    func hideIfEmpty(_ string: String?) -> some View {
        modifier(HideModifier(isHidden: string?.isEmpty ?? true))
    }
}
