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
/// The menu options open in the Ocean bottom sheet, with the kebab Active while it is open.
final class TransactionListActionSwiftUIViewController: TransactionListDemoViewController<TransactionListActionDemo> {
    init() {
        let presenter = TransactionListDemoPresenter()
        super.init { TransactionListActionDemo(presenter: presenter) }
        presenter.viewController = self
    }
}

/// Weak link to the screen that presents the bottom sheet.
final class TransactionListDemoPresenter {
    weak var viewController: UIViewController?
}

struct TransactionListActionDemo: View {
    let presenter: TransactionListDemoPresenter
    @State private var touches = 0
    @State private var openMenu: String?

    static let menuOptions = ["Ver detalhes", "Compartilhar comprovante", "Cancelar"]

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

        TransactionListDemoSection(title: "Menu (bottom sheet) · toques: \(touches)") {
            ForEach(TransactionListDemo.states, id: \.0) { title, state in
                menuRow(id: title, state: state)
            }
            menuRow(id: "Active", state: .default, isActive: true)
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

    private func menuRow(id: String, state: OceanSwiftUI.TransactionListState, isActive: Bool = false) -> some View {
        OceanSwiftUI.TransactionListAction(parameters: .init(state: state,
                                                             actionType: .menu,
                                                             isMenuActive: isActive || openMenu == id,
                                                             icon: Ocean.icon.placeholderOutline,
                                                             contentList: TransactionListDemo.content(),
                                                             amountDetails: TransactionListDemo.amount(),
                                                             onTouch: {
                                                                 touches += 1
                                                                 showMenu(for: id)
                                                             }))
    }

    /// The screen's part of the Menu contract: options in the Ocean bottom sheet, kebab Active while open.
    private func showMenu(for id: String) {
        guard let viewController = presenter.viewController else { return }

        openMenu = id
        Ocean.ModalList(viewController)
            .withTitle("Opções")
            .withValues(Self.menuOptions.map { Ocean.CellModel(title: $0) })
            .withDismiss(true) { _ in openMenu = nil }
            .build()
            .show()
    }
}
