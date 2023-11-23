//
//  StatusListItemViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 23/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class StatusListItemViewController: UIViewController {

    lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    lazy var scrollableContentView: UIView = { UIView(frame: .zero) }()

    lazy var statusListItem1: Ocean.StatusListItem = {
        let item = Ocean.StatusListItem()
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.caption = "Caption"
        item.tagTitle = "Label"
        item.tagStatus = .warning
        item.iconTrailing = Ocean.icon.chevronRightSolid
        item.onTouchButton = { self.onClick() }

        return item
    }()

    lazy var statusListItem2: Ocean.StatusListItem = {
        let item = Ocean.StatusListItem()
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.tagTitle = "Label"
        item.tagStatus = .warning
        item.iconTrailing = Ocean.icon.chevronRightSolid
        item.onTouchButton = { self.onClick() }

        return item
    }()

    lazy var statusListItem3: Ocean.StatusListItem = {
        let item = Ocean.StatusListItem()
        item.title = "Title"
        item.iconTrailing = Ocean.icon.chevronRightSolid
        item.onTouchButton = { self.onClick() }

        return item
    }()

    lazy var statusListItem4: Ocean.StatusListItem = {
        let item = Ocean.StatusListItem()
        item.title = "Title"
        item.onTouchButton = { self.onClick() }

        return item
    }()

    lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs

        stack.add([
            statusListItem1,
            statusListItem2,
            statusListItem3,
            statusListItem4
        ])

        return stack
    }()

    public override func viewDidLoad() {
        self.addScrollView()
        self.view.backgroundColor = .white

        scrollableContentView.addSubview(mainStack)
        mainStack.oceanConstraints
            .fill(to: scrollableContentView)
            .make()
    }

    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollableContentView)

        applyScrollViewDefaultContraints()
    }

    private func applyScrollViewDefaultContraints() {
        scrollView.oceanConstraints
            .fill(to: view)
            .make()

        scrollableContentView.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }

    private func onClick() -> Void {
        print("click!")
    }
}
