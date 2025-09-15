//
//  CardReadOnlySwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 15/09/25.
//  Copyright © 2025 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class CardReadOnlySwiftUIViewController: UIViewController {
    lazy var view0: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Parcelamento"
            view.parameters.contentList.description = "R$ 2.991,52"
            view.parameters.contentList.descriptionColor = Ocean.color.colorInterfaceDarkDeep
            view.parameters.contentList.caption = "Crédito restante: R$ 6.008,48"
            view.parameters.contentList.captionColor = Ocean.color.colorBrandPrimaryPure
            view.parameters.contentList.type = .inverted
        }
    }()

    lazy var view1: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.type = .default
        }
    }()

    lazy var view2: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Title Inverted"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.type = .inverted
        }
    }()

    lazy var view3: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.caption = "Caption"
            view.parameters.contentList.type = .default
        }
    }()

    lazy var view4: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.caption = "Caption"
            view.parameters.contentList.errorMessage = "Error message"
            view.parameters.contentList.type = .default
        }
    }()

    lazy var view5: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Title"
            view.parameters.contentList.description = "Description"
            view.parameters.contentList.caption = "Caption"
            view.parameters.contentList.errorMessage = "Error message"
            view.parameters.contentList.type = .default
            view.parameters.contentList.showSkeleton = true
        }
    }()

    lazy var view6: OceanSwiftUI.CardReadOnly = {
        return OceanSwiftUI.CardReadOnly { view in
            view.parameters.contentList.title = "Parcelamento"
            view.parameters.contentList.description = "R$ 2.991,52"
            view.parameters.contentList.descriptionColor = Ocean.color.colorInterfaceDarkDeep
            view.parameters.contentList.caption = "Crédito restante: R$ 6.008,48"
            view.parameters.contentList.captionColor = Ocean.color.colorBrandPrimaryPure
            view.parameters.backgroundColor = Ocean.color.colorStatusPositiveUp
            view.parameters.contentList.type = .inverted
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            view0
            view1
            view2
            view3
            view4
            view5
            view6
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .topToTop(to: self.view, constant: Ocean.size.spacingStackXs)
            .bottomToBottom(to: self.view)
            .leadingToLeading(to: self.view, constant: Ocean.size.spacingStackXs)
            .trailingToTrailing(to: self.view, constant: -Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct CardReadOnlySwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CardReadOnlySwiftUIViewController()
        }
    }
}
