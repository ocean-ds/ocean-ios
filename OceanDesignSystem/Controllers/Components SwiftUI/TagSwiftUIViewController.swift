//
//  TagSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 24/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TagSwiftUIViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var tag1: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.positiveMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag2: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.warningMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag3: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.negativeMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag4: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.complementaryMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag5: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.neutralInterfaceMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag6: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.neutralPrimaryMD { tag in
            tag.parameters.label = "Label"
            tag.parameters.icon = Ocean.icon.placeholderSolid
        }
    }()

    lazy var tag7: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.importantMD { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag8: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.neutralMD { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag9: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.positiveSM { tag in
            tag.parameters.label = "Label"
        }
    }()

    lazy var tag10: OceanSwiftUI.Tag = {
        return OceanSwiftUI.Tag.negativeSM { tag in
            tag.parameters.label = "Label"
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            tag1.uiView,
            tag2.uiView,
            tag3.uiView,
            tag4.uiView,
            tag5.uiView,
            tag6.uiView,
            tag7.uiView,
            tag8.uiView,
            tag9.uiView,
            tag10.uiView
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
