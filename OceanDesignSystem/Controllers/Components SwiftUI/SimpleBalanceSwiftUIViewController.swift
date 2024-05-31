//
//  SimpleBalanceSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 27/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens

class SimpleBalanceSwiftUIViewController: UIViewController {

    private lazy var balance = OceanSwiftUI.SimpleBalance { view in
        view.parameters.balanceAvailable = -1000.00
        view.parameters.currentBalance = 10.00
        view.parameters.scheduleBlu = -90.00
    }

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            balance
        }
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct SimpleBalanceSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SimpleBalanceSwiftUIViewController()
        }
    }
}
