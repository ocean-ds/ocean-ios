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
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button2: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button3: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.textMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button4: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryCriticalMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button5: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.secondaryCriticalMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button6: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.textCriticalMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button7: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryInverseMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    lazy var button8: OceanSwiftUI.Button = {
        return OceanSwiftUI.Button.primaryMD { button in
            button.parameters.text = "Avançar"
            button.parameters.icon = Ocean.icon.plusSolid
            button.parameters.isDisabled = true
            button.parameters.onTouch = {
                button.parameters.isLoading.toggle()
                print("Tap")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    button.parameters.isLoading.toggle()
                }
            }
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            button1.uiView,
            button2.uiView,
            button3.uiView,
            button4.uiView,
            button5.uiView,
            button6.uiView,
            button7.uiView,
            button8.uiView
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
