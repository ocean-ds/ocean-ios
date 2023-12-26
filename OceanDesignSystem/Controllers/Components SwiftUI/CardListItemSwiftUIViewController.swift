//
//  CardListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 26/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class CardListItemSwiftUIViewController: UIViewController {
    lazy var card1 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.onTouch = { print("card1") }
    }

    lazy var card2 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.onTouch = { print("card2") }
    }

    lazy var card3 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.caption = "Caption"
        builder.parameters.onTouch = { print("card3") }
    }

    lazy var card4 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.onTouch = { print("card4") }
    }

    lazy var card5 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card5") }
    }

    lazy var card6 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card6") }
    }

    lazy var card7 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card7") }
    }

    lazy var card8 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        builder.parameters.leadingIcon = Ocean.icon.archiveOutline
        builder.parameters.trailingIcon = Ocean.icon.chevronRightSolid
        builder.parameters.onTouch = { print("card8") }
        builder.parameters.titleLineLimit = 1
        builder.parameters.subtitleLineLimit = 1
        builder.parameters.captionLineLimit = 1
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            self.card1
            self.card2
            self.card3
            self.card4
            self.card5
            self.card6
            self.card7
            self.card8
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
