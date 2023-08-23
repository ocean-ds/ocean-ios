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
    lazy var button1: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .primary
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button2: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .secondary
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button3: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .text
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button4: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .primaryCritical
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button5: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .secondaryCritical
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button6: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .textCritical
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button7: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .primaryInverse
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    lazy var button8: OceanSwiftUI.Button = {
        var view = OceanSwiftUI.Button()
        view.parameters.text = "Avançar"
        view.parameters.icon = Ocean.icon.plusSolid
        view.parameters.style = .primary
        view.parameters.isDisabled = true
        view.parameters.onTouch = {
            view.parameters.isLoading.toggle()
            print("Tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                view.parameters.isLoading.toggle()
            }
        }
        return view
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            button1.getUIView(),
            button2.getUIView(),
            button3.getUIView(),
            button4.getUIView(),
            button5.getUIView(),
            button6.getUIView(),
            button7.getUIView(),
            button8.getUIView()
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
