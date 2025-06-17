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
        view.parameters.interlineSpacing = Ocean.size.spacingStackXxsExtra
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

    private lazy var hostingController = UIHostingController(rootView: VStack {
        Spacer()
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
