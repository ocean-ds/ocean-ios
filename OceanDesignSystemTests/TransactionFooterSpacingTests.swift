//
//  TransactionFooterSpacingTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Vertical rhythm of `TransactionFooter` against the Figma component (MR-732 / QA-08):
/// every row is an Inline Text List Item with `spacingStackXxs` of vertical padding, rows have
/// no extra gap between them, the button bar sits `spacingStackXs` below the last row and a
/// footer without rows must not pay that gap (it used to render an empty rows block plus the
/// stack spacing, doubling the space above the button).
final class TransactionFooterSpacingTests: XCTestCase {

    private let width: CGFloat = 320

    // MARK: - Helpers

    private func measuredHeight<V: View>(_ view: V) -> CGFloat {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = CGRect(x: 0, y: 0, width: width, height: 1000)
        controller.view.layoutIfNeeded()
        return controller.sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude)).height
    }

    private func footer(rows: Int) -> OceanSwiftUI.TransactionFooter {
        OceanSwiftUI.TransactionFooter { view in
            // The action is irrelevant here: only the button's footprint is measured.
            view.parameters.primaryButton = .init(text: "Escolher parcelas", style: .primary, onTouch: { /* no-op */ })
            view.parameters.padding = .init()
            view.parameters.items = (0..<rows).map { index in
                .init(text: "Linha \(index)", value: "R$ 100,00")
            }
        }
    }

    private func bareRow() -> some View {
        OceanSwiftUI.LabelValueGridRow(text: "Linha 0",
                          value: "R$ 100,00",
                          valueColor: Ocean.color.colorInterfaceDarkDeep,
                          isBoldValue: false,
                          newValue: "",
                          newValueColor: Ocean.color.colorStatusPositiveDeep,
                          imageIcon: nil as UIImage?,
                          imageColor: Ocean.color.colorStatusPositiveDeep)
    }

    // MARK: - Tests

    func testDefaultInterlineSpacingIsZeroBecauseRowsCarryTheirOwnPadding() {
        XCTAssertEqual(OceanSwiftUI.TransactionFooterParameters().interlineSpacing, 0)
    }

    func testFooterWithoutRowsHasNoGapAboveTheButton() {
        let button = measuredHeight(OceanSwiftUI.Button { view in
            view.parameters.text = "Escolher parcelas"
            view.parameters.style = .primary
        })

        XCTAssertEqual(measuredHeight(footer(rows: 0)), button, accuracy: 0.5,
                       "an empty rows block must not add the stack spacing above the button")
    }

    func testEachRowAddsItsTextPlusTheInlineTextListItemPadding() {
        let noRows = measuredHeight(footer(rows: 0))
        let oneRow = measuredHeight(footer(rows: 1))
        let twoRows = measuredHeight(footer(rows: 2))
        let rowHeight = twoRows - oneRow

        XCTAssertEqual(rowHeight, measuredHeight(bareRow()) + 2 * Ocean.size.spacingStackXxs, accuracy: 0.5,
                       "rows are spaced only by their own spacingStackXxs vertical padding")
        XCTAssertEqual(oneRow - noRows, rowHeight + Ocean.size.spacingStackXs, accuracy: 0.5,
                       "the first row also brings the spacingStackXs gap between rows and button")
    }
}
