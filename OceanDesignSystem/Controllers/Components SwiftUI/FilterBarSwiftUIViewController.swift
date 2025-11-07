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
    var beginDate: Date? = nil
    var endDate: Date? = nil

    private var filterBar1: OceanSwiftUI.FilterBar {
        OceanSwiftUI.FilterBar { filterBar in
            filterBar.parameters.rootViewController = self
            filterBar.parameters.groups = [
                .init(mode: .multiple, options: [
                    .init(title: "Exibir boletos pelos status",
                          mode: .multiple,
                          chips: [
                            .init(number: 2, title: "Vencidos"),
                            .init(number: 7, title: "A vencer"),
                            .init(number: 2, title: "Agendados")
                          ]),
                    .init(title: "Date Range",
                          beginDate: beginDate,
                          endDate: endDate),
                    .init(title: "Filtro 1",
                          mode: .multiple,
                          chips: [
                            .init(id: "paid1", title: "Pago"),
                            .init(id: "pending1", title: "Pendente"),
                            .init(id: "refused1", title: "Recusado")]),
                    .init(title: "Filtro 2",
                          mode: .multiple,
                          chips: [.init(id: "paid1", title: "Pago")]),
                    .init(title: "Filtro 3",
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
            filterBar.parameters.primaryButtonTitle = "Exibir boletos"
            filterBar.parameters.secondaryButtonTitle = "Limpar filtros"
            filterBar.parameters.onTouch = { [weak self] selectedChips, touchedOption in
                guard let self = self else { return false }

                if touchedOption.title == "Filtro 5" {
                    self.showSnackbar(text: "Touched \(touchedOption.title) with \(selectedChips.map { $0.title }.joined(separator: ", "))")
                    return true
                }

                return false
            }
            filterBar.parameters.onSelectionChange = { [weak self] selectedChips, _ in
                guard let self = self else { return }

                if selectedChips.count > 0 {
                    self.showSnackbar(text: "All selected filters are \(selectedChips.map({ $0.title }).joined(separator: ", "))")
                } else {
                    self.showSnackbar(text: "No items are selected")
                }
            }
            filterBar.parameters.onDateRangeChange = { [weak self] beginDate, endDate, _ in
                guard let self = self else { return }

                self.beginDate = beginDate
                self.endDate = endDate
                
                self.showSnackbar(text: "Dates selected \(beginDate?.shortDateFormat()) a \(endDate?.shortDateFormat())")
            }
        }
    }

    lazy var filterBar2 = OceanSwiftUI.FilterBar { filterBar in
        filterBar.parameters.rootViewController = self
        filterBar.parameters.options = [
            .init(chips: [.init(number: 2, title: "Filtro 1")]),
            .init(chips: [.init(number: 3, title: "Filtro 2")]),
            .init(chips: [.init(number: 4, title: "Filtro 3")])
        ]

        filterBar.parameters.onTouch = { [weak self] _, selectedOption in
            guard let self = self else { return false }

            print(selectedOption)

            return false
        }
    }
    
    lazy var filterBar3 = OceanSwiftUI.FilterBar { filterBar in
        filterBar.parameters.rootViewController = self
        filterBar.parameters.options = [
            .init(chips: [.init(number: 2, title: "Filtro 1")]),
            .init(chips: [.init(number: 3, title: "Filtro 2")]),
            .init(chips: [.init(number: 4, title: "Filtro 3")])
        ]
        
        filterBar.parameters.onSelectionChange = { [weak self] items, _ in
            guard let self = self, let selectedItem = items.first(where: { $0.isSelected }),
                  let id = selectedItem.id else { return }
            
            self.showSnackbar(text: selectedItem.title)
        }

        filterBar.parameters.showSkeleton = true
    }

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            filterBar1
            
            filterBar2

            filterBar3
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

@available(iOS 13.0, *)
struct FilterBarSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            FilterBarSwiftUIViewController()
        }
    }
}
