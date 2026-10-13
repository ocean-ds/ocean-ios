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
            .init(text: "Subtotal",
                  value: "R$ 1.250,00",
                  valueColor: Ocean.color.colorStatusPositiveDeep,
                  imageIcon: Ocean.icon.tagSolid),
            .init(text: "Parcelamento",
                  value: "5x de R$ 250,00"),
            .init(text: "Taxa de serviço",
                  value: "R$ 12,50"),
            .init(text: "Data de entrega",
                  value: "15 de março"),
            .init(text: "Forma de pagamento",
                  value: "Cartão de crédito"),
            .init(text: "Total",
                  value: "R$ 1.250,00",
                  isBoldValue: true)
        ]
    }

    private lazy var transactionFooterWithCaption = OceanSwiftUI.TransactionFooter { view in
        view.parameters.primaryButton = .init(text: "Continuar", style: .primary, onTouch: { print("Continuar") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Total",
                  value: "R$ 1.250,00",
                  isBoldValue: true,
                  caption: "Texto de apoio do aviso.")
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
                    mainItem: row("Subtotal", "R$ 1.250,00"),
                    details: [row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Highlight") {
                footer(
                    type: .highlight,
                    mainItem: row("Subtotal", "R$ 1.250,00"),
                    details: [row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Highlight with notice") {
                footer(
                    type: .highlight,
                    notice: .init(description: "Texto de apoio do aviso."),
                    mainItem: row("Subtotal", "R$ 1.250,00"),
                    details: [row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Notice with title and icon") {
                footer(
                    notice: .init(
                        icon: Image(uiImage: Ocean.icon.checkCircleSolid!),
                        title: "Desconto aplicado",
                        description: "Texto de apoio do aviso."
                    ),
                    mainItem: row("Subtotal", "R$ 1.250,00"),
                    details: [row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")]
                )
            }

            TransactionListDemoSection(title: "Main item only") {
                footer(mainItem: row("Subtotal", "R$ 1.250,00"))
            }

            TransactionListDemoSection(title: "Details only") {
                footer(details: [row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")])
            }

            TransactionListDemoSection(title: "Four details") {
                footer(details: [
                    row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo"),
                    row("Taxa de serviço", "R$ 12,50"),
                    row("Data de entrega", "15 de março"),
                    row("Forma de pagamento", "Cartão de crédito")
                ])
            }

            TransactionListDemoSection(title: "Additional info") {
                footer(mainItem: row("Subtotal", "R$ 1.250,00", info: "sem acréscimo"))
            }
        }
    }

    fileprivate func footer(type: OceanSwiftUI.TransactionFooterType = .default,
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
                    total: .init(label: "Total", value: "R$ 1.250,00"),
                    button: .init(text: "Continuar", style: .primary, onTouch: {})
                )
            )
        ))
    }

    fileprivate func row(
        _ label: String,
        _ value: String,
        info: String? = nil
    ) -> OceanSwiftUI.TransactionFooterRow {
        .init(label: label, value: value, info: info)
    }
}

struct TransactionFooter2FixedDemoView: View {
    var body: some View {
        let demo = TransactionFooter2DemoView()

        return VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    TransactionListDemoSection(title: "Resumo do pedido") {
                        Text("Confira os itens e os detalhes antes de continuar.")
                            .padding(.horizontal, Ocean.size.spacingStackXs)
                            .padding(.bottom, Ocean.size.spacingStackSm)
                    }
                    TransactionListDemoSection(title: "Itens") {
                        Text("Produto fictício")
                            .padding(.horizontal, Ocean.size.spacingStackXs)
                            .padding(.bottom, Ocean.size.spacingStackSm)
                    }
                }
            }
            demo.footer(
                mainItem: demo.row("Subtotal", "R$ 1.250,00"),
                details: [demo.row("Parcelamento", "5x de R$ 250,00", info: "sem acréscimo")]
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
