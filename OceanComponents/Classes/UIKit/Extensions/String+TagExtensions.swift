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
        case "complementary": return Ocean.Tag.Status.complementary
        case "neutral": return Ocean.Tag.Status.neutral
        default: return nil
        }
    }
}
