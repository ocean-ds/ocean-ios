//
//  InputSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class InputSwiftUIViewController : UIViewController {
    lazy var inputTextField1: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.icon = Ocean.icon.eyeOutline
            input.parameters.onTouchIcon = {
                print("icon tapped")
            }
            input.parameters.onValueChanged = { text in
                print(text)
            }
        }
    }()

    lazy var inputTextField2: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.helperMessage = "Helper message"
            input.parameters.iconHelper = Ocean.icon.infoSolid
            input.parameters.onTouchIconHelper = {
                print("icon tapped")
            }
            input.parameters.onValueChanged = { text in
                print(text)
            }
        }
    }()

    lazy var inputTextField3: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.errorMessage = "Error message"
            input.parameters.onValueChanged = { text in
                print(text)
            }
        }
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let stack = Ocean.StackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            inputTextField1.uiView
//            inputTextField2.uiView,
//            inputTextField3.uiView
        ])

        stack.setMargins(allMargins: Ocean.size.spacingStackXs)

        self.add(view: stack)
    }

    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
