//
//  TagHighlightTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the Tag typography/contrast rule (MR-802): typography is resolved by `size`
/// (highlight included) and `highlightNeutral` uses `colorBrandPrimaryPure`.
///
/// The repository has no snapshot infrastructure, so the checks here are on the resolved
/// font and color; the visual result is validated in the showcase app.
final class TagHighlightTests: XCTestCase {

    // MARK: - SwiftUI

    func testMediumHighlightResolvesSameTypographyAsMediumStatus() {
        let highlight = OceanSwiftUI.Tag.highlightNeutralMD { $0.parameters.label = "3x sem acréscimo" }
        let status = OceanSwiftUI.Tag.warningMD { $0.parameters.label = "Pagamento agendado" }

        XCTAssertEqual(highlight.parameters.size, .medium)
        XCTAssertNil(highlight.resolvedLabelFont())
        XCTAssertEqual(highlight.resolvedLabelFont(), status.resolvedLabelFont())
    }

    func testSmallResolvesBoldTen() {
        let highlight = OceanSwiftUI.Tag.highlightImportantSM { $0.parameters.label = "Novo" }
        let status = OceanSwiftUI.Tag.positiveSM { $0.parameters.label = "Pago" }

        XCTAssertEqual(highlight.parameters.size, .small)
        XCTAssertEqual(highlight.resolvedLabelFont()?.pointSize, 10)
        XCTAssertEqual(highlight.resolvedLabelFont(), status.resolvedLabelFont())
    }

    func testExplicitFontStillWins() {
        let custom = UIFont.systemFont(ofSize: 18)
        let tag = OceanSwiftUI.Tag.highlightNeutralSM { $0.parameters.font = custom }

        XCTAssertEqual(tag.resolvedLabelFont(), custom)
    }

    func testHighlightNeutralBackgroundIsBrandPrimaryPure() {
        let neutral = OceanSwiftUI.Tag.highlightNeutralMD()
        let important = OceanSwiftUI.Tag.highlightImportantMD()

        XCTAssertEqual(neutral.getBackgroundColor(), Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(important.getBackgroundColor(), Ocean.color.colorHighlightPure)
    }

    // MARK: - UIKit

    func testUIKitHighlightKeepsSizeTypographyAndUsesBrandPrimaryPure() {
        let highlight = Ocean.Tag { tag in
            tag.title = "3x sem acréscimo"
            tag.status = .highlightNeutral
        }
        let status = Ocean.Tag { tag in
            tag.title = "Pagamento agendado"
            tag.status = .warning
        }

        XCTAssertEqual(highlight.backgroundColor, Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(firstLabel(in: highlight)?.font, firstLabel(in: status)?.font)
        XCTAssertEqual(firstLabel(in: highlight)?.font, .baseSemiBold(size: Ocean.font.fontSizeXxxs))
    }

    private func firstLabel(in view: UIView) -> UILabel? {
        if let label = view as? UILabel { return label }
        for subview in view.subviews {
            if let label = firstLabel(in: subview) { return label }
        }
        return nil
    }
}
