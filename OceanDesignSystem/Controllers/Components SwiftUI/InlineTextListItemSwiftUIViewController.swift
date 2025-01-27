//
//  InlineTextListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 27/01/25.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class InlineTextListItemSwiftUIViewController: UIViewController {
    lazy var textListItem2: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 2"
            textListItem.parameters.description = "Description"
            textListItem.parameters.showSkeleton = true
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem3: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            //textListItem.parameters.caption = "Caption"
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

    lazy var textListItem4: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 4"
            textListItem.parameters.description = "Description"
          //  textListItem.parameters.info = "Neutral Info"
            textListItem.parameters.state = .neutral
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem5: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 5"
            textListItem.parameters.description = "Description"
            textListItem.parameters.state = .positive
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem6: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 6"
            textListItem.parameters.description = "Description"
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem7: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 7"
            textListItem.parameters.description = "Description"
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem8: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 6"
            textListItem.parameters.description = "Description"
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem9: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 7"
            textListItem.parameters.description = "Description"
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    lazy var textListItem10: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
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

    lazy var textListItem11: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
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
    
    lazy var textListItem12: OceanSwiftUI.InlineTextListItem = {
        OceanSwiftUI.InlineTextListItem { textListItem in
            textListItem.parameters.title = "Title 3"
            textListItem.parameters.description = "Description"
            textListItem.parameters.padding = .init(top: Ocean.size.spacingStackXxs,
                                                    leading: 0,
                                                    bottom: Ocean.size.spacingStackXxs,
                                                    trailing: 0)
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {

        VStack(spacing: Ocean.size.spacingStackXs) {
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
struct InlineTextListItemSwiftUIViewController_Preview: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            InlineTextListItemSwiftUIViewController()
        }
    }
}
