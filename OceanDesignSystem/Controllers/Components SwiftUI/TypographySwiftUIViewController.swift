//
//  TypographySwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 23/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class TypographySwiftUIViewController: UIViewController {
    lazy var typography1: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading1 { view in
            view.parameters.text = "heading1"
        }
    }()

    lazy var typography2: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading2 { view in
            view.parameters.text = "heading2"
        }
    }()

    lazy var typography3: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading3 { view in
            view.parameters.text = "heading3"
        }
    }()

    lazy var typography4: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading4 { view in
            view.parameters.text = "heading4"
        }
    }()

    lazy var typography5: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.heading5 { view in
            view.parameters.text = "heading5"
        }
    }()

    lazy var typography6: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.subTitle1 { view in
            view.parameters.text = "subTitle1"
        }
    }()

    lazy var typography7: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.subTitle2 { view in
            view.parameters.text = "subTitle2"
        }
    }()

    lazy var typography8: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.paragraph { view in
            view.parameters.text = "paragraph"
        }
    }()

    lazy var typography9: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.lead { view in
            view.parameters.text = "lead"
        }
    }()

    lazy var typography10: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.description { view in
            view.parameters.text = "description"
        }
    }()

    lazy var typography11: OceanSwiftUI.Typography = {
        OceanSwiftUI.Typography.caption { view in
            view.parameters.text = "caption"
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            typography1.uiView,
            typography2.uiView,
            typography3.uiView,
            typography4.uiView,
            typography5.uiView,
            typography6.uiView,
            typography7.uiView,
            typography8.uiView,
            typography9.uiView,
            typography10.uiView,
            typography11.uiView
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
        view.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        mainStack.oceanConstraints
            .topToTop(to: self.view)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }
}
