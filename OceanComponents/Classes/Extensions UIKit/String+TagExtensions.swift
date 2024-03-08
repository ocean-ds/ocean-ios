//
//  String+TagExtensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/08/22.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanTagStatus() -> Ocean.Tag.Status? {
        switch self.lowercased() {
        case "positive": return Ocean.Tag.Status.positive
        case "warning": return Ocean.Tag.Status.warning
        case "negative": return Ocean.Tag.Status.negative
        case "complementary", "highlight": return Ocean.Tag.Status.complementary
        case "neutral", "neutral1", "neutral2", "neutralinterface": return Ocean.Tag.Status.neutral
        case "neutralprimary": return Ocean.Tag.Status.neutralPrimary
        case "important", "highlightimportant": return Ocean.Tag.Status.highlightImportant
        case "highlightneutral": return Ocean.Tag.Status.highlightNeutral
        default: return nil
        }
    }

    func toOceanTagStatus() -> OceanSwiftUI.TagParameters.Status? {
        switch self.lowercased() {
        case "positive": return OceanSwiftUI.TagParameters.Status.positive
        case "warning": return OceanSwiftUI.TagParameters.Status.warning
        case "negative": return OceanSwiftUI.TagParameters.Status.negative
        case "complementary", "highlight": return OceanSwiftUI.TagParameters.Status.complementary
        case "neutral", "neutral1", "neutral2", "neutralinterface": return OceanSwiftUI.TagParameters.Status.neutralInterface
        case "neutralprimary": return OceanSwiftUI.TagParameters.Status.neutralPrimary
        case "important", "highlightimportant": return OceanSwiftUI.TagParameters.Status.important
        case "highlightneutral": return OceanSwiftUI.TagParameters.Status.neutral
        default: return nil
        }
    }
}
