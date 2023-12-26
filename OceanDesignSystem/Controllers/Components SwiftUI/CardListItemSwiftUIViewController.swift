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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var card1 = OceanSwiftUI.CardListItem { builder in
        builder.parameters.title = "Title"
        builder.parameters.subtitle = "Subtitle"
        builder.parameters.caption = "Caption"
        builder.parameters.onTouch = { print("card1") }
        builder.parameters.showSkeleton = true
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

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXxs

        stack.add([
            card1.uiView,
            card2.uiView,
            card3.uiView,
            card4.uiView,
            card5.uiView,
            card6.uiView,
            card7.uiView,
            card8.uiView
        ])

        stack.setMargins(allMargins: Ocean.size.spacingStackXs)

        return stack
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()

        mainStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }
}

