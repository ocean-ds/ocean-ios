//
//  CornerTagParametersTests.swift
//  OceanDesignSystemTests
//

import XCTest
@testable import OceanComponents

final class CornerTagParametersTests: XCTestCase {

    func testDefaults() {
        let params = OceanSwiftUI.CornerTagParameters()
        XCTAssertEqual(params.label, "")
        XCTAssertEqual(params.color, .primaryDown)
    }

    func testCustomLabelAndColor() {
        let params = OceanSwiftUI.CornerTagParameters(label: "Novo",
                                                     color: .complementaryPure)
        XCTAssertEqual(params.label, "Novo")
        XCTAssertEqual(params.color, .complementaryPure)
    }

    func testCardListItemAcceptsNilCornerTagByDefault() {
        let params = OceanSwiftUI.CardListItemParameters(title: "Plano")
        XCTAssertNil(params.cornerTag)
    }

    func testCardListItemAcceptsCornerTag() {
        let tag = OceanSwiftUI.CornerTagParameters(label: "Recomendado")
        let params = OceanSwiftUI.CardListItemParameters(title: "Plano", cornerTag: tag)
        XCTAssertNotNil(params.cornerTag)
        XCTAssertEqual(params.cornerTag?.label, "Recomendado")
        XCTAssertEqual(params.cornerTag?.color, .primaryDown)
    }
}
