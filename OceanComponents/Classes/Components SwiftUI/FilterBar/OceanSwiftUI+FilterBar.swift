//
//  OceanSwiftUI+FilterBar.swift
//  Blu
//
//  Created by Renan Massaroto on 08/01/24.
//  Copyright © 2024 Blu. All rights reserved.
//

import SwiftUI
import OceanTokens
import SkeletonUI

extension OceanSwiftUI {
    // MARK: Parameters

    public class FilterBarParameters: ObservableObject {

        @Published public var groups: [FilterBarGroup]
        @Published public var marginLeft: CGFloat = Ocean.size.spacingStackXs
        @Published public var marginRight: CGFloat = Ocean.size.spacingStackXs
        @Published public var showSkeleton: Bool
        @Published public var onTouch: (([Ocean.ChipModel], FilterBarOption) -> Bool)
        @Published public var onSelectionChange: (([Ocean.ChipModel], [FilterBarGroup]) -> Void)

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
                    onSelectionChange: @escaping ([Ocean.ChipModel], [FilterBarGroup]) -> Void = { _, _ in }) {
            self.groups = groups
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
            self.onSelectionChange = onSelectionChange
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
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: parameters.marginLeft)

                    HStack(spacing: Ocean.size.spacingStackXs) {
                        ForEach(parameters.groups, id: \.id) { group in
                            HStack(spacing: Ocean.size.spacingStackXs) {
                                ForEach(group.options, id: \.title) { option in
                                    itemView(option: option, group: group)
                                }
                            }

                            if parameters.groups.last?.id != group.id {
                                Divider { divider in
                                    divider.parameters.axis = .vertical
                                }
                                .padding([.vertical], Ocean.size.spacingStackXs)
                            }
                        }
                    }
                    .frame(height: Constants.barHeight)

                    Spacer(minLength: parameters.marginRight)
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

                if option.mode == .multiple && option.chips.contains(where: { $0.isSelected }) {
                    badge(count: option.chips.filter { $0.isSelected }.count)
                }

                if let icon = option.trailingIcon {
                    imageView(icon: icon, option: option)
                        .padding(.trailing, Ocean.size.spacingStackXxs)
                } else if option.chips.count > 1 {
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

        private func badge(count: Int) -> some View {
            Badge.primaryInvertedSm { badge in
                badge.parameters.count = count
            }
        }

        // MARK: Private properties

        private func onTouch(option touchedOption: FilterBarOption, group touchedGroup: FilterBarGroup) {
            if !parameters.onTouch(touchedOption.chips, touchedOption) {
                if touchedOption.chips.count == 1 {
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

            if touchedOption.mode == .single {
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
            } else {
                Ocean.ModalMultipleChoice(rootViewController)
                    .withTitle(touchedOption.title)
                    .withDismiss(true)
                    .withMultipleOptions(touchedOption.chips.map { Ocean.CellModel(title: $0.title,
                                                                                   isSelected: $0.isSelected) })
                    .withAction(textNegative: "Cancelar",
                                actionNegative: nil,
                                textPositive: "Filtrar",
                                actionPositive: { allOptions in
                        let selectedOptions = allOptions.filter { $0.isSelected }
                        let chips = touchedOption.chips.map { chip in
                            getChipModel(original: chip, isSelected: selectedOptions.contains { $0.title == chip.title })
                        }.filter { $0.isSelected }

                        updateSelection(chips: chips, option: touchedOption, group: touchedGroup)
                    })
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

        private func getFilterBarOption(original: FilterBarOption, chips: [Ocean.ChipModel]) -> FilterBarOption {
            return FilterBarOption(leadingIcon: original.leadingIcon,
                                   title: original.title,
                                   trailingIcon: original.trailingIcon,
                                   mode: original.mode,
                                   chips: chips)
        }

        private func getFilterBarGroup(original: FilterBarGroup, options: [FilterBarOption]) -> FilterBarGroup {
            return FilterBarGroup(id: original.id, mode: original.mode, options: options)
        }
    }
}
