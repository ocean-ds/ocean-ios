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
    public lazy var transactionListExpandable: OceanSwiftUI.TransactionListExpandable = {
        OceanSwiftUI.TransactionListExpandable { view in
            view.parameters.item = .init(level2: "Cancelamento de retenções", value1: 1850.00, value1Status: .positive, hasDivider: false)
            view.parameters.items = [
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 150.00, value1Status: .positive, hasDivider: false, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 200.00, value1Status: .positive, hasDivider: false, hasChevron: true),
                .init(icon: Ocean.icon.lockOpenSolid, level1: "Cancelamento de retenção", level2: "Boleto de Blu Instituição de Pagamentos LTDA", level3: "Retenção lançada em 14/01/2026", value1: 1500.00, value1Status: .positive, hasDivider: false, hasChevron: true)
            ]
            view.parameters.bottomMessage = "Fim dos cancelamentos das retenções"
        }
    }()
    
    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            Spacer(minLength: 40)
            
            transactionListExpandable
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

struct TransactionListExpandableSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TransactionListExpandableSwiftUIViewController()
        }
    }
}
