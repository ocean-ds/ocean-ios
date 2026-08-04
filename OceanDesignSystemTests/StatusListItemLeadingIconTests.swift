//
//  StatusListItemLeadingIconTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the StatusListItem `leadingIcon` prop, mirroring the CardListItem contract.
///
/// The repository has no snapshot infrastructure, so the checks here are on the API and the
/// parameter contract; the visual fidelity is validated in the showcase app.
final class StatusListItemLeadingIconTests: XCTestCase {

    // MARK: - Default

    func testLeadingIconIsNilByDefault() {
        let parameters = OceanSwiftUI.StatusListItemParameters()

        XCTAssertNil(parameters.leadingIcon)
    }

    func testLeadingIconIsNilWhenOtherParametersAreSet() {
        let parameters = OceanSwiftUI.StatusListItemParameters(title: "Title",
                                                              description: "Description",
                                                              caption: "Caption")

        XCTAssertNil(parameters.leadingIcon)
    }

    // MARK: - Assignment

    func testLeadingIconIsAssignableViaInitializer() {
        let icon = Ocean.icon.placeholderOutline!

        let parameters = OceanSwiftUI.StatusListItemParameters(title: "Title",
                                                              description: "Description",
                                                              leadingIcon: icon)

        XCTAssertEqual(parameters.leadingIcon, icon)
    }

    func testLeadingIconIsMutableAfterInit() {
        let icon = Ocean.icon.placeholderOutline!
        let parameters = OceanSwiftUI.StatusListItemParameters(title: "Title")

        parameters.leadingIcon = icon

        XCTAssertEqual(parameters.leadingIcon, icon)
    }

    func testLeadingIconIsAssignableViaBuilder() {
        let icon = Ocean.icon.placeholderOutline!

        let view = OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.leadingIcon = icon
        }

        XCTAssertEqual(view.parameters.leadingIcon, icon)
    }

    // MARK: - Coexistence with the other slots

    func testLeadingIconCoexistsWithEveryStyle() {
        let icon = Ocean.icon.placeholderOutline!
        let styles: [OceanSwiftUI.StatusListItemParameters.Style] = [.normal, .contextMenu, .readOnly]

        for style in styles {
            let view = OceanSwiftUI.StatusListItem { statusListItem in
                statusListItem.parameters.title = "Title"
                statusListItem.parameters.description = "Description"
                statusListItem.parameters.leadingIcon = icon
                statusListItem.parameters.style = style
            }

            XCTAssertEqual(view.parameters.leadingIcon, icon)
            XCTAssertEqual(view.parameters.style, style)
        }
    }

    func testLeadingIconCoexistsWithTagAndBadge() {
        let icon = Ocean.icon.placeholderOutline!

        let view = OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.leadingIcon = icon
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagPosition = .right
            statusListItem.parameters.badgeCount = 9
            statusListItem.parameters.badgePosition = .below
        }

        XCTAssertEqual(view.parameters.leadingIcon, icon)
        XCTAssertEqual(view.parameters.tagLabel, "Label")
        XCTAssertEqual(view.parameters.badgeCount, 9)
    }
}
