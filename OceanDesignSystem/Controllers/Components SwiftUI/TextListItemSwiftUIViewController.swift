//
//  TextListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 15/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TextListItemSwiftUIViewController: UIViewController {
    lazy var textListItem1: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 1"
            textListItem.parameters.description = "Description"
            textListItem.parameters.showSkeleton = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem2: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 2"
            textListItem.parameters.description = "Description"
            textListItem.parameters.caption = "Caption"
            textListItem.parameters.icon = Ocean.icon.chatAlt3Outline
            textListItem.parameters.actionIcon = Ocean.icon.externalLinkSolid
            textListItem.parameters.hasAction = true
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem3: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            textListItem.parameters.caption = "Caption"
            textListItem.parameters.icon = Ocean.icon.personOutline
            textListItem.parameters.hasAction = true
            textListItem.parameters.onTouch = {
                print("Touched!")
            }
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem4: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 4"
            textListItem.parameters.description = "Description"
            textListItem.parameters.info = "Neutral Info"
            textListItem.parameters.state = .neutral
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem5: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 5"
            textListItem.parameters.description = "Description"
            textListItem.parameters.info = "Positive Info"
            textListItem.parameters.state = .positive
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem6: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 6"
            textListItem.parameters.description = "Description"
            textListItem.parameters.hasCheckbox = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem7: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 7"
            textListItem.parameters.description = "Description"
            textListItem.parameters.hasRadioButton = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem8: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 6"
            textListItem.parameters.description = "Description"
            textListItem.parameters.hasCheckbox = true
            textListItem.parameters.hasError = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem9: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 7"
            textListItem.parameters.description = "Description"
            textListItem.parameters.hasRadioButton = true
            textListItem.parameters.hasError = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem10: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            textListItem.parameters.caption = "Caption"
            textListItem.parameters.tagLabel = "Tag"
            textListItem.parameters.tagStatus = .warning
            textListItem.parameters.tagIcon = Ocean.icon.fingerPrintSolid
            textListItem.parameters.tagSize = .medium
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem11: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            textListItem.parameters.caption = "Caption"
            textListItem.parameters.tagLabel = "Tag"
            textListItem.parameters.tagStatus = .warning
            textListItem.parameters.tagIcon = Ocean.icon.fingerPrintSolid
            textListItem.parameters.tagSize = .medium
            textListItem.parameters.tagOrientation = .horizontal
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()
    
    lazy var textListItem12: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            textListItem.parameters.caption = "Caption"
            textListItem.parameters.hasLocked = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem13: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { view in
            view.parameters.title = "Indústria do Conforto e Sono Ltda"
            view.parameters.description = "R$ 5.180,00"
            view.parameters.titleLineLimit = 1
            view.parameters.tagLabel = "Pague em 12x"
            view.parameters.tagStatus = .positive
            view.parameters.tagOrientation = .horizontal
            view.parameters.hasAction = true
        }
    }()

    lazy var textListItem14: OceanSwiftUI.TextListItem = {
        OceanSwiftUI.TextListItem { view in
            view.parameters.title = "BANCO C6 S.A."
            view.parameters.description = "R$ 5.180,00"
            view.parameters.titleLineLimit = 1
            view.parameters.tagLabel = "Pague em 12x"
            view.parameters.tagStatus = .positive
            view.parameters.tagOrientation = .horizontal
            view.parameters.hasAction = true
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {

        VStack(spacing: Ocean.size.spacingStackXs) {
            textListItem13
            textListItem1
            textListItem2
            textListItem3
            textListItem4
            textListItem5
            textListItem6
            textListItem7
            textListItem8
            textListItem9
            textListItem10
            textListItem11
            textListItem12
            textListItem13
            textListItem14
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
struct TextListItemSwiftUIViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            TextListItemSwiftUIViewController()
        }
    }
}
