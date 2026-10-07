//
//  TransactionListActionSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanComponents
import OceanTokens
import SwiftUI

/// CT-2: chevron and menu, pressed highlight, one callback per touch and no callback when disabled.
final class TransactionListActionSwiftUIViewController: TransactionListDemoViewController<TransactionListActionDemo> {
    init() {
        super.init { TransactionListActionDemo() }
    }
}

struct TransactionListActionDemo: View {
    @State private var touches = 0

    var body: some View {
        TransactionListDemoSection(title: "Toques recebidos: \(touches)") {
            ForEach(TransactionListDemo.states, id: \.0) { _, state in
                OceanSwiftUI.TransactionListAction(parameters: .init(state: state,
                                                                     icon: Ocean.icon.placeholderOutline,
                                                                     contentList: TransactionListDemo.content(),
                                                                     amountDetails: TransactionListDemo.amount(),
                                                                     onTouch: { touches += 1 }))
            }
        }

        TransactionListDemoSection(title: "Menu · toques: \(touches)") {
            ForEach(TransactionListDemo.states, id: \.0) { _, state in
                menuRow(state: state)
            }
            menuRow(state: .default, isActive: true)
        }

        TransactionListDemoSection(title: "Tamanhos (conteúdo × valor)") {
            ForEach(TransactionListDemo.sizes, id: \.0) { _, contentSize, amountSize in
                OceanSwiftUI.TransactionListAction(parameters: .init(icon: Ocean.icon.placeholderOutline,
                                                                     contentList: TransactionListDemo.content(contentSize),
                                                                     amountDetails: TransactionListDemo.amount(amountSize),
                                                                     onTouch: { touches += 1 }))
            }
        }
    }

    private func menuRow(state: OceanSwiftUI.TransactionListState, isActive: Bool = false) -> some View {
        OceanSwiftUI.TransactionListAction(parameters: .init(state: state,
                                                             actionType: .menu,
                                                             isMenuActive: isActive,
                                                             icon: Ocean.icon.placeholderOutline,
                                                             contentList: TransactionListDemo.content(),
                                                             amountDetails: TransactionListDemo.amount(),
                                                             onTouch: { touches += 1 }))
    }
}
