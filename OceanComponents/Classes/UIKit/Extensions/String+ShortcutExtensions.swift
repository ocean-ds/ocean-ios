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
}
