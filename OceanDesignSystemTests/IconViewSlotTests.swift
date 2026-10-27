//
//  IconViewSlotTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the `iconView` slot of the Shortcut (`ShortcutModel`) and TextListItem
/// (`TextListItemParameters`) SwiftUI components: it is opt-in (nil by default, so the `UIImage`
/// icon keeps being drawn as a template), assignable via initializer and property, and it does not
/// disturb the icon that is already there.
///
/// The repository has no snapshot infrastructure, so the checks here are on the API and the
/// parameter contract; the rendering is validated in the showcase app.
final class IconViewSlotTests: XCTestCase {

    // MARK: - Shortcut

    func testShortcutIconViewIsNilByDefault() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title")

        XCTAssertNil(item.iconView)
    }

    func testShortcutIconViewIsAssignableViaInitializer() {
        let item = OceanSwiftUI.ShortcutModel(iconView: AnyView(Text("PC")), title: "Title")

        XCTAssertNotNil(item.iconView)
        XCTAssertNil(item.icon)
    }

    func testShortcutIconViewIsAssignableViaProperty() {
        let item = OceanSwiftUI.ShortcutModel(icon: Ocean.icon.placeholderOutline, title: "Title")

        item.iconView = AnyView(Text("PC"))

        XCTAssertNotNil(item.iconView)
        XCTAssertNotNil(item.icon)
    }

    // MARK: - TextListItem

    func testTextListItemIconViewIsNilByDefault() {
        let parameters = OceanSwiftUI.TextListItemParameters(title: "Title")

        XCTAssertNil(parameters.iconView)
        XCTAssertEqual(parameters.iconWidth, 24)
        XCTAssertEqual(parameters.iconHeight, 24)
    }

    func testTextListItemIconViewIsAssignableViaInitializer() {
        let parameters = OceanSwiftUI.TextListItemParameters(title: "Title",
                                                             iconView: AnyView(Text("PC")))

        XCTAssertNotNil(parameters.iconView)
        XCTAssertNil(parameters.icon)
    }

    func testTextListItemIconViewIsAssignableViaProperty() {
        let parameters = OceanSwiftUI.TextListItemParameters(title: "Title",
                                                             icon: Ocean.icon.placeholderOutline)

        parameters.iconView = AnyView(Text("PC"))

        XCTAssertNotNil(parameters.iconView)
        XCTAssertNotNil(parameters.icon)
    }
}
