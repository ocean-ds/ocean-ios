//
//  CardListItemTagPositionTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the CardListItem `tagPosition` prop (MR-555 / MR-552): the newly added
/// `.above` and `.below` values, and the non-regression of the pre-existing ones (RN-01).
///
/// The repository has no snapshot infrastructure, so the checks here are on the API and the
/// parameter contract; the visual fidelity of the positions is validated in the showcase app.
final class CardListItemTagPositionTests: XCTestCase {

    // MARK: - RN-01: the default does not change

    func testDefaultTagPositionIsLeading() {
        let parameters = OceanSwiftUI.CardListItemParameters()

        XCTAssertEqual(parameters.tagPosition, .leading)
    }

    func testDefaultTagPositionIsPreservedWhenOtherParametersAreSet() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             tagLabel: "3x sem acréscimo")

        XCTAssertEqual(parameters.tagPosition, .leading)
    }

    func testTrailingRemainsAssignable() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .trailing)

        XCTAssertEqual(parameters.tagPosition, .trailing)
    }

    // MARK: - New values

    func testAboveIsAssignableViaInitializer() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             caption: "Caption",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .above)

        XCTAssertEqual(parameters.tagPosition, .above)
    }

    func testBelowIsAssignableViaInitializer() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             subtitle: "Subtitle",
                                                             caption: "Caption",
                                                             tagLabel: "3x sem acréscimo",
                                                             tagPosition: .below)

        XCTAssertEqual(parameters.tagPosition, .below)
    }

    func testTagPositionIsMutableAfterInit() {
        let parameters = OceanSwiftUI.CardListItemParameters(title: "Title",
                                                             tagLabel: "3x sem acréscimo")
        parameters.tagPosition = .above

        XCTAssertEqual(parameters.tagPosition, .above)
    }

    /// The exhaustive `switch` is compile-time proof that the enum has exactly these four
    /// cases — if anyone adds or removes a value, this test stops compiling.
    func testTagPositionHasExactlyFourCases() {
        let allCases: [OceanSwiftUI.CardListItemParameters.TagPosition] =
            [.leading, .trailing, .above, .below]

        for position in allCases {
            switch position {
            case .leading, .trailing, .above, .below:
                continue
            }
        }

        XCTAssertEqual(allCases.count, 4)
    }

    // MARK: - Building the view with each position

    func testViewIsBuiltForEveryTagPosition() {
        let positions: [OceanSwiftUI.CardListItemParameters.TagPosition] =
            [.leading, .trailing, .above, .below]

        for position in positions {
            let view = OceanSwiftUI.CardListItem { card in
                card.parameters.title = "Title"
                card.parameters.subtitle = "Subtitle"
                card.parameters.caption = "Caption"
                card.parameters.tagLabel = "3x sem acréscimo"
                card.parameters.tagPosition = position
                card.parameters.hasRadioButton = true
            }

            XCTAssertEqual(view.parameters.tagPosition, position)
        }
    }

    func testViewIsBuiltWithoutTagWhenPositionIsSet() {
        let view = OceanSwiftUI.CardListItem { card in
            card.parameters.title = "Title"
            card.parameters.tagPosition = .above
        }

        XCTAssertTrue(view.parameters.tagLabel.isEmpty)
        XCTAssertEqual(view.parameters.tagPosition, .above)
    }
}
