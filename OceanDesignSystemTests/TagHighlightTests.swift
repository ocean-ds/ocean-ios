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

/// Covers the Tag typography/contrast rules: size drives the font size, highlight is
/// always ExtraBold (MR-836), `highlightNeutral` uses `colorBrandPrimaryDown` (MR-802) and
/// `complementary` text/icon use `colorComplementaryDeep` (MR-836).
///
/// The repository has no snapshot infrastructure, so the checks here are on the resolved
/// font and color; the visual result is validated in the showcase app.
final class TagHighlightTests: XCTestCase {

    // MARK: - SwiftUI

    func testMediumHighlightResolvesExtraBoldTwelveWhileStatusKeepsDefault() {
        let highlight = OceanSwiftUI.Tag.highlightNeutralMD { $0.parameters.label = "3x sem acréscimo" }
        let status = OceanSwiftUI.Tag.warningMD { $0.parameters.label = "Pagamento agendado" }

        XCTAssertEqual(highlight.parameters.size, .medium)
        XCTAssertEqual(highlight.resolvedLabelFont()?.pointSize, Ocean.font.fontSizeXxxs)
        XCTAssertEqual(highlight.resolvedLabelFont(), .baseExtraBold(size: Ocean.font.fontSizeXxxs))
        XCTAssertNil(status.resolvedLabelFont())
    }

    func testComplementaryTextUsesComplementaryDeep() {
        let tag = OceanSwiftUI.Tag { $0.parameters.status = .complementary }

        XCTAssertEqual(tag.getColor(), Ocean.color.colorComplementaryDeep)
        XCTAssertEqual(
            tag.getBackgroundColor(),
            Ocean.color.colorComplementaryPure.withAlphaComponent(Ocean.size.opacityLevelSemitransparent)
        )
    }

    func testSmallResolvesTenWithExtraBoldHighlight() {
        let highlight = OceanSwiftUI.Tag.highlightImportantSM { $0.parameters.label = "Novo" }
        let status = OceanSwiftUI.Tag.positiveSM { $0.parameters.label = "Pago" }

        XCTAssertEqual(highlight.parameters.size, .small)
        XCTAssertEqual(highlight.resolvedLabelFont()?.pointSize, 10)
        XCTAssertEqual(highlight.resolvedLabelFont(), .baseExtraBold(size: 10))
        XCTAssertEqual(status.resolvedLabelFont(), .baseBold(size: 10))
    }

    func testExplicitFontStillWins() {
        let custom = UIFont.systemFont(ofSize: 18)
        let tag = OceanSwiftUI.Tag.highlightNeutralSM { $0.parameters.font = custom }

        XCTAssertEqual(tag.resolvedLabelFont(), custom)
    }

    func testHighlightNeutralBackgroundIsBrandPrimaryDown() {
        let neutral = OceanSwiftUI.Tag.highlightNeutralMD()
        let important = OceanSwiftUI.Tag.highlightImportantMD()

        XCTAssertEqual(neutral.getBackgroundColor(), Ocean.color.colorBrandPrimaryDown)
        XCTAssertEqual(important.getBackgroundColor(), Ocean.color.colorHighlightPure)
    }

    func testTranslucentUsesStatusDownAtTwentyFourPercentWithLightLabel() {
        let positive = OceanSwiftUI.Tag.positiveMD { $0.parameters.appearance = .translucent }
        let negative = OceanSwiftUI.Tag.negativeMD { $0.parameters.appearance = .translucent }

        XCTAssertEqual(positive.getColor(), Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(positive.getBackgroundColor(), Ocean.color.colorStatusPositiveDown.withAlphaComponent(0.24))
        XCTAssertEqual(negative.getColor(), Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(negative.getBackgroundColor(), Ocean.color.colorStatusNegativeDown.withAlphaComponent(0.24))
    }

    func testTranslucentNeutralPrimaryKeepsDarkLabel() {
        let tag = OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralPrimary
            tag.parameters.appearance = .translucent
        }

        XCTAssertEqual(tag.getColor(), Ocean.color.colorInterfaceDarkDeep)
        XCTAssertEqual(tag.getBackgroundColor(), Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.24))
    }

    func testTranslucentHighlightAndDefaultAppearanceKeepTheirColors() {
        let highlight = OceanSwiftUI.Tag.highlightNeutralMD { $0.parameters.appearance = .translucent }
        let positive = OceanSwiftUI.Tag.positiveMD()

        XCTAssertEqual(positive.parameters.appearance, .default)
        XCTAssertEqual(highlight.getBackgroundColor(), Ocean.color.colorBrandPrimaryDown)
        XCTAssertEqual(positive.getBackgroundColor(), Ocean.color.colorStatusPositiveUp)
    }

    // MARK: - UIKit

    func testUIKitHighlightIsExtraBoldAndUsesBrandPrimaryDown() {
        let highlight = Ocean.Tag { tag in
            tag.title = "3x sem acréscimo"
            tag.status = .highlightNeutral
        }
        let status = Ocean.Tag { tag in
            tag.title = "Pagamento agendado"
            tag.status = .warning
        }

        XCTAssertEqual(highlight.backgroundColor, Ocean.color.colorBrandPrimaryDown)
        XCTAssertEqual(firstLabel(in: highlight)?.font, .baseExtraBold(size: Ocean.font.fontSizeXxxs))
        XCTAssertEqual(firstLabel(in: status)?.font, .baseSemiBold(size: Ocean.font.fontSizeXxxs))
    }

    func testUIKitComplementaryTextUsesComplementaryDeep() {
        let tag = Ocean.Tag { tag in
            tag.title = "Pagamento agendado"
            tag.status = .complementary
        }

        XCTAssertEqual(firstLabel(in: tag)?.textColor, Ocean.color.colorComplementaryDeep)
    }

    private func firstLabel(in view: UIView) -> UILabel? {
        if let label = view as? UILabel { return label }
        for subview in view.subviews {
            if let label = firstLabel(in: subview) { return label }
        }
        return nil
    }
}
