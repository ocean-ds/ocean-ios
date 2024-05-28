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

    private lazy var TransactionFooter = OceanSwiftUI.TransactionFooter { view in
        view.parameters.items = [.init(text: "Valor cobrado", value: .init(value: "R$ 10,00"))]
    }

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            TransactionFooter
        }
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
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
