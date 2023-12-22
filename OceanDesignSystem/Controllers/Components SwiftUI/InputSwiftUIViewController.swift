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
    lazy var inputTextField: OceanSwiftUI.InputTextField = {
        OceanSwiftUI.InputTextField { input in
            input.parameters.title = "Title"
            input.parameters.placeholder = "Placeholder"
            input.parameters.onMask = { text in
                let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let mask = "#####-####"
                var result = ""
                var index = cleanPhoneNumber.startIndex
                for ch in mask where index < cleanPhoneNumber.endIndex {
                    if ch == "#" {
                        result.append(cleanPhoneNumber[index])
                        index = cleanPhoneNumber.index(after: index)
                    } else {
                        result.append(ch)
                    }
                }
                return result
            }
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

        stack.addArrangedSubview(inputTextField.uiView)

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
