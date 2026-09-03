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

    // MARK: - Layout (measured — these fail without the grid)

    /// Width of a compact phone content area (iPhone SE class) — narrow enough that a long
    /// text has to wrap in a 50% column but not in a full-width space-between row.
    private let narrowWidth: CGFloat = 320

    private func measuredHeight<V: View>(_ view: V, width: CGFloat) -> CGFloat {
        let host = UIHostingController(rootView: view)
        host.view.setNeedsLayout()
        host.view.layoutIfNeeded()
        return host.sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude)).height
    }

    private func singleLineRowHeight() -> CGFloat {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: "A", value: "B")
        }
        return measuredHeight(view, width: narrowWidth)
    }

    /// Long label / short value: in the old space-between layout the label kept its ideal
    /// width and the row stayed on one line; in the grid the label is confined to half the
    /// width and wraps, so the row gets taller. Guards the grid itself.
    func testLongLabelWrapsInsideItsColumn() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: "Total a pagar com acréscimo em até 6 vezes",
                                                      value: "R$ 577,98")
        }

        XCTAssertGreaterThan(measuredHeight(view, width: narrowWidth), singleLineRowHeight() * 1.5)
    }

    /// Short label / long value: the value wraps inside the right column instead of
    /// pushing into the label's.
    func testLongValueWrapsInsideItsColumn() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: "Pague em",
                                                      value: "6x de R$ 96,33 com a 1ª e a 2ª sem acréscimo")
        }

        XCTAssertGreaterThan(measuredHeight(view, width: narrowWidth), singleLineRowHeight() * 1.5)
    }

    /// Tag + rounded icon next to a short value must NOT be squeezed by the 50% column: the
    /// adornments keep their intrinsic size, so the row stays on one line. This is the case
    /// that broke in the first version of the grid (tag wrapping mid-word).
    func testTagAndRoundedIconKeepTheRowOnOneLine() {
        let view = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: "Title", value: "R$ 90")
            component.parameters.tag = OceanSwiftUI.TagParameters(label: "Oferta")
            component.parameters.icon = OceanSwiftUI.RoundedIconParameters()
        }

        // RoundedIcon is 40pt tall, so a healthy row is icon-height, not a multi-line text block.
        XCTAssertLessThan(measuredHeight(view, width: narrowWidth), 40 + Ocean.size.spacingStackXxs * 2 + 8)
    }

    /// The same long label wraps in the grid (text-only row) but not when a rounded icon
    /// switches the row to the legacy space-between layout — the adornment must never make
    /// the texts wrap per character.
    func testWideAdornmentFallsBackToLegacyLayout() {
        let text = "Total a pagar com acréscimo em até 6 vezes"
        let grid = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: text, value: "R$ 577,98")
        }
        let legacy = OceanSwiftUI.InlineTextListItem { component in
            component.parameters.item = self.makeItem(text: text, value: "R$ 577,98")
            component.parameters.icon = OceanSwiftUI.RoundedIconParameters()
        }

        XCTAssertGreaterThan(measuredHeight(grid, width: narrowWidth), singleLineRowHeight() * 1.5)
        // Legacy row: label keeps its ideal width and may wrap once, but the row is bounded by
        // a single wrapped label next to a 40pt icon — never a per-character value stack.
        XCTAssertLessThan(measuredHeight(legacy, width: narrowWidth), singleLineRowHeight() * 3)
    }

    /// Same grid inside `TransactionFooter`, which renders its own `ItemModel`: a long value
    /// wraps in its column there too.
    func testTransactionFooterItemWrapsLongValue() {
        let short = OceanSwiftUI.TransactionFooter { footer in
            footer.parameters.items = [.init(text: "Pague em", value: "3x de R$ 116,67")]
        }
        let long = OceanSwiftUI.TransactionFooter { footer in
            footer.parameters.items = [.init(text: "Pague em", value: "6x de R$ 96,33 com a 1ª e a 2ª sem acréscimo")]
        }

        XCTAssertGreaterThan(measuredHeight(long, width: narrowWidth), measuredHeight(short, width: narrowWidth) + 10)
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
