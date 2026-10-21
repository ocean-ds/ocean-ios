//
//  TagAppearanceTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

final class TagAppearanceTests: XCTestCase {
    private typealias Status = OceanSwiftUI.TagParameters.Status
    private typealias Size = OceanSwiftUI.TagParameters.Size
    private typealias Appearance = OceanSwiftUI.TagParameters.Appearance

    func testAppearanceDefaultsToDefault() {
        let parameters = OceanSwiftUI.TagParameters()

        switch parameters.appearance {
        case .default:
            break
        case .translucent:
            XCTFail("Expected the default Tag appearance.")
        }
    }

    func testTranslucentColorsForSupportedStatuses() {
        let cases: [(Status, UIColor, UIColor, UIColor)] = [
            (
                .positive,
                Ocean.color.colorStatusPositiveDown.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceLightPure,
                Ocean.color.colorStatusPositiveUp
            ),
            (
                .warning,
                Ocean.color.colorStatusWarningDown.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceLightPure,
                Ocean.color.colorStatusWarningUp
            ),
            (
                .negative,
                Ocean.color.colorStatusNegativeDown.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceLightPure,
                Ocean.color.colorStatusNegativeUp
            ),
            (
                .complementary,
                Ocean.color.colorComplementaryDown.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceLightPure,
                Ocean.color.colorComplementaryUp
            ),
            (
                .neutralInterface,
                Ocean.color.colorInterfaceDarkUp.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceLightPure,
                Ocean.color.colorInterfaceLightPure
            ),
            (
                .neutralPrimary,
                Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.24),
                Ocean.color.colorInterfaceDarkDeep,
                Ocean.color.colorBrandPrimaryDown
            )
        ]

        for (status, background, text, icon) in cases {
            let tag = makeTag(status: status, appearance: .translucent)

            XCTAssertEqual(tag.getBackgroundColor(), background)
            XCTAssertEqual(tag.getColor(), text)
            XCTAssertEqual(tag.getIconColor(), icon)
        }
    }

    func testSmallAndCornerIgnoreTranslucentAppearance() {
        let cases: [(Status, Size, UIColor, UIColor)] = [
            (.positive, .small, Ocean.color.colorStatusPositiveDeep, Ocean.color.colorStatusPositiveUp),
            (.neutralInterface, .corner, Ocean.color.colorInterfaceDarkUp, Ocean.color.colorInterfaceLightUp)
        ]

        for (status, size, text, background) in cases {
            let tag = makeTag(status: status, size: size, appearance: .translucent)

            XCTAssertEqual(tag.getColor(), text)
            XCTAssertEqual(tag.getIconColor(), text)
            XCTAssertEqual(tag.getBackgroundColor(), background)
        }
    }

    func testHighlightStatusesIgnoreTranslucentAppearance() {
        let cases: [(Status, UIColor)] = [
            (.highlightImportant, Ocean.color.colorHighlightPure),
            (.highlightNeutral, Ocean.color.colorBrandPrimaryDown),
            (.highlightComplementary, Ocean.color.colorComplementaryPure)
        ]

        for (status, background) in cases {
            let tag = makeTag(status: status, appearance: .translucent)

            XCTAssertEqual(tag.getColor(), Ocean.color.colorInterfaceLightPure)
            XCTAssertEqual(tag.getIconColor(), Ocean.color.colorInterfaceLightPure)
            XCTAssertEqual(tag.getBackgroundColor(), background)
        }
    }

    private func makeTag(
        status: Status,
        size: Size = .medium,
        appearance: Appearance = .default
    ) -> OceanSwiftUI.Tag {
        let parameters = OceanSwiftUI.TagParameters(status: status, size: size, appearance: appearance)
        return OceanSwiftUI.Tag(parameters: parameters)
    }
}
