//
//  View+hideIf.swift
//  Ocean
//
//  Created by Celso Oliveira Farias on 14/11/25.
//

import SwiftUI

public struct HideModifier: ViewModifier {
    let isHidden: Bool

    public func body(content: Content) -> some View {
        if !isHidden {
            content
        }
    }
}

public extension View {
    public func hideIf(_ condition: Bool) -> some View {
        modifier(HideModifier(isHidden: condition))
    }

    public func hideIfEqualZero(_ value: Double?) -> some View {
        modifier(HideModifier(isHidden: (value ?? 0) == 0))
    }

    public func hideIfEmpty(_ string: String?) -> some View {
        modifier(HideModifier(isHidden: string?.isEmpty ?? true))
    }
}
