//
//  BadgeComponentTests.swift
//  OceanDesignSystemTests
//
//  Created by Victor C Tavernari on 26/03/2023.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import OceanDesignSystem
@testable import OceanTokens
@testable import OceanComponents

final class BadgeComponentTests: XCTestCase {

    func testBadgeTiny() throws {

        let badge = Ocean.Badge.tiny()
        assertSnapshot(matching: badge, as: .image)
    }

    func testBadgePrimary() throws {

        let badge = Ocean.Badge.number { view in
            view.status = .primary
            view.number = 99
        }

        assertSnapshot(matching: badge, as: .image)
    }

    func testBadgeComplementary() throws {

        let badge = Ocean.Badge.number { view in
            view.status = .complementary
            view.number = 100
        }

        assertSnapshot(matching: badge, as: .image)
    }

    func testBadgeHighlight() throws {

        let badge = Ocean.Badge.number { view in
            view.status = .highlight
            view.number = 10
        }

        assertSnapshot(matching: badge, as: .image)
    }

    func testBadgeAlertSmall() throws {

        let badge = Ocean.Badge.number { view in
            view.status = .alert
            view.size = .small
            view.number = 5
        }

        assertSnapshot(matching: badge, as: .image)
    }

    func testBadgeNeutralSmall() throws {

        let badge = Ocean.Badge.number { view in
            view.status = .neutral
            view.size = .small
            view.number = 10
        }

        assertSnapshot(matching: badge, as: .image)
    }
}

