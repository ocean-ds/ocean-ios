//
//  FilterBarSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 09/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class FilterBarSwiftUIViewController: UIViewController {

    lazy var filterBar = OceanSwiftUI.FilterBar { filterBar in
        filterBar.parameters.rootViewController = self
        filterBar.parameters.groups = [
            .init(mode: .multiple, options: [
                .init(title: "Filtro 1",
                      mode: .multiple,
                      chips: [
                        .init(id: "paid1", title: "Pago"),
                        .init(id: "pending1", title: "Pendente"),
                        .init(id: "refused1", title: "Recusado")]),
                .init(title: "Filtro 2",
                      mode: .single,
                      chips: [
                        .init(id: "paid2", title: "Pago"),
                        .init(id: "pending2", title: "Pendente"),
                        .init(id: "refused2", title: "Recusado"),
                      ])
            ]),
            .init(options: [
                .init(leadingIcon: Ocean.icon.adjustmentsOutline,
                      title: "Filtro 3",
                      chips: [.init(id: "filter3", title: "Filtro 3")]),
                .init(title: "Filtro 4",
                      chips: [.init(id: "filter4", title: "Filtro 4")]),
                .init(title: "Filtro 5",
                      chips: [.init(id: "filter5", title: "Filtro 5")])
            ])
        ]
        filterBar.parameters.onTouch = { [weak self] selectedChips, touchedOption in
            guard let self = self else { return false }

            if touchedOption.title == "Filtro 5" {
                self.showSnackbar(text: "Touched \(touchedOption.title) with \(selectedChips.map { $0.title }.joined(separator: ", "))")
                return true
            }

            return false
        }
        filterBar.parameters.onSelectionChange = { [weak self] selectedChips in
            guard let self = self else { return }

            if selectedChips.count > 0 {
                self.showSnackbar(text: "All selected filters are \(selectedChips.map({ $0.title }).joined(separator: ", "))")
            } else {
                self.showSnackbar(text: "No items are selected")
            }
        }
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            filterBar
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }

    private func showSnackbar(text: String) {
        let snackbar = Ocean.View.snackbarInfo { view in
            view.line = .one
            view.snackbarText = text
        }
        snackbar.show(in: self.view)
    }
}

