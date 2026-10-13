//
//  TransactionFooterSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 28/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens

class TransactionFooterSwiftUIViewController: UIViewController {

    private lazy var transactionFooterWithButtonsVertical = OceanSwiftUI.TransactionFooter { view in
        view.parameters.primaryButton = .init(text: "Avançar", style: .primary, onTouch: { print("primaryButton") })
        view.parameters.secondaryButton = .init(text: "Cancelar",  style: .secondary, onTouch: { print("secondaryButton") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.skeletonLines = 4
        view.parameters.showSkeleton = true
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Desconto à vista",
                  value: "R$ 100.000,00",
                  valueColor: Ocean.color.colorStatusPositiveDeep,
                  imageIcon: Ocean.icon.tagSolid),
            .init(text: "Valor cobrado", 
                  value: "R$ 100.000,00"),
            .init(text: "Custo de antecipação", 
                  value: "R$ 10,00",
                  newValue: "Zero"),
            .init(text: "Pague", 
                  value: "R$ 10,00",
                  isBoldValue: true)
        ]
    }

    private lazy var transactionFooterWithCaption = OceanSwiftUI.TransactionFooter { view in
        view.parameters.primaryButton = .init(text: "Agendar", style: .primary, onTouch: { print("Agendar") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Total a pagar",
                  value: "R$ 5.000,00",
                  isBoldValue: true,
                  caption: "Se não houver saldo atual, pode ser cobrada taxa de antecipação.")
        ]
    }

    private lazy var hostingController = UIHostingController(rootView: VStack {
        Spacer()
        Divider()
        transactionFooterWithCaption
        Divider()
        transactionFooterWithButtonsVertical
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.transactionFooterWithButtonsVertical.parameters.showSkeleton = false
        }
    }
}

@available(iOS 13.0, *)
struct TransactionFooterSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TransactionFooterSwiftUIViewController()
        }
    }
}

struct TransactionFooter2DemoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TransactionListDemoSection(title: "Default") {
                footer(
                    mainItem: row("Pedido", "R$ 623,80"),
                    details: [row("Pague em", "3x de R$ 207,93 sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Highlight") {
                footer(
                    type: .highlight,
                    mainItem: row("Pedido", "R$ 623,80"),
                    details: [row("Pague em", "3x de R$ 207,93 sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Highlight with notice") {
                footer(
                    type: .highlight,
                    notice: .init(description: "Seu pagamento será processado após a confirmação."),
                    mainItem: row("Pedido", "R$ 623,80"),
                    details: [row("Pague em", "3x de R$ 207,93 sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Notice with title and icon") {
                footer(
                    notice: .init(
                        icon: Image(uiImage: Ocean.icon.checkCircleSolid!),
                        title: "Economia de R$ 96,39",
                        description: "A economia será aplicada ao pagamento."
                    ),
                    mainItem: row("Pedido", "R$ 623,80"),
                    details: [row("Pague em", "3x de R$ 207,93 sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Main item only") {
                footer(mainItem: row("Pedido", "R$ 623,80"))
            }

            TransactionListDemoSection(title: "Details only") {
                footer(details: [row("Pague em", "3x de R$ 207,93 sem acréscimo")])
            }

            TransactionListDemoSection(title: "Four details") {
                footer(details: [
                    row("Pague em", "3x de R$ 207,93 sem acréscimo"),
                    row("Custo de antecipação", "R$ 96,39"),
                    row("Vencimento", "10 de outubro"),
                    row("Forma de pagamento", "Cartão de crédito")
                ])
            }
        }
    }

    private func footer(type: OceanSwiftUI.TransactionFooterType = .default,
                        notice: OceanSwiftUI.TransactionFooterNotice? = nil,
                        mainItem: OceanSwiftUI.TransactionFooterRow? = nil,
                        details: [OceanSwiftUI.TransactionFooterRow] = []) -> some View {
        OceanSwiftUI.TransactionFooter(parameters: .init(
            style: .v2(
                .init(
                    type: type,
                    notice: notice,
                    mainItem: mainItem,
                    details: details,
                    total: .init(label: "Total", value: "R$ 90,00"),
                    button: .init(text: "Continuar", style: .primary, onTouch: {})
                )
            )
        ))
    }

    private func row(_ label: String, _ value: String) -> OceanSwiftUI.TransactionFooterRow {
        .init(label: label, value: value)
    }
}
