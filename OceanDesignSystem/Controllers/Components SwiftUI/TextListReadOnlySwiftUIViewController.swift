//
//  TextListReadOnlySwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 20/04/26.
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import SwiftUI

class TextListReadOnlySwiftUIViewController: UIViewController {

    lazy var invertedDefault: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.contentList.type = .inverted
            view.parameters.contentList.title = "R$ 2.500,00"
            view.parameters.contentList.description = "Saldo total na Blu"
        }
    }()

    lazy var invertedWithTag: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.contentList.type = .inverted
            view.parameters.contentList.title = "R$ 2.500,00"
            view.parameters.contentList.description = "Saldo total na Blu"
            view.parameters.tag = .init(label: "Novo",
                                        status: .highlightNeutral,
                                        size: .small)
        }
    }()

    lazy var invertedWithIconAndDivider: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.contentList.type = .inverted
            view.parameters.contentList.title = "R$ 2.500,00"
            view.parameters.contentList.description = "Saldo total na Blu"
            view.parameters.showIcon = true
            view.parameters.icon = Ocean.icon.placeholderSolid
            view.parameters.showDivider = true
        }
    }()

    lazy var defaultWithCaption: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.caption = "Caption"
        }
    }()

    lazy var disabled: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.state = .disabled
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.caption = "Caption"
        }
    }()

    lazy var loading: OceanSwiftUI.TextListReadOnly = {
        OceanSwiftUI.TextListReadOnly { view in
            view.parameters.state = .loading
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            invertedDefault
            invertedWithTag
            invertedWithIconAndDivider
            defaultWithCaption
            disabled
            loading
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

@available(iOS 13.0, *)
struct TextListReadOnlySwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TextListReadOnlySwiftUIViewController()
        }
    }
}
