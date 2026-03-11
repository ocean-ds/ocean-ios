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
        switch self.fromToken() {
        case "positive": return Ocean.Tag.Status.positive
        case "warning": return Ocean.Tag.Status.warning
        case "negative": return Ocean.Tag.Status.negative
        case "complementary": return Ocean.Tag.Status.complementary
        case "neutral", "neutral1", "neutral01", "neutralinterface": return Ocean.Tag.Status.neutral
        case "neutralprimary", "neutral2", "neutral02": return Ocean.Tag.Status.neutralPrimary
        case "important", "highlightimportant": return Ocean.Tag.Status.highlightImportant
        case "highlight", "highlightneutral": return Ocean.Tag.Status.highlightNeutral
        default: return nil
        }
    }

    func toOceanTagStatus() -> OceanSwiftUI.TagParameters.Status? {
        let normalizedString = self.fromToken()

        switch normalizedString {
        case "positive": return OceanSwiftUI.TagParameters.Status.positive
        case "warning": return OceanSwiftUI.TagParameters.Status.warning
        case "negative": return OceanSwiftUI.TagParameters.Status.negative
        case "complementary": return OceanSwiftUI.TagParameters.Status.complementary
        case "neutral", "neutral1", "neutral01", "neutralinterface": return OceanSwiftUI.TagParameters.Status.neutralInterface
        case "neutralprimary", "neutral2", "neutral02": return OceanSwiftUI.TagParameters.Status.neutralPrimary
        case "important", "highlightimportant": return OceanSwiftUI.TagParameters.Status.highlightImportant
        case "highlight", "highlightneutral": return OceanSwiftUI.TagParameters.Status.highlightNeutral
        default: return nil
        }
    }
}
