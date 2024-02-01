//
//  RadioButtonGroupSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 01/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class RadioButtonGroupSwiftUIViewController: UIViewController {

    lazy var radioButton = OceanSwiftUI.RadioButtonGroup { view in
        view.parameters.items = ["Label 1", "Label 2", "Label 3", "Label 4 with large text and many words. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "Label 5"]
        view.parameters.onTouch = { index, value in
            print("Index: \(index) - Value: \(value)")
        }
    }

    lazy var radioButtonError = OceanSwiftUI.RadioButtonGroup { view in
        view.parameters.items = ["Label 1", "Label 2", "Label 3"]
        view.parameters.onTouch = { index, value in
            print("Index: \(index) - Value: \(value)")
        }
        view.parameters.errorMessage = "Selecione uma opção"
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            radioButton

            OceanSwiftUI.Divider()

            radioButtonError
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct RadioButtonGroupSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            RadioButtonGroupSwiftUIViewController()
        }
    }
}
