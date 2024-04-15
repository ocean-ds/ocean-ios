//
//  ParentChildTransactionListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 15/04/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

class ParentChildTransactionListItemSwiftUIViewController: UIViewController {

    public lazy var view1: OceanSwiftUI.ParentChild<OceanSwiftUI.TransactionListItem> = {
        OceanSwiftUI.ParentChild<OceanSwiftUI.TransactionListItem> { view in
            view.parameters.title = "Title"
            view.parameters.subtitle = "Subtitle"
            view.parameters.items = [
                OceanSwiftUI.TransactionListItem { view in
                    view.parameters.level1 = "Item 1 - Title"
                    view.parameters.level2 = "Item 1 - Subtitle"
                    view.parameters.value1 = -1000
                    view.parameters.padding = .all(Ocean.size.spacingInsetXs)
                    view.parameters.hasDivider = false
                },
                OceanSwiftUI.TransactionListItem { view in
                    view.parameters.level1 = "Item 2 - Title"
                    view.parameters.level2 = "Item 2 - Subtitle"
                    view.parameters.value1 = -1000
                    view.parameters.padding = .all(Ocean.size.spacingInsetXs)
                    view.parameters.hasDivider = false
                },
                OceanSwiftUI.TransactionListItem { view in
                    view.parameters.level1 = "Item 3 - Title"
                    view.parameters.level2 = "Item 3 - Subtitle"
                    view.parameters.value1 = -1000
                    view.parameters.padding = .all(Ocean.size.spacingInsetXs)
                    view.parameters.hasDivider = false
                }
            ]
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            Spacer(minLength: 40)
            view1
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

struct ParentChildTransactionListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ParentChildTransactionListItemSwiftUIViewController()
        }
    }
}

