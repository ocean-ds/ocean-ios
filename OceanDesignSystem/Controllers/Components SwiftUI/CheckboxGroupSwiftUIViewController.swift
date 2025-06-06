//
//  CheckboxGroupSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 06/02/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class CheckboxGroupSwiftUIViewController: UIViewController {
    private lazy var checkboxGroup1: OceanSwiftUI.CheckboxGroup = OceanSwiftUI.CheckboxGroup { view in
        view.parameters.items = [
            .init(id: "labe1", title: "Label 1"),
            .init(id: "labe2", title: "Label 2"),
            .init(id: "labe3", title: "Label 3"),
            .init(id: "labe4", title: "Label 4"),
            .init(id: "labe5", title: "Label 5"),
            .init(id: "label6", title: "[Link](http://www.blu.com.br)"),
            .init(id: "label8", title: "Label 8", isSelected: true, isEnabled: false),
            .init(id: "label9", title: "Label 9", isEnabled: false)
        ]
        view.parameters.orientation = .horizontal
        view.parameters.onTouch = { views in
            views.forEach { print("title: \($0.title) - selected: \($0.isSelected)") }
        }
    }
    private lazy var checkboxGroup2: OceanSwiftUI.CheckboxGroup = OceanSwiftUI.CheckboxGroup { view in
        view.parameters.items = [
            .init(id: "labe1", title: "Label 1"),
            .init(id: "labe2", title: "Label 2")
        ]
        view.parameters.orientation = .horizontal
        view.parameters.onTouch = { views in
            views.forEach { print("title: \($0.title) - selected: \($0.isSelected)") }
        }
    }
    private lazy var checkboxGroup3: OceanSwiftUI.CheckboxGroup = OceanSwiftUI.CheckboxGroup { view in
        view.parameters.items = [
            .init(id: "labe1", title: "Label 1"),
            .init(id: "labe2", title: "Label 2", linkText: "Aceito os termos", linkAction: { print("aceito") }),
            .init(id: "labe3", title: "Label 3"),
            .init(id: "labe4", title: "Label 4"),
            .init(id: "labe5", title: "Label 5")
        ]
        view.parameters.onTouch = { views in
            views.forEach { print("title: \($0.title) - selected: \($0.isSelected)") }
        }
        view.parameters.hasError = true
        view.parameters.errorMessage = "Selecione uma opção"
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            checkboxGroup1
            
            Divider()

            checkboxGroup2

            Divider()

            checkboxGroup3
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
struct CheckboxGroupSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CheckboxGroupSwiftUIViewController()
        }
    }
}

