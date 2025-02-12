//
//  ExpandableTextListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 11/02/25.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class ExpandableTextListItemSwiftUIViewController: UIViewController {
    lazy var expandableTextListItem1: OceanSwiftUI.ExpandableTextListItem = {
        OceanSwiftUI.ExpandableTextListItem { item in
            item.parameters.title = "Title "
            item.parameters.subtitle = "Description"
            item.parameters.icon = Ocean.icon.chatAlt3Outline
            item.parameters.iconBackgroundColor = Ocean.color.colorInterfaceLightPure
            item.parameters.items = [
                createTextListItemParameters(title: "Title", description: "Caption"),
                createTextListItemParameters(title: "Title", description: "Caption")
            ]
        }
    }()

    lazy var expandableTextListItem2: OceanSwiftUI.ExpandableTextListItem = {
        OceanSwiftUI.ExpandableTextListItem { item in
            item.parameters.title = "Ligar"
            item.parameters.icon = Ocean.icon.deviceMobileOutline
            item.parameters.iconBackgroundColor = Ocean.color.colorInterfaceLightPure
            item.parameters.items = [
                createTextListItemParameters(title: "3003 0807", description: "Capitais e Regiões Metropolitanas", hasAction: true),
                createTextListItemParameters(title: "0800 326 0877", description: "0800 326 0807", hasAction: true),
                createTextListItemParameters(title: "0800 326 0969", description: "Ouvidoria", hasAction: true)
            ]
        }
    }()

    private func createTextListItemParameters(title: String,
                                              description: String,
                                              hasAction: Bool = false) -> OceanSwiftUI.TextListItemParameters {
        let params = OceanSwiftUI.TextListItemParameters()
        params.title = title
        params.description = description
        params.hasAction = hasAction
        params.padding = .init(
            top: 0,
            leading: Ocean.size.spacingStackXs,
            bottom: 0,
            trailing: Ocean.size.spacingStackXs
        )
        return params
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            expandableTextListItem1
            expandableTextListItem2
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct ExpandableTextListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TextListItemSwiftUIViewController()
        }
    }
}
