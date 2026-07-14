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
        view.parameters.primaryButton = .init(text: "Label", style: .primary, onTouch: { print("primaryButton") })
        view.parameters.secondaryButton = .init(text: "Label", style: .secondary, onTouch: { print("secondaryButton") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.skeletonLines = 4
        view.parameters.showSkeleton = true
        view.parameters.interlineSpacing = Ocean.size.spacingStackXxs
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Title",
                  value: "Description"),
            .init(text: "Title",
                  value: "Description"),
            .init(text: "Title",
                  value: "Description",
                  newValue: "Description"),
            .init(text: "Title",
                  value: "Description",
                  isBoldValue: true)
        ]
    }

    private lazy var transactionFooterWithCaption = OceanSwiftUI.TransactionFooter { view in
        view.parameters.primaryButton = .init(text: "Label", style: .primary, onTouch: { print("primaryButton") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.sectionTitle = "Title"
        view.parameters.showBottomDivider = true
        view.parameters.interlineSpacing = Ocean.size.spacingStackXxs
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Title",
                  value: "Description",
                  isBoldValue: true,
                  caption: "Description")
        ]
    }

    private lazy var transactionFooterHighlight = OceanSwiftUI.TransactionFooter { view in
        view.parameters.variant = .highlight
        view.parameters.primaryButton = .init(text: "Label", style: .primary, onTouch: { print("primaryButton") })
        view.parameters.buttonOrientation = .vertical
        view.parameters.sectionTitle = "Title"
        view.parameters.showBottomDivider = true
        view.parameters.interlineSpacing = Ocean.size.spacingStackXxs
        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                        leading: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXs,
                                        trailing: Ocean.size.spacingStackXs)
        view.parameters.items = [
            .init(text: "Title",
                  value: "Description"),
            .init(text: "Title",
                  value: "Description",
                  newValue: "Description"),
            .init(text: "Title",
                  value: "Description",
                  isBoldValue: true)
        ]
    }

    private lazy var hostingController = UIHostingController(rootView: VStack {
        Spacer()
        Divider()
        transactionFooterHighlight
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
