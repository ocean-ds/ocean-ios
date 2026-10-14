//
//  IconProviderTests.swift
//  OceanDesignSystemTests
//

import XCTest
import UIKit
@testable import OceanComponents

final class IconProviderTests: XCTestCase {

    override func tearDown() {
        Ocean.iconProvider = nil
        super.tearDown()
    }

    func testUnknownTokenReturnsNilWithoutProvider() {
        Ocean.iconProvider = nil
        XCTAssertNil("um-token-que-nao-existe".toOceanIcon())
    }

    func testUnknownTokenUsesProviderWhenSet() {
        let expected = UIImage()
        Ocean.iconProvider = { token in
            token == "productfoooutline" ? expected : nil
        }
        XCTAssertTrue("product-foo-outline".toOceanIcon() === expected)
    }

    func testOceanTokenStillWinsOverProvider() {
        Ocean.iconProvider = { _ in UIImage() }
        XCTAssertTrue("apparel-outline".toOceanIcon() === Ocean.icon.apparelOutline)
    }
}
