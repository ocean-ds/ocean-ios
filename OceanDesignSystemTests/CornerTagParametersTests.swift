//
//  CornerTagParametersTests.swift
//  OceanDesignSystemTests
//

import XCTest
@testable import OceanComponents

final class CornerTagParametersTests: XCTestCase {

    func testCardListItemAcceptsNilCornerTagByDefault() {
        let params = OceanSwiftUI.CardListItemParameters(title: "Plano")
        XCTAssertNil(params.cornerTag)
    }

    func testCardListItemAcceptsCornerTagAsTagParameters() {
        let tag = OceanSwiftUI.TagParameters(label: "Recomendado",
                                             status: .highlightNeutral,
                                             size: .corner)
        let params = OceanSwiftUI.CardListItemParameters(title: "Plano", cornerTag: tag)
        XCTAssertNotNil(params.cornerTag)
        XCTAssertEqual(params.cornerTag?.label, "Recomendado")
        XCTAssertEqual(params.cornerTag?.status, .highlightNeutral)
        XCTAssertEqual(params.cornerTag?.size, .corner)
    }

    func testTagSupportsCornerSize() {
        let tag = OceanSwiftUI.TagParameters(label: "Novo",
                                             status: .highlightComplementary,
                                             size: .corner)
        XCTAssertEqual(tag.size, .corner)
        XCTAssertEqual(tag.status, .highlightComplementary)
    }
}
