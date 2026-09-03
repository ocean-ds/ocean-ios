//
//  InlineTextListItemGridTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the `item`-based render branch of `InlineTextListItem` (MR-732 / QA-07): the row is a
/// two-column grid where both columns share the available width equally and each side wraps
/// inside its own column, so neither text grows into the other one.
///
/// The repository has no snapshot infrastructure, so the checks here are on the API and the
/// parameter contract; the visual result is validated in the showcase app.
final class InlineTextListItemGridTests: XCTestCase {

    // MARK: - Helpers

    private func makeItem(text: String = "Pague em",
                          value: String = "3x de R$ 116,67 sem acréscimo",
                          isBoldValue: Bool = false,
                          newValue: String = "") -> OceanSwiftUI.InlineTextListItemParameters.ItemModel {
        .init(text: text,
              value: value,
              isBoldValue: isBoldValue,
              newValue: newValue)
    }

    // MARK: - The item branch is the one under test

    func testViewUsesTheItemBranchWhenItemIsSet() {
        let item = makeItem()

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertNotNil(view.parameters.item)
        XCTAssertEqual(view.parameters.item?.text, "Pague em")
        XCTAssertEqual(view.parameters.item?.value, "3x de R$ 116,67 sem acréscimo")
    }

    func testViewFallsBackToTheTitleBranchWhenItemIsNil() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.title = "Pague em"
            component.parameters.description = "3x de R$ 116,67"
        }

        XCTAssertNil(view.parameters.item)
        XCTAssertEqual(view.parameters.title, "Pague em")
    }

    // MARK: - Grid variations (the QA-07 defect)

    func testViewIsBuiltWithALongValueThatHasToWrap() {
        let item = makeItem(value: "6x de R$ 96,33 com a 1ª e a 2ª sem acréscimo")

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertEqual(view.parameters.item?.value,
                       "6x de R$ 96,33 com a 1ª e a 2ª sem acréscimo")
        XCTAssertTrue(view.parameters.item?.text.isEmpty == false)
    }

    func testViewIsBuiltWithALongLabelAndALongValue() {
        let item = makeItem(text: "Total a pagar com acréscimo",
                            value: "6x de R$ 96,33 com a 1ª e a 2ª sem acréscimo")

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertEqual(view.parameters.item?.text, "Total a pagar com acréscimo")
    }

    func testViewIsBuiltWithBothColumnsLong() {
        let item = makeItem(text: "Economia com antecipação grátis",
                            value: "Valor economizado em antecipação")

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertEqual(view.parameters.item?.text, "Economia com antecipação grátis")
        XCTAssertEqual(view.parameters.item?.value, "Valor economizado em antecipação")
    }

    // MARK: - Non-regression of the other item combinations

    func testViewIsBuiltWithBoldValue() {
        let item = makeItem(value: "R$ 350,00", isBoldValue: true)

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertEqual(view.parameters.item?.isBoldValue, true)
    }

    func testViewIsBuiltWithStrikethroughAndNewValue() {
        let item = makeItem(value: "R$ 350,00", newValue: "R$ 320,00")

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertEqual(view.parameters.item?.value, "R$ 350,00")
        XCTAssertEqual(view.parameters.item?.newValue, "R$ 320,00")
    }

    func testViewIsBuiltWithImageIcon() {
        let item = OceanSwiftUI.InlineTextListItemParameters.ItemModel(
            text: "Pague em",
            value: "3x de R$ 116,67",
            imageIcon: UIImage(),
            imageColor: Ocean.color.colorStatusPositiveDeep
        )

        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = item
        }

        XCTAssertNotNil(view.parameters.item?.imageIcon)
    }

    func testViewIsBuiltWithTagAlongsideTheItem() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem()
            component.parameters.tag = OceanSwiftUI.TagParameters(label: "sem acréscimo")
        }

        XCTAssertNotNil(view.parameters.tag)
        XCTAssertNotNil(view.parameters.item)
    }

    func testViewIsBuiltWithRoundedIconAlongsideTheItem() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem()
            component.parameters.icon = OceanSwiftUI.RoundedIconParameters()
        }

        XCTAssertNotNil(view.parameters.icon)
    }

    func testViewIsBuiltWithButtonAlongsideTheItem() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem()
            component.parameters.button = OceanSwiftUI.ButtonParameters(text: "Ver mais")
        }

        XCTAssertNotNil(view.parameters.button)
    }

    func testViewIsBuiltWithEmptyValue() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(value: "")
        }

        XCTAssertEqual(view.parameters.item?.value, "")
    }

    // MARK: - Skeleton keeps precedence over both branches

    func testSkeletonTakesPrecedenceOverTheItemBranch() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem()
            component.parameters.showSkeleton = true
        }

        XCTAssertTrue(view.parameters.showSkeleton)
        XCTAssertNotNil(view.parameters.item)
    }

    // MARK: - Padding contract consumed by the app

    func testDefaultPaddingIsVerticalOnly() {
        let parameters = OceanSwiftUI.InlineTextListItemParameters()

        XCTAssertEqual(parameters.padding.leading, 0)
        XCTAssertEqual(parameters.padding.trailing, 0)
        XCTAssertEqual(parameters.padding.top, Ocean.size.spacingStackXxs)
        XCTAssertEqual(parameters.padding.bottom, Ocean.size.spacingStackXxs)
    }

    func testPaddingIsOverridableByTheConsumer() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem()
            component.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                 leading: Ocean.size.spacingStackXs,
                                                 bottom: Ocean.size.spacingStackXxs,
                                                 trailing: Ocean.size.spacingStackXs)
        }

        XCTAssertEqual(view.parameters.padding.leading, Ocean.size.spacingStackXs)
        XCTAssertEqual(view.parameters.padding.trailing, Ocean.size.spacingStackXs)
    }
}
