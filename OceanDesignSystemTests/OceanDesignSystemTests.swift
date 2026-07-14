//
//  OceanDesignSystemTests.swift
//  OceanDesignSystemTests
//
//  Created by Vini on 22/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Cobre o alinhamento de tipografia ao Figma (MR-491 / #697):
/// tokens Highlight -> Nunito Sans, heading4/5 ExtraBold, subtitle1/2 sizes e eyebrow UPPERCASE.
final class TypographyAlignmentTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Registra as fontes do bundle do OceanTokens (NunitoSans/Avenir) para que
        // UIFont(name:size:) resolva durante os testes.
        Ocean.installFonts()
    }

    // MARK: - RF-01 / CA-01: tokens Highlight resolvem para Nunito Sans

    func testHighlightFamilyTokensPointToNunitoSans() {
        XCTAssertEqual(Ocean.font.fontFamilyHighlightWeightExtraBold, "NunitoSans-ExtraBold")
        XCTAssertEqual(Ocean.font.fontFamilyHighlightWeightBold, "NunitoSans-Bold")
        XCTAssertEqual(Ocean.font.fontFamilyHighlightWeightMedium, "NunitoSans-SemiBold")
        XCTAssertEqual(Ocean.font.fontFamilyHighlightWeightRegular, "NunitoSans-Regular")
        XCTAssertEqual(Ocean.font.fontFamilyHighlightWeightLight, "NunitoSans-Light")
    }

    func testHighlightTokensDoNotReferenceAvenir() {
        let tokens = [
            Ocean.font.fontFamilyHighlightWeightExtraBold,
            Ocean.font.fontFamilyHighlightWeightBold,
            Ocean.font.fontFamilyHighlightWeightMedium,
            Ocean.font.fontFamilyHighlightWeightRegular,
            Ocean.font.fontFamilyHighlightWeightLight
        ]
        for token in tokens {
            XCTAssertFalse(token.localizedCaseInsensitiveContains("Avenir"),
                           "Token Highlight ainda aponta para Avenir: \(token)")
        }
    }

    func testHighlightFontHelpersLoadNunitoSansFamily() {
        let extraBold = UIFont.highlightExtraBold(size: Ocean.font.fontSizeXs)
        let bold = UIFont.highlightBold(size: Ocean.font.fontSizeXs)
        XCTAssertNotNil(extraBold, "highlightExtraBold não carregou — fonte não registrada?")
        XCTAssertNotNil(bold, "highlightBold não carregou — fonte não registrada?")
        // fontName (PostScript) é a identidade exata da fonte; familyName pode variar
        // entre "Nunito Sans" e "Nunito Sans ExtraBold" conforme o registro do .ttf.
        XCTAssertEqual(extraBold?.fontName, "NunitoSans-ExtraBold")
        XCTAssertEqual(bold?.fontName, "NunitoSans-Bold")
        XCTAssertEqual(extraBold?.familyName.hasPrefix("Nunito Sans"), true,
                       "ExtraBold deveria ser da família Nunito Sans, veio: \(String(describing: extraBold?.familyName))")
        XCTAssertEqual(bold?.familyName.hasPrefix("Nunito Sans"), true,
                       "Bold deveria ser da família Nunito Sans, veio: \(String(describing: bold?.familyName))")
    }

    // MARK: - CA-06 / CT-12/13: UIKit (Ocean.Typography)

    func testUIKitHeading4And5UseExtraBold() {
        let h4 = Ocean.Typography.heading4().font
        let h5 = Ocean.Typography.heading5().font
        XCTAssertEqual(h4?.fontName, "NunitoSans-ExtraBold")
        XCTAssertEqual(h4?.pointSize, Ocean.font.fontSizeXs)   // 16pt
        XCTAssertEqual(h5?.fontName, "NunitoSans-ExtraBold")
        XCTAssertEqual(h5?.pointSize, Ocean.font.fontSizeXxs)  // 14pt
    }

    func testUIKitSubtitleSizes() {
        XCTAssertEqual(Ocean.Typography.subTitle1().font?.pointSize, Ocean.font.fontSizeSm)  // 20pt
        XCTAssertEqual(Ocean.Typography.subTitle2().font?.pointSize, Ocean.font.fontSizeXs)  // 16pt
    }

    // MARK: - CA-02..04 / CT-01..05: SwiftUI (Style.getFont)

    func testSwiftUIHeading4And5UseExtraBold() {
        let h4 = OceanSwiftUI.TypographyParameters.Style.heading4.getFont()
        let h5 = OceanSwiftUI.TypographyParameters.Style.heading5.getFont()
        XCTAssertEqual(h4?.fontName, "NunitoSans-ExtraBold")
        XCTAssertEqual(h4?.pointSize, Ocean.font.fontSizeXs)
        XCTAssertEqual(h5?.fontName, "NunitoSans-ExtraBold")
        XCTAssertEqual(h5?.pointSize, Ocean.font.fontSizeXxs)
    }

    func testSwiftUISubtitleSizes() {
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.subTitle1.getFont()?.pointSize,
                       Ocean.font.fontSizeSm)  // 20pt
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.subTitle2.getFont()?.pointSize,
                       Ocean.font.fontSizeXs)  // 16pt
    }

    // MARK: - CA-07: variantes Inverse herdam as correções

    func testSwiftUIInverseInheritsCorrections() {
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.heading4Inverse.getFont()?.fontName,
                       "NunitoSans-ExtraBold")
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.heading5Inverse.getFont()?.fontName,
                       "NunitoSans-ExtraBold")
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.subTitle1Inverse.getFont()?.pointSize,
                       Ocean.font.fontSizeSm)
        XCTAssertEqual(OceanSwiftUI.TypographyParameters.Style.subTitle2Inverse.getFont()?.pointSize,
                       Ocean.font.fontSizeXs)
    }

    // MARK: - CA-05 / CT-06/07: eyebrow em UPPERCASE

    func testEyebrowIsUppercased() {
        switch OceanSwiftUI.TypographyParameters.Style.eyebrow.getTextCase() {
        case .some(.uppercase):
            break
        default:
            XCTFail("eyebrow deve renderizar em UPPERCASE via .textCase(.uppercase)")
        }
    }

    func testNonEyebrowStylesHaveNoForcedTextCase() {
        XCTAssertNil(OceanSwiftUI.TypographyParameters.Style.paragraph.getTextCase())
        XCTAssertNil(OceanSwiftUI.TypographyParameters.Style.heading1.getTextCase())
        XCTAssertNil(OceanSwiftUI.TypographyParameters.Style.caption.getTextCase())
    }
}

/// Cobre a variante visual do TransactionFooter (MR-515):
/// `variant` é aditiva e nasce em `.default` (retrocompatibilidade — RN-01 / CA-01).
final class TransactionFooterVariantTests: XCTestCase {

    func testVariantDefaultsToDefault() {
        let parameters = OceanSwiftUI.TransactionFooterParameters()
        XCTAssertEqual(parameters.variant, .default)
    }

    func testVariantCanBeSetToHighlight() {
        let parameters = OceanSwiftUI.TransactionFooterParameters(variant: .highlight)
        XCTAssertEqual(parameters.variant, .highlight)
    }

    func testSectionTitleAndBottomDividerDefaults() {
        let parameters = OceanSwiftUI.TransactionFooterParameters()
        XCTAssertEqual(parameters.sectionTitle, "")
        XCTAssertFalse(parameters.showBottomDivider)
    }

    func testSectionTitleAndBottomDividerCanBeSet() {
        let parameters = OceanSwiftUI.TransactionFooterParameters(sectionTitle: "Resumo",
                                                                  showBottomDivider: true)
        XCTAssertEqual(parameters.sectionTitle, "Resumo")
        XCTAssertTrue(parameters.showBottomDivider)
    }
}
