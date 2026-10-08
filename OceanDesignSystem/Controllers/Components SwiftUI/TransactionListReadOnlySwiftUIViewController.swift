//
//  TransactionListReadOnlySwiftUIViewController.swift
//  OceanDesignSystem
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanComponents
import OceanTokens
import SwiftUI

/// CT-1 (states), CT-6 (independent sizes), CT-7 (struck amounts), CT-8 (disabled) and the content types.
final class TransactionListReadOnlySwiftUIViewController: TransactionListDemoViewController<TransactionListReadOnlyDemo> {
    init() {
        super.init { TransactionListReadOnlyDemo() }
    }
}

struct TransactionListReadOnlyDemo: View {
    var body: some View {
        TransactionListDemoSection(title: "Estados") {
            ForEach(TransactionListDemo.states, id: \.0) { _, state in
                row(state: state)
            }
        }

        TransactionListDemoSection(title: "Cor do ícone (default · onColor · highlight)") {
            ForEach(TransactionListDemo.iconColors, id: \.0) { _, iconColor in
                row(iconColor: iconColor)
            }
        }

        TransactionListDemoSection(title: "Desabilitado força Light/Deep (iconColor .highlight)") {
            row(state: .disabled, iconColor: .highlight)
        }

        TransactionListDemoSection(title: "onColor sobre fundo colorido (Warning/Up · Negative/Up)") {
            VStack(spacing: 0) {
                row(iconColor: .onColor)
                OceanSwiftUI.TransactionListAction(parameters: .init(icon: Ocean.icon.placeholderOutline,
                                                                     iconColor: .onColor,
                                                                     contentList: TransactionListDemo.content(),
                                                                     amountDetails: TransactionListDemo.amount()))
            }
            .background(Color(Ocean.color.colorStatusWarningUp))

            row(iconColor: .onColor)
                .background(Color(Ocean.color.colorStatusNegativeUp))
        }

        ForEach(TransactionListDemo.densities, id: \.0) { title, density in
            TransactionListDemoSection(title: "Densidade \(title.lowercased()) · md · sm · filho · loading") {
                OceanSwiftUI.TransactionListReadOnly(parameters: .init(icon: Ocean.icon.placeholderOutline,
                                                                       contentList: TransactionListDemo.content(),
                                                                       amountDetails: TransactionListDemo.amount(),
                                                                       density: density))
                OceanSwiftUI.TransactionListReadOnly(parameters: .init(icon: Ocean.icon.placeholderOutline,
                                                                       contentList: TransactionListDemo.content(.sm),
                                                                       amountDetails: TransactionListDemo.amount(.sm),
                                                                       density: density))
                OceanSwiftUI.TransactionListChildReadOnly(parameters: .init(icon: Ocean.icon.placeholderSolid,
                                                                            contentList: TransactionListDemo.content(.sm),
                                                                            amountDetails: TransactionListDemo.amount(.sm),
                                                                            density: density))
                OceanSwiftUI.TransactionListReadOnly(parameters: .init(state: .loading, density: density))
            }
        }

        TransactionListDemoSection(title: "Tamanhos (conteúdo × valor)") {
            ForEach(TransactionListDemo.sizes, id: \.0) { _, contentSize, amountSize in
                row(content: TransactionListDemo.content(contentSize),
                    amount: TransactionListDemo.amount(amountSize))
            }
        }

        TransactionListDemoSection(title: "Tipos de valor (md e sm)") {
            ForEach(TransactionListDemo.amountTypes, id: \.0) { _, type in
                row(amount: TransactionListDemo.amount(.md, type: type))
                row(content: TransactionListDemo.content(.sm), amount: TransactionListDemo.amount(.sm, type: type))
            }
        }

        TransactionListDemoSection(title: "Valor riscado — benefício e mudança neutra") {
            row(content: .init(title: "Taxa", description: "Antecipação"),
                amount: .init(amount: "Grátis", strikethroughAmount: "3,99%", type: .strikethrough))
            row(content: .init(title: "Valor", description: "Parcela"),
                amount: .init(amount: "R$ 90,00", strikethroughAmount: "R$ 100,00", type: .strikethroughNeutral))
        }

        TransactionListDemoSection(title: "Tipos de conteúdo (md e sm)") {
            ForEach(TransactionListDemo.contentTypes, id: \.0) { _, type in
                row(content: TransactionListDemo.content(.md, type: type))
                row(content: TransactionListDemo.content(.sm, type: type), amount: TransactionListDemo.amount(.sm))
            }
        }
    }

    private func row(state: OceanSwiftUI.TransactionListState = .default,
                     iconColor: OceanSwiftUI.TransactionListIconColor = .default,
                     content: OceanSwiftUI.ContentListParameters = TransactionListDemo.content(),
                     amount: OceanSwiftUI.AmountDetailsParameters = TransactionListDemo.amount()) -> some View {
        OceanSwiftUI.TransactionListReadOnly(parameters: .init(state: state,
                                                               icon: Ocean.icon.placeholderOutline,
                                                               iconColor: iconColor,
                                                               contentList: content,
                                                               amountDetails: amount))
    }
}
