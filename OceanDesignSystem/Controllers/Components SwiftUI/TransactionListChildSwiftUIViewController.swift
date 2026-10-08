//
//  TransactionListChildSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanComponents
import OceanTokens
import SwiftUI

/// CT-5: Child Action (with chevron) in the four timeline positions and its states.
final class TransactionListChildActionSwiftUIViewController: TransactionListDemoViewController<TransactionListChildDemo> {
    init() {
        super.init { TransactionListChildDemo(hasAction: true) }
    }
}

/// CT-5: Child Read Only (no chevron) in the four timeline positions and its states.
final class TransactionListChildReadOnlySwiftUIViewController: TransactionListDemoViewController<TransactionListChildDemo> {
    init() {
        super.init { TransactionListChildDemo(hasAction: false) }
    }
}

struct TransactionListChildDemo: View {
    let hasAction: Bool
    @State private var touches = 0

    var body: some View {
        ForEach(TransactionListDemo.states, id: \.0) { title, state in
            TransactionListDemoSection(title: hasAction ? "\(title) · toques: \(touches)" : title) {
                ForEach(TransactionListDemo.positions, id: \.0) { _, position in
                    child(state: state, position: position)
                }
            }
        }

        TransactionListDemoSection(title: "Cor do ícone (sem escolha = Light/Down · default · onColor · highlight)") {
            child(state: .default, position: .first)
            ForEach(Array(TransactionListDemo.iconColors.enumerated()), id: \.offset) { index, item in
                child(state: .default, position: index == 2 ? .last : .middle, iconColor: item.1)
            }
        }

        TransactionListDemoSection(title: "Linha do tempo contínua (First · Middle · Last)") {
            ForEach(0..<3, id: \.self) { index in
                child(state: .default, position: .position(at: index, count: 3))
            }
        }
    }

    @ViewBuilder
    private func child(state: OceanSwiftUI.TransactionListState,
                       position: OceanSwiftUI.TransactionListChildPosition,
                       iconColor: OceanSwiftUI.TransactionListIconColor? = nil) -> some View {
        if hasAction {
            OceanSwiftUI.TransactionListChildAction(parameters: .init(state: state,
                                                                      position: position,
                                                                      icon: Ocean.icon.placeholderSolid,
                                                                      iconColor: iconColor,
                                                                      contentList: TransactionListDemo.content(.sm),
                                                                      amountDetails: TransactionListDemo.amount(.sm),
                                                                      onTouch: { touches += 1 }))
        } else {
            OceanSwiftUI.TransactionListChildReadOnly(parameters: .init(state: state,
                                                                        position: position,
                                                                        icon: Ocean.icon.placeholderSolid,
                                                                        iconColor: iconColor,
                                                                        contentList: TransactionListDemo.content(.sm),
                                                                        amountDetails: TransactionListDemo.amount(.sm)))
        }
    }
}
