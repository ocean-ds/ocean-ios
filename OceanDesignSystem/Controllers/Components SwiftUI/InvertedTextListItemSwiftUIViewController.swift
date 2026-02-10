//
//  InvertedTextListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 25/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class InvertedTextListItemSwiftUIViewController: UIViewController {

    lazy var invertedTextListItem1 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.caption = "caption"
        invertedListItem.parameters.status = .normal
        invertedListItem.parameters.leadingImage = Ocean.icon.BmsOutline
        invertedListItem.parameters.tooltipText = "This is a test"
        invertedListItem.parameters.badge = .init(count: 5, valuePrefix: "", status: .warning, size: .medium, style: .count, showSkeleton: false)
        invertedListItem.parameters.hasAction = true
        invertedListItem.parameters.onTouch = {
            print("Touched!")
        }
    }

    lazy var invertedTextListItem2 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.status = .inactive
    }

    lazy var invertedTextListItem3 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.icon = Ocean.icon.placeholderSolid
        invertedListItem.parameters.status = .positive
    }

    lazy var invertedTextListItem4 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.icon = Ocean.icon.placeholderSolid
        invertedListItem.parameters.status = .warning
    }

    lazy var invertedTextListItem5 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.status = .highlight
    }

    lazy var invertedTextListItem6 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Description"
        invertedListItem.parameters.status = .highlight
        invertedListItem.parameters.tagLabel = "Label"
        invertedListItem.parameters.tagStatus = .positive
    }

    lazy var invertedTextListItem7 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Text"
        invertedListItem.parameters.newSubtitle = "Description"
        invertedListItem.parameters.status = .strikethrough
    }

    lazy var invertedTextListItem8 = OceanSwiftUI.InvertedTextListItem { invertedListItem in
        invertedListItem.parameters.title = "Title"
        invertedListItem.parameters.subtitle = "Text"
        invertedListItem.parameters.showSkeleton = true
    }

    var invertedTextListItem9: OceanSwiftUI.InvertedTextListItem {
        OceanSwiftUI.InvertedTextListItem { invertedListItem in
            invertedListItem.parameters.title = "Title"
            invertedListItem.parameters.subtitle = "Text"
            invertedListItem.parameters.link.text = "link"
            invertedListItem.parameters.link.type = .chevron
            invertedListItem.parameters.link.style = .primary
            invertedListItem.parameters.link.size = .small
            invertedListItem.parameters.link.onTouch = { print("link touched") }
        }
    }
    var invertedTextListItem10: OceanSwiftUI.InvertedTextListItem {
        OceanSwiftUI.InvertedTextListItem { invertedListItem in
            invertedListItem.parameters.title = "Valor do boleto"
            invertedListItem.parameters.subtitle = "R$ 5.200,00"
            invertedListItem.parameters.status = .highlightLead
        }
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            invertedTextListItem10
            invertedTextListItem1
            invertedTextListItem2
            invertedTextListItem3
            invertedTextListItem4
            invertedTextListItem5
            invertedTextListItem6
            invertedTextListItem7
            invertedTextListItem8
            invertedTextListItem9
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
struct InvertedTextListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            InvertedTextListItemSwiftUIViewController()
        }
    }
}
