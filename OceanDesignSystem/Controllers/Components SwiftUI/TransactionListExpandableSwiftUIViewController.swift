//
//  TransactionListExpandableSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius  Consulmagnos Romeiro on 02/03/26.
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TransactionListExpandableSwiftUIViewController: UIViewController {
    public lazy var transactionListExpandable1: OceanSwiftUI.TransactionListExpandable = {
        OceanSwiftUI.TransactionListExpandable { view in
            view.parameters.parent = .init(icon: Ocean.icon.placeholderOutline, level1: "Title", level2: "Description", level3: "Caption", value1: 0.0, value3: "Additional data", value1Status: .neutral, value1HasSign: false, tagTitle: "Label", tagStatus: .positive)
            view.parameters.children = [
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Title", level2: "Description", level3: "Caption", value1: 0.0, value3: "Additional data", value1Status: .positive, value1HasSign: false, tagTitle: "Label", tagStatus: .positive, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Title", level2: "Description", level3: "Caption", value1: 0.0, value3: "Additional data", value1Status: .positive, value1HasSign: false, tagTitle: "Label", tagStatus: .positive, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Title", level2: "Description", level3: "Caption", value1: 0.0, value3: "Additional data", value1Status: .positive, value1HasSign: false, tagTitle: "Label", tagStatus: .positive, hasChevron: true)
            ]
            view.parameters.bottomMessage = "Fim dos cancelamentos das retenções"
        }
    }()
    
    public lazy var transactionListExpandable2: OceanSwiftUI.TransactionListExpandable = {
        OceanSwiftUI.TransactionListExpandable { view in
            view.parameters.parent = .init(level2: "Cancelamento de retenções", value1: 1850.00, value1Status: .positive, value1HasSign: false)
            view.parameters.children = [
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 150.00, value1Status: .positive, value1HasSign: false, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 200.00, value1Status: .positive, value1HasSign: false, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 1500.00, value1Status: .positive, value1HasSign: false, hasChevron: true)
            ]
            view.parameters.bottomMessage = "Fim dos cancelamentos das retenções"
        }
    }()
    
    public lazy var transactionListExpandable3: OceanSwiftUI.TransactionListExpandable = {
        OceanSwiftUI.TransactionListExpandable { view in
            view.parameters.parent = .init(level2: "Retenções", value1: -1850.00, value1Status: .neutral)
            view.parameters.children = [
                .init(icon: Ocean.icon.lockClosedSolid, level1: "Retenção de saldo", level2: "Boleto de Blu Instituição de Pagamentos LTDA", value1: -150.00, value1Status: .neutral, hasChevron: true),
                .init(icon: Ocean.icon.lockClosedSolid, level1: "Retenção de saldo", level2: "Boleto de Blu Instituição de Pagamentos LTDA", value1: -200.00, value1Status: .neutral, hasChevron: true),
                .init(icon: Ocean.icon.lockClosedSolid, level1: "Retenção de saldo", level2: "Boleto de Blu Instituição de Pagamentos LTDA", value1: -1500.00, value1Status: .neutral, hasChevron: true)
            ]
            view.parameters.bottomMessage = "Fim das retenções de saldo"
        }
    }()
    
    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            TransactionListExpandableFamilyDemo()

            TransactionListDemoSection(title: "Legado (parent + children)") {
                EmptyView()
            }
            
            transactionListExpandable1
            
            transactionListExpandable2
            
            transactionListExpandable3
        }
    })
    
    public lazy var uiView = self.hostingController.getUIView()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(uiView)
        
        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

/// CT-4: Figma structure (header + slot) — collapsed, expanded, disabled and loading.
struct TransactionListExpandableFamilyDemo: View {
    var body: some View {
        TransactionListDemoSection(title: "Fechada") {
            expandable(status: .collapsed)
        }

        TransactionListDemoSection(title: "Aberta, com filhos e rodapé") {
            expandable(status: .expanded)
        }

        TransactionListDemoSection(title: "Desabilitada") {
            expandable(state: .disabled, status: .collapsed)
            expandable(state: .disabled, status: .expanded)
        }

        TransactionListDemoSection(title: "Densidade compact (header e filhos)") {
            expandable(status: .expanded, density: .compact)
        }

        TransactionListDemoSection(title: "Carregando") {
            expandable(state: .loading, status: .collapsed)
        }
    }

    private func expandable(state: OceanSwiftUI.TransactionListState = .default,
                            status: OceanSwiftUI.TransactionListExpandableParameters.Status,
                            density: OceanSwiftUI.TransactionListDensity = .default) -> some View {
        let header = OceanSwiftUI.TransactionListParameters(state: state,
                                                            icon: Ocean.icon.placeholderOutline,
                                                            contentList: TransactionListDemo.content(),
                                                            amountDetails: TransactionListDemo.amount(),
                                                            density: density)
        let children = VStack(spacing: 0) {
            ForEach(0..<3, id: \.self) { index in
                OceanSwiftUI.TransactionListChildAction(parameters: .init(state: state == .disabled ? .disabled : .default,
                                                                          position: .position(at: index, count: 3),
                                                                          icon: Ocean.icon.placeholderSolid,
                                                                          contentList: TransactionListDemo.content(.sm),
                                                                          amountDetails: TransactionListDemo.amount(.sm),
                                                                          density: density))
            }
        }

        return OceanSwiftUI.TransactionListExpandable(parameters: .init(bottomMessage: "Additional information",
                                                                        status: status,
                                                                        header: header,
                                                                        slot: AnyView(children)))
    }
}

struct TransactionListExpandableSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TransactionListExpandableSwiftUIViewController()
        }
    }
}
