//
//  XCTestExpectation+expectAfter.swift
//  OceanDesignSystemTests
//
//  Created by Victor C Tavernari on 26/03/2023.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import XCTest

extension XCTestExpectation {

    static func expectAfter(seconds: Double = 0.5, execute: @escaping () -> Void) -> XCTestExpectation {

        let expectation = XCTestExpectation(description: "Test after expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

            execute()
            expectation.fulfill()
        }

        return expectation
    }
}
