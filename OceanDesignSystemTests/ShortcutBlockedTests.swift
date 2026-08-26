//
//  ShortcutBlockedTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// Covers the `blocked` contract of the Shortcut SwiftUI component: it shows the lock, keeps the
/// item disabled by default (backwards compatibility) and becomes tappable only with
/// `forceEnableActionWhenBlocked` — the case where the tap is what explains the restriction.
///
/// The repository has no snapshot infrastructure, so the checks here are on the API and the
/// parameter contract; `isActionDisabled` is the single source the view reads, which is why the
/// truth table below is the real regression guard. The gesture is validated in the showcase app.
final class ShortcutBlockedTests: XCTestCase {

    // MARK: - Default

    func testBlockedIsFalseByDefault() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title")

        XCTAssertFalse(item.blocked)
    }

    // MARK: - Assignment

    func testBlockedIsAssignableViaInitializer() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title", blocked: true)

        XCTAssertTrue(item.blocked)
    }

    func testBlockedIsAssignableViaProperty() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title")

        item.blocked = true

        XCTAssertTrue(item.blocked)
    }

    // MARK: - Interaction

    /// Tabela-verdade do `.disabled` da view. O default preserva o comportamento de sempre —
    /// bloqueado não clica — e a chave explícita é o que libera o toque.
    func testIsActionDisabledTruthTable() {
        let free = OceanSwiftUI.ShortcutModel(title: "Extrato")
        let blocked = OceanSwiftUI.ShortcutModel(title: "Antecipar vendas", blocked: true)
        let blockedTappable = OceanSwiftUI.ShortcutModel(title: "Antecipar vendas",
                                                        blocked: true,
                                                        forceEnableActionWhenBlocked: true)
        let freeWithFlag = OceanSwiftUI.ShortcutModel(title: "Extrato",
                                                      forceEnableActionWhenBlocked: true)

        XCTAssertFalse(free.isActionDisabled)
        XCTAssertTrue(blocked.isActionDisabled)
        XCTAssertFalse(blockedTappable.isActionDisabled)
        XCTAssertFalse(freeWithFlag.isActionDisabled)
    }

    func testForceEnableActionWhenBlockedIsFalseByDefault() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title", blocked: true)

        XCTAssertFalse(item.forceEnableActionWhenBlocked)
        XCTAssertTrue(item.isActionDisabled)
    }

    func testForceEnableActionWhenBlockedIsAssignableViaProperty() {
        let item = OceanSwiftUI.ShortcutModel(title: "Title", blocked: true)

        item.forceEnableActionWhenBlocked = true

        XCTAssertFalse(item.isActionDisabled)
    }

    /// `onTouch` é o caminho do item restrito que fala: é por ele que a tela abre a explicação.
    func testOnTouchIsDeliveredForABlockedItem() {
        let expectation = expectation(description: "onTouch called for a blocked item")
        let blockedItem = OceanSwiftUI.ShortcutModel(title: "Antecipar vendas",
                                                     blocked: true,
                                                     forceEnableActionWhenBlocked: true)
        let parameters = OceanSwiftUI.ShortcutParameters(items: [blockedItem]) { index, item in
            XCTAssertEqual(index, 0)
            XCTAssertTrue(item.blocked)
            expectation.fulfill()
        }

        parameters.onTouch(0, blockedItem)

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Corner slot

    /// Cadeado, tag e badge dividem o mesmo canto. O contrato é o do Ocean web: com `blocked`
    /// o cadeado vence, e tag/badge continuam no model sem serem desenhados — o item pode voltar
    /// a mostrá-los assim que a função for liberada, sem o consumidor remontar nada.
    func testBlockedItemKeepsTagAndBadgeInTheModel() {
        let item = OceanSwiftUI.ShortcutModel(badgeNumber: 2,
                                              tagLabel: "Oferta",
                                              title: "Antecipar vendas",
                                              blocked: true)

        XCTAssertTrue(item.blocked)
        XCTAssertEqual(item.tagLabel, "Oferta")
        XCTAssertEqual(item.badgeNumber, 2)
    }

    func testBlockedItemsCoexistWithUnblockedOnesInTheSameList() {
        let parameters = OceanSwiftUI.ShortcutParameters(items: [
            .init(title: "Extrato"),
            .init(title: "Antecipar vendas", blocked: true)
        ])

        XCTAssertFalse(parameters.items[0].blocked)
        XCTAssertTrue(parameters.items[1].blocked)
    }
}
