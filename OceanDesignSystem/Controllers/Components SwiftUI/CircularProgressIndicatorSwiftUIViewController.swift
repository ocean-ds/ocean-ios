//
//  CircularProgressIndicatorSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import SwiftUI
import OceanTokens

class CircularProgressIndicatorSwiftUIViewController: UIViewController {
    lazy var progress1: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .small
        }
    }()

    lazy var progress2: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .medium
        }
    }()

    lazy var progress3: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.size = .large
        }
    }()

    lazy var progress4: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .small
        }
    }()

    lazy var progress5: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .medium
        }
    }()

    lazy var progress6: OceanSwiftUI.CircularProgressIndicator = {
        return OceanSwiftUI.CircularProgressIndicator { view in
            view.parameters.style = .primary
            view.parameters.size = .large
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            progress1.uiView,
            progress2.uiView,
            progress3.uiView,
            progress4.uiView,
            progress5.uiView,
            progress6.uiView
        ])

        stack.setMargins(horizontal: Ocean.size.spacingStackXs)

        return stack
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Ocean.color.colorInterfaceDarkUp
        view.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        mainStack.oceanConstraints
            .center(to: view)
            .make()
    }
}
