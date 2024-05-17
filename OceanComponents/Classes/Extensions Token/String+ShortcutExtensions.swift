//
//  String+ShortcutExtensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 27/01/23.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanShortcutSize() -> Ocean.Shortcut.Size? {
        switch self.lowercased() {
        case "medium": return Ocean.Shortcut.Size.medium
        case "small": return Ocean.Shortcut.Size.small
        case "tiny": return Ocean.Shortcut.Size.tiny
        default: return nil
        }
    }

    func toOceanShortcutOrientation() -> Ocean.Shortcut.Orientation? {
        switch self.lowercased() {
        case "horizontal": return Ocean.Shortcut.Orientation.horizontal
        case "vertical": return Ocean.Shortcut.Orientation.vertical
        default: return nil
        }
    }

    func toOceanShortcutSize() -> OceanSwiftUI.ShortcutParameters.Size? {
        switch self.lowercased() {
        case "medium": return .medium
        case "small": return .small
        case "tiny": return .tiny
        default: return nil
        }
    }

    func toOceanShortcutOrientation() -> OceanSwiftUI.ShortcutParameters.Orientation? {
        switch self.lowercased() {
        case "horizontal": return .horizontal
        case "vertical": return .vertical
        default: return nil
        }
    }
}
