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
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .normal, size: .small))
        return view
    }()

    lazy var progress2: OceanSwiftUI.CircularProgressIndicator = {
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .normal, size: .medium))
        return view
    }()

    lazy var progress3: OceanSwiftUI.CircularProgressIndicator = {
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .normal, size: .large))
        return view
    }()

    lazy var progress4: OceanSwiftUI.CircularProgressIndicator = {
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .primary, size: .small))
        return view
    }()

    lazy var progress5: OceanSwiftUI.CircularProgressIndicator = {
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .primary, size: .medium))
        return view
    }()

    lazy var progress6: OceanSwiftUI.CircularProgressIndicator = {
        var view = OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .primary, size: .large))
        return view
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            progress1.getUIView(),
            progress2.getUIView(),
            progress3.getUIView(),
            progress4.getUIView(),
            progress5.getUIView(),
            progress6.getUIView()
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
