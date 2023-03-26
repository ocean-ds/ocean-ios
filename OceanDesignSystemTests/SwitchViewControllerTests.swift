//
//  SwitchViewControllerTests.swift
//  OceanDesignSystemTests
//
//  Created by Victor C Tavernari on 25/03/2023.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import OceanDesignSystem
@testable import OceanTokens
@testable import OceanComponents

final class SwitchComponentTests: XCTestCase {

    lazy var component = Ocean.Switch { component in
        component.translatesAutoresizingMaskIntoConstraints = false
    }

    func testSwitchOn() throws {

        component.isOn = true

        wait(for: [.expectAfter(execute: { assertSnapshot(matching: self.component, as: .image) })],
             timeout: .minAfterTime)
    }

    func testSwitchOff() throws {

        component.isOn = false

        wait(for: [.expectAfter(execute: { assertSnapshot(matching: self.component, as: .image) })],
             timeout: .minAfterTime)
    }
}
