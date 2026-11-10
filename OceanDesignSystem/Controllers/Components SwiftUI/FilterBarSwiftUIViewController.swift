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
                    .init(title: "Status",
                          mode: .multiple,
                          chips: [
                            .init(number: 200, title: "Vencidos"),
                            .init(number: 7, title: "A vencer"),
                            .init(number: 0, title: "Agendados")
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
            filterBar.parameters.modalTitle = "Exibir boletos pelo status"
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

    // MARK: Segmented Control (MR-999)

    private typealias SegmentedOption = OceanSwiftUI.SegmentedControlOptionModel

    private static let storeNetwork = [SegmentedOption(title: "Loja"), SegmentedOption(title: "Rede")]

    /// Chips de exemplo: "Status" (abre opções) e "Pagos" (liga/desliga).
    private static func chipsGroup() -> OceanSwiftUI.FilterBarGroup {
        .init(options: [
            .init(title: "Status",
                  chips: [
                    .init(id: "overdue", title: "Vencidos"),
                    .init(id: "toExpire", title: "A vencer")
                  ]),
            .init(chips: [.init(id: "paid", title: "Pagos")])
        ])
    }

    /// "Todos os filtros": chip com ícone adjustments e contador, no último grupo.
    private static func allFiltersGroup() -> OceanSwiftUI.FilterBarGroup {
        .init(options: [
            .init(leadingIcon: Ocean.icon.adjustmentsOutline,
                  shouldShowTrailingIcon: false,
                  chip: .init(id: "allFilters", number: 2, title: "Todos os filtros"))
        ])
    }

    private static func manyChipsGroup() -> OceanSwiftUI.FilterBarGroup {
        .init(options: (1...8).map { index in
            .init(chips: [.init(id: "chip\(index)", title: "Filtro \(index)")])
        })
    }

    private func makeFilterBar(groups: [OceanSwiftUI.FilterBarGroup],
                               segmentedOptions: [SegmentedOption]?,
                               showSkeleton: Bool = false) -> OceanSwiftUI.FilterBar {
        OceanSwiftUI.FilterBar { filterBar in
            filterBar.parameters.rootViewController = self
            filterBar.parameters.groups = groups
            filterBar.parameters.showSkeleton = showSkeleton
            filterBar.parameters.onTouch = { [weak self] _, touchedOption in
                guard touchedOption.title == "Todos os filtros" else { return false }
                self?.showSnackbar(text: "Abrir todos os filtros")
                return true
            }
            if let segmentedOptions {
                filterBar.parameters.segmentedControl = .init(options: segmentedOptions,
                                                              onTouch: { [weak self] index in
                                                                  self?.showSnackbar(text: "Segmented: opção \(index)")
                                                              })
            }
        }
    }

    private lazy var withSegmented = makeFilterBar(groups: [Self.chipsGroup(), Self.allFiltersGroup()],
                                                   segmentedOptions: Self.storeNetwork)

    private lazy var withSegmentedNoAllFilters = makeFilterBar(groups: [Self.chipsGroup()],
                                                               segmentedOptions: Self.storeNetwork)

    private lazy var withSegmentedIconAndBadge = makeFilterBar(
        groups: [Self.chipsGroup(), Self.allFiltersGroup()],
        segmentedOptions: [SegmentedOption(title: "Loja", icon: Ocean.icon.shoppingBagOutline, badgeNumber: 2),
                           SegmentedOption(title: "Rede", icon: Ocean.icon.officeBuildingOutline, badgeNumber: 5)])

    private lazy var withSegmentedLongText = makeFilterBar(
        groups: [Self.chipsGroup(), Self.allFiltersGroup()],
        segmentedOptions: [SegmentedOption(title: "Lançamentos futuros detalhados por loja"),
                           SegmentedOption(title: "Rede")])

    private lazy var withSegmentedManyChips = makeFilterBar(groups: [Self.manyChipsGroup(), Self.allFiltersGroup()],
                                                            segmentedOptions: Self.storeNetwork)

    private lazy var withSegmentedSkeleton = makeFilterBar(groups: [Self.chipsGroup()],
                                                           segmentedOptions: Self.storeNetwork,
                                                           showSkeleton: true)

    public lazy var hostingController = UIHostingController(rootView: AnyView(ScrollView {
        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXs) {
            section("segmentedControl: nil (padrão) · grupos com divisor") { filterBar1 }

            section("segmentedControl: nil · options com contador") { filterBar2 }

            section("segmentedControl: nil · showSkeleton: true") { filterBar3 }

            section("segmentedControl: Loja | Rede · com \"Todos os filtros\"") { withSegmented }

            section("segmentedControl: Loja | Rede · sem \"Todos os filtros\"") { withSegmentedNoAllFilters }

            section("segmentedControl: icon + badgeNumber (ignorados: só texto)") { withSegmentedIconAndBadge }

            section("segmentedControl: texto longo (uma linha, corta com …)") { withSegmentedLongText }

            section("segmentedControl: Loja | Rede · muitos chips (corte no divisor)") { withSegmentedManyChips }

            section("segmentedControl: Loja | Rede · showSkeleton: true (não aparece)") { withSegmentedSkeleton }
        }
    }))

    private func section(_ label: String, @ViewBuilder _ content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            OceanSwiftUI.Typography.caption { view in
                view.parameters.text = label
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)

            content()
        }
    }

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
