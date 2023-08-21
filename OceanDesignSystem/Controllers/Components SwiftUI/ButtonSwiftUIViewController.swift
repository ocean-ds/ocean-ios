//
//  ButtonSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 18/08/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens

import SwiftUI

class ButtonSwiftUIViewController: UIViewController {
    lazy var button: OceanSwiftUI.ButtonPrimary = {
        var view = OceanSwiftUI.ButtonPrimary()
        return view
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16

        stack.add([
            button.getUIView()
        ])

        return stack
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.button.parameters.isLoading = true
            print(self.button.parameters.text)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        setupConstraints()
    }

    private func setupConstraints() {
        mainStack.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}
