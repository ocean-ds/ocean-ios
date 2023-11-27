//
//  StatusListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 24/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class StatusListItemSwiftUIViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var statusListItem1: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem2: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem3: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .contextMenu
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem4: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .contextMenu
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem5: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .readOnly
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .below
        }
    }()

    lazy var statusListItem6: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .readOnly
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem7: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.style = .normal
            statusListItem.parameters.tagLabel = "Label"
            statusListItem.parameters.tagStatus = .warning
            statusListItem.parameters.tagPosition = .right
        }
    }()

    lazy var statusListItem8: OceanSwiftUI.StatusListItem = {
        return OceanSwiftUI.StatusListItem { statusListItem in
            statusListItem.parameters.title = "Title"
            statusListItem.parameters.description = "Description"
            statusListItem.parameters.caption = "Caption"
            statusListItem.parameters.style = .normal
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0

        stack.add([
            statusListItem1.uiView,
            statusListItem2.uiView,
            statusListItem3.uiView,
            statusListItem4.uiView,
            statusListItem5.uiView,
            statusListItem6.uiView,
            statusListItem7.uiView,
            statusListItem8.uiView
        ])
        
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
