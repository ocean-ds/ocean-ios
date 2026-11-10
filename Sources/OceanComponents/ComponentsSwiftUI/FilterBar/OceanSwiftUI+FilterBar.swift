//
//  OceanSwiftUI+FilterBar.swift
//  Blu
//
//  Created by Renan Massaroto on 08/01/24.
//  Copyright © 2024 Blu. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class FilterBarParameters: ObservableObject {

        @Published public var groups: [FilterBarGroup]
        @Published public var marginLeft: CGFloat = Ocean.size.spacingStackXs
        @Published public var marginRight: CGFloat = Ocean.size.spacingStackXs
        @Published public var showSkeleton: Bool
        @Published public var onTouch: (([Ocean.ChipModel], FilterBarOption) -> Bool)
        @Published public var onSelectionChange: (([Ocean.ChipModel], [FilterBarGroup]) -> Void)
        @Published public var onDateRangeChange: ((Date?, Date?, [FilterBarGroup]) -> Void)
        @Published public var modalTitle: String? = nil
        @Published public var primaryButtonTitle: String = "Filtrar"
        @Published public var secondaryButtonTitle: String = "Limpar"
        /// Segmented Control opcional, fixo à direita da barra, fora da rolagem (Figma: Filter Bar 1.1.0,
        /// propriedade *Segmented control*; MR-999). `nil` (default) não mostra o controle: chips e grupos rolam
        /// juntos, com divisor entre os grupos. Com o controle:
        /// - os chips (todos os grupos) rolam numa área que ocupa o espaço livre e é cortada colada no divisor;
        /// - não há divisor entre grupos, e o espaço entre eles é `spacingInlineXxs` (8);
        /// - a área rolável termina com um respiro de `spacingInlineXs` (16), visto ao rolar até o fim;
        /// - fixo à direita: divisor · `spacingInlineXxs` (8) · Segmented Control · `marginRight` (16).
        ///
        /// O controle aparece **só com texto**: o ícone (`icon`) e o contador (`badgeNumber`) das opções são
        /// ignorados no Filter Bar. Seleção, `isDisabled`, `background` e `onTouch` continuam valendo no objeto
        /// passado aqui (é ele que guarda a opção selecionada). Com `showSkeleton` o controle não aparece.
        /// A rolagem dos chips não mostra a barra de rolagem (com ou sem o controle).
        /// Texto longo: o controle nunca sai da barra nem esconde os chips. Ele fica com a largura natural enquanto
        /// ela couber em cerca de metade da barra; acima disso o texto da opção é cortado com "…" numa linha só,
        /// como no Segmented Control.
        @Published public var segmentedControl: SegmentedControlParameters? = nil

        weak public var rootViewController: UIViewController?

        public var options: [OceanSwiftUI.FilterBarOption] {
            get {
                groups.flatMap { $0.options }
            }
            set {
                groups = [.init(options: newValue)]
            }
        }

        public init(groups: [FilterBarGroup] = [],
                    showSkeleton: Bool = false,
                    onTouch: @escaping ([Ocean.ChipModel], FilterBarOption) -> Bool = { _, _ in return false },
                    onSelectionChange: @escaping ([Ocean.ChipModel], [FilterBarGroup]) -> Void = { _, _  in },
                    onDateRangeChange: @escaping ((Date?, Date?, [FilterBarGroup]) -> Void) = { _, _, _ in },
                    modalTitle: String? = nil,
                    primaryButtonTitle: String = "Filtrar",
                    secondaryButtonTitle: String = "Limpar",
                    segmentedControl: SegmentedControlParameters? = nil) {
            self.groups = groups
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
            self.onSelectionChange = onSelectionChange
            self.onDateRangeChange = onDateRangeChange
            self.modalTitle = modalTitle
            self.primaryButtonTitle = primaryButtonTitle
            self.secondaryButtonTitle = secondaryButtonTitle
            self.segmentedControl = segmentedControl
        }

        /// O Segmented Control aparece: foi passado e a barra não está carregando.
        var showsSegmentedControl: Bool {
            segmentedControl != nil && !showSkeleton
        }

        /// Divisor entre grupos: só sem o Segmented Control; com ele, o único divisor é o da direita.
        var showsGroupDividers: Bool {
            !showsSegmentedControl
        }
    }

    /// Medidas do Filter Bar com o Segmented Control (Figma: Filter Bar 1.1.0, mobile; MR-999).
    enum FilterBarMetrics {
        /// A rolagem dos chips não mostra o indicador (barra de rolagem), com ou sem Segmented Control.
        /// Decisão de design (MR-999). `showsIndicators:` e não `.scrollIndicators(.hidden)`, que é iOS 16+
        /// (o pacote suporta iOS 15).
        static let showsScrollIndicators = false
        /// Espaço entre chips e entre grupos (Figma: 8).
        static let itemSpacing: CGFloat = Ocean.size.spacingInlineXxs
        /// Respiro no fim do conteúdo rolável, à direita (Figma: 16).
        static let scrollEndPadding: CGFloat = Ocean.size.spacingInlineXs
        /// Espaço entre o divisor e o Segmented Control (Figma: 8).
        static let dividerToSegmentedSpacing: CGFloat = Ocean.size.spacingInlineXxs
        /// Divisor: 1 de largura (`borderWidthHairline`), 32 de altura (64 da barra menos 16 em cima e embaixo).
        static let dividerWidth: CGFloat = Ocean.size.borderWidthHairline
        static let dividerVerticalPadding: CGFloat = Ocean.size.spacingStackXs

        /// Opções repassadas ao Segmented Control dentro do Filter Bar: só o texto (sem ícone e sem contador).
        static func textOnly(_ options: [SegmentedControlOptionModel]) -> [SegmentedControlOptionModel] {
            options.map { SegmentedControlOptionModel(title: $0.title) }
        }

        /// Parâmetros que o Filter Bar desenha a partir dos da tela: opções só com texto, mesma seleção,
        /// desabilitado e fundo. O toque seleciona no objeto da tela (que chama o `onTouch` dela).
        static func textOnlyParameters(from source: SegmentedControlParameters) -> SegmentedControlParameters {
            SegmentedControlParameters(options: textOnly(source.options),
                                       selectedIndex: source.selectedIndex,
                                       isDisabled: source.isDisabled,
                                       background: source.background,
                                       onTouch: { [weak source] index in source?.select(index: index) })
        }
    }

    /// Segmented Control do Filter Bar: observa o objeto da tela (seleção trocada por ela redesenha) e desenha
    /// a versão só com texto.
    struct FilterBarSegmentedControl: View {
        @ObservedObject var parameters: SegmentedControlParameters

        var body: some View {
            SegmentedControl(parameters: FilterBarMetrics.textOnlyParameters(from: parameters))
        }
    }

    private struct Constants {
        static let barHeight: CGFloat = 64
        static let itemHeight: CGFloat = 32
        static let iconSize: CGFloat = 16
    }

    public struct FilterBar: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (FilterBar) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: FilterBarParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: FilterBarParameters = FilterBarParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if parameters.showsSegmentedControl, let segmentedControl = parameters.segmentedControl {
                barWithSegmentedControl(segmentedControl)
            } else {
                bar
            }
        }

        /// Barra sem Segmented Control: chips e "Todos os filtros" rolam juntos, sem indicador de rolagem.
        private var bar: some View {
            ScrollView(.horizontal, showsIndicators: FilterBarMetrics.showsScrollIndicators) {
                HStack(spacing: 0) {
                    Spacer(minLength: parameters.marginLeft)

                    HStack(spacing: Ocean.size.spacingStackXxs) {
                        if parameters.showSkeleton {
                            ForEach(0..<3, id: \.self) { _ in
                                Rectangle()
                                    .frame(width: 72, height: Constants.itemHeight)
                                    .oceanSkeleton(isActive: true,
                                                   size: CGSize(width: 72, height: Constants.itemHeight))
                            }
                        } else {
                            groupsView
                        }
                    }
                    .frame(height: Constants.barHeight)

                    Spacer(minLength: parameters.marginRight)
                }
            }
        }

        /// Barra com Segmented Control: chips rolando no espaço livre, cortados colados no divisor;
        /// divisor · 8 · Segmented Control · `marginRight` fixos à direita.
        private func barWithSegmentedControl(_ segmentedControl: SegmentedControlParameters) -> some View {
            HStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: FilterBarMetrics.showsScrollIndicators) {
                    HStack(spacing: 0) {
                        Spacer(minLength: parameters.marginLeft)

                        HStack(spacing: FilterBarMetrics.itemSpacing) {
                            groupsView
                        }
                        .frame(height: Constants.barHeight)

                        Spacer(minLength: FilterBarMetrics.scrollEndPadding)
                    }
                }

                Divider { divider in
                    divider.parameters.axis = .vertical
                    divider.parameters.size = FilterBarMetrics.dividerWidth
                }
                .padding([.vertical], FilterBarMetrics.dividerVerticalPadding)

                FilterBarSegmentedControl(parameters: segmentedControl)
                    .padding(.leading, FilterBarMetrics.dividerToSegmentedSpacing)
                    .padding(.trailing, parameters.marginRight)
                    // Sem prioridade de layout: o controle fica com a largura natural enquanto ela couber em cerca
                    // de metade da barra (a área rolável é mais flexível e fica com o resto). Texto mais longo que
                    // isso é cortado com "…" e os chips continuam visíveis.
            }
            .frame(height: Constants.barHeight)
        }

        /// Grupos de chips. Entre grupos: divisor sem Segmented Control; só o espaçamento com ele.
        @ViewBuilder
        private var groupsView: some View {
            ForEach(parameters.groups, id: \.id) { group in
                HStack(spacing: Ocean.size.spacingStackXxs) {
                    ForEach(group.options, id: \.title) { option in
                        itemView(option: option, group: group)
                    }
                }

                if parameters.showsGroupDividers, parameters.groups.last?.id != group.id {
                    Divider { divider in
                        divider.parameters.axis = .vertical
                    }
                    .padding([.vertical], Ocean.size.spacingStackXs)
                }
            }
        }

        private func itemView(option: FilterBarOption, group: FilterBarGroup) -> some View {
            HStack {
                Spacer(minLength: Ocean.size.spacingStackXs)

                if let icon = option.leadingIcon {
                    imageView(icon: icon, option: option)
                    Spacer(minLength: Ocean.size.spacingStackXxxs)
                }

                Typography.description { label in
                    label.parameters.text = option.label
                    label.parameters.textColor = option.isSelected
                    ? Ocean.color.colorInterfaceLightPure
                    : Ocean.color.colorBrandPrimaryPure
                }
                .frame(height: Constants.itemHeight)
                .fixedSize(horizontal: true, vertical: false)
                .padding([.vertical], Ocean.size.spacingStackXxs)

                if option.chips.count == 1 {
                    let totalFilters = countView(chips: option.chips)
                    if totalFilters > 0 {
                        badge(count: totalFilters, isSelected: option.isSelected)
                    }
                }

                if option.mode == .multiple && option.chips.contains(where: { $0.isSelected }) {
                    badge(count: option.chips.filter { $0.isSelected }.count, isSelected: true)
                }

                if let icon = option.trailingIcon {
                    imageView(icon: icon, option: option)
                        .padding(.trailing, Ocean.size.spacingStackXxs)
                } else if !option.shouldShowTrailingIcon {
                    Spacer(minLength: Ocean.size.spacingStackXs)
                } else if option.chips.count > 1 || option.mode == .dateRange {
                    imageView(icon: Ocean.icon.chevronDownSolid!, option: option)
                        .padding(.trailing, Ocean.size.spacingStackXxs)
                } else {
                    Spacer(minLength: Ocean.size.spacingStackXs)
                }
            }
            .frame(height: Constants.itemHeight)
            .background(Color(
                option.isSelected
                ? Ocean.color.colorBrandPrimaryPure
                : Ocean.color.colorInterfaceLightUp
            ))
            .cornerRadius(Ocean.size.borderRadiusLg)
            .onTapGesture {
                onTouch(option: option, group: group)
            }

        }

        private func imageView(icon: UIImage, option: FilterBarOption) -> some View {
            Image(uiImage: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: Constants.iconSize, height: Constants.iconSize, alignment: .center)
                .foregroundColor(Color(
                    option.isSelected
                    ? Ocean.color.colorInterfaceLightPure
                    : Ocean.color.colorBrandPrimaryPure
                ))
        }

        private func badge(count: Int, isSelected: Bool) -> some View {
            Badge { badge in
                badge.parameters.count = count
                badge.parameters.size = .small
                badge.parameters.status = isSelected ? .primaryInverted : .primary
            }
        }

        @ViewBuilder
        private func countView(chips: [Ocean.ChipModel]) -> Int {
            return chips.map { $0.number ?? 0 }.reduce(0, { partialResult, counter in
                partialResult + counter
            })
        }

        // MARK: Private properties

        private func onTouch(option touchedOption: FilterBarOption, group touchedGroup: FilterBarGroup) {
            if !parameters.onTouch(touchedOption.chips, touchedOption) {
                if touchedOption.chips.count == 1, touchedOption.mode == .single {
                    updateSelection(chips: touchedOption.chips, option: touchedOption, group: touchedGroup)
                } else {
                    showFilterModal(option: touchedOption, group: touchedGroup)
                }
            }
        }

        private func showFilterModal(option touchedOption: FilterBarOption, group touchedGroup: FilterBarGroup) {
            guard let rootViewController = parameters.rootViewController else {
                return
            }

            switch touchedOption.mode {
            case .single:
                let modal = Ocean.ModalList(rootViewController)
                    .withTitle(touchedOption.title)
                    .withValues(touchedOption.chips.map { Ocean.CellModel(title: $0.title,
                                                                          isSelected: $0.isSelected) })
                    .build()

                modal.onValueSelected = { _, selectedOption in
                    let chips = touchedOption.chips.map { chip in
                        getChipModel(original: chip, isSelected: selectedOption.title == chip.title)
                    }.filter { $0.isSelected }

                    updateSelection(chips: chips, option: touchedOption, group: touchedGroup)
                }

                modal.show()

            case .multiple:
                Ocean.ModalMultipleChoice(rootViewController)
                    .withTitle(parameters.modalTitle ?? touchedOption.title)
                    .withDismiss(true)
                    .withMultipleOptions(touchedOption.chips.map { Ocean.CellModel(title: $0.title,
                                                                                   isSelected: $0.isSelected,
                                                                                   badgeNumber: $0.number) },
                                         textIsRightForMultipleChoice: false)
                    .withAction(textNegative: parameters.secondaryButtonTitle,
                                actionNegative: {
                        updateSelection(chips: [], option: touchedOption, group: touchedGroup)
                    },
                                textPositive: parameters.primaryButtonTitle,
                                actionPositive: { allOptions in
                        let selectedOptions = allOptions.filter { $0.isSelected }
                        let chips = touchedOption.chips.map { chip in
                            getChipModel(original: chip, isSelected: selectedOptions.contains { $0.title == chip.title })
                        }.filter { $0.isSelected }
                        
                        updateSelection(chips: chips, option: touchedOption, group: touchedGroup)
                    })
                    .build()
                    .show()

            case .dateRange:
                Ocean.ModalDateRange(rootViewController)
                    .withTitle(parameters.modalTitle ?? touchedOption.title)
                    .withBeginDate(touchedOption.beginDate)
                    .withEndDate(touchedOption.endDate)
                    .withCompletion { beginDate, endDate in
                        updateSelection(beginDate: beginDate,
                                        endDate: endDate,
                                        option: touchedOption,
                                        group: touchedGroup)
                    }
                    .build()
                    .show()
            }
        }

        private func updateSelection(chips selectedChips: [Ocean.ChipModel],
                                     option touchedOption: FilterBarOption,
                                     group touchedGroup: FilterBarGroup) {
            parameters.groups = parameters.groups.map { group in
                let isSameGroup = isSame(group, touchedGroup)

                return getFilterBarGroup(original: group, options: group.options.map { option in
                    let isSameOption = isSame(option, touchedOption)

                    return getFilterBarOption(original: option, chips: option.chips.map { chip in

                        if isSameGroup && isSameOption {
                            return getChipModel(original: chip,
                                                isSelected: selectedChips.contains { isSame($0, chip) })
                        } else {
                            return getChipModel(original: chip,
                                                isSelected: isSameGroup && group.mode == .single ? false : chip.isSelected)
                        }
                    })
                })
            }

            parameters.onSelectionChange(
                parameters.groups
                    .flatMap { $0.options }
                    .flatMap { $0.chips }
                    .filter { $0.isSelected },
                parameters.groups
            )
        }

        private func updateSelection(beginDate: Date?,
                                     endDate: Date?,
                                     option touchedOption: FilterBarOption,
                                     group touchedGroup: FilterBarGroup) {
            parameters.groups = parameters.groups.map { group in
                let isSameGroup = isSame(group, touchedGroup)

                return getFilterBarGroup(original: group, options: group.options.map { option in
                    let isSameOption = isSame(option, touchedOption)

                    if let beginDate = beginDate, let endDate = endDate, isSameGroup, isSameOption {
                        return getFilterBarOption(original: option, beginDate: beginDate, endDate: endDate)
                    } else {
                        return clearDateRange(original: option, chips: option.chips.map { chip in
                            return getChipModel(original: chip,
                                                isSelected: isSameGroup && group.mode == .single ? false : chip.isSelected)
                        })
                    }
                })
            }

            parameters.onDateRangeChange(beginDate, endDate, parameters.groups)
        }

        private func isSame(_ left: FilterBarGroup, _ right: FilterBarGroup) -> Bool {
            return left.id == right.id
        }

        private func isSame(_ left: FilterBarOption, _ right: FilterBarOption) -> Bool {
            return left.title == right.title
        }

        private func isSame(_ left: Ocean.ChipModel, _ right: Ocean.ChipModel) -> Bool {
            if let leftId = left.id, let rightId = right.id {
                return leftId == rightId
            } else {
                return left.title == right.title
            }
        }

        private func getChipModel(original: Ocean.ChipModel, isSelected: Bool) -> Ocean.ChipModel {
            return Ocean.ChipModel(id: original.id,
                                   icon: original.icon,
                                   number: original.number,
                                   title: original.title,
                                   status: original.status,
                                   isSelected: isSelected)
        }

        private func clearDateRange(original: FilterBarOption, chips: [Ocean.ChipModel]) -> FilterBarOption {
            var option = original
            option.beginDate = nil
            option.endDate = nil

            return getFilterBarOption(original: option, chips: chips)
        }

        private func getFilterBarOption(original: FilterBarOption, chips: [Ocean.ChipModel]) -> FilterBarOption {
            return FilterBarOption(leadingIcon: original.leadingIcon,
                                   title: original.title,
                                   trailingIcon: original.trailingIcon,
                                   mode: original.mode,
                                   chips: chips,
                                   beginDate: original.beginDate,
                                   endDate: original.endDate)
        }

        private func getFilterBarOption(original: FilterBarOption, beginDate: Date?, endDate: Date?) -> FilterBarOption {
            return FilterBarOption(title: original.title, beginDate: beginDate, endDate: endDate)
        }

        private func getFilterBarGroup(original: FilterBarGroup, options: [FilterBarOption]) -> FilterBarGroup {
            return FilterBarGroup(id: original.id, mode: original.mode, options: options)
        }
    }
}
