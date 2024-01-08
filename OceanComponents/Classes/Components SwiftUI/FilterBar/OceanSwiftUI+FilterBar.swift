//
//  SUIFilterBar.swift
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

        @Published public var groups: [OceanSwiftUI.FilterBarGroup]
        @Published public var isSelected: Bool
        @Published public var showSkeleton: Bool
        @Published public var onTouch: ((OceanSwiftUI.FilterBar, OceanSwiftUI.FilterBarOption) -> Bool)

        public var options: [OceanSwiftUI.FilterBarOption] {
            get {
                groups.flatMap { $0.options }
            }
            set {
                groups = [.init(options: newValue)]
            }
        }

        public init(groups: [OceanSwiftUI.FilterBarGroup] = [],
                    showSkeleton: Bool = false,
                    onTouch: @escaping (OceanSwiftUI.FilterBar, OceanSwiftUI.FilterBarOption) -> Bool = { _, _ in return false }) {
            self.groups = groups
            self.isSelected = false
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }

        public init(options: [OceanSwiftUI.FilterBarOption] = [],
                    showSkeleton: Bool = false,
                    onTouch: @escaping (OceanSwiftUI.FilterBar, OceanSwiftUI.FilterBarOption) -> Bool = { _, _ in return false }) {
            self.groups = [.init(options: options)]
            self.isSelected = false
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
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

        public init(parameters: FilterBarParameters = FilterBarParameters(groups: [])) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var divider: OceanSwiftUI.Divider = OceanSwiftUI.Divider { divider in
            divider.parameters.axis = .vertical
        }

        public var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    Spacer(minLength: Ocean.size.spacingStackXs)

                    HStack(spacing: Ocean.size.spacingStackXs) {
                        ForEach(parameters.groups, id: \.id) { group in
                            HStack(spacing: Ocean.size.spacingStackXs) {
                                ForEach(group.options, id: \.label) { option in
                                    itemView(option: option, group: group)
                                }
                            }

                            if parameters.groups.last?.id != group.id {
                                divider
                                    .frame(height: Constants.itemHeight)
                            }
                        }
                    }
                    .frame(height: Constants.barHeight)

                    Spacer(minLength: Ocean.size.spacingStackXs)
                }
            }
        }

        private func itemView(option: OceanSwiftUI.FilterBarOption, group: OceanSwiftUI.FilterBarGroup) -> some View {
            HStack {
                if let icon = option.leadingIcon {
                    imageView(icon: icon, option: option)
                        .padding(.leading, Ocean.size.spacingStackXxs)

                    Spacer(minLength: Ocean.size.spacingStackXxxs)
                } else {
                    Spacer(minLength: Ocean.size.spacingStackXs)
                }

                Text(option.label)
                    .font(Font(
                        UIFont.baseSemiBold(size: Ocean.font.fontSizeXxs)!
                    ))
                    .foregroundColor(Color(
                        option.isSelected
                        ? Ocean.color.colorInterfaceLightPure
                        : Ocean.color.colorBrandPrimaryPure
                    ))
                    .onTapGesture {
                        onTouch(option: option, group: group)
                    }
                    .frame(height: Constants.itemHeight)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding([.vertical], Ocean.size.spacingStackXxs)

                if let icon = option.trailingIcon {
                    imageView(icon: icon, option: option)
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

        }

        private func imageView(icon: UIImage, option: OceanSwiftUI.FilterBarOption) -> some View {
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

        // MARK: Private properties

        private func isSame(_ left: FilterBarGroup, _ right: FilterBarGroup) -> Bool {
            return left.id == right.id
        }

        private func isSame(_ left: FilterBarOption, _ right: FilterBarOption) -> Bool {
            return left.label == right.label
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

        private func onTouch(option touchedOption: OceanSwiftUI.FilterBarOption, group touchedGroup: OceanSwiftUI.FilterBarGroup) {
            if touchedOption.chips.count == 1 {
                if !parameters.onTouch(self, touchedOption) {
                    guard let firstChip = touchedOption.chips.first else {
                        return
                    }

                    parameters.groups = parameters.groups.map { group in
                        let isSameGroup = isSame(group, touchedGroup)

                        return FilterBarGroup(id: group.id, options: group.options.map { option in
                            let isSameOption = isSame(option, touchedOption)

                            return FilterBarOption(leadingIcon: option.leadingIcon,
                                                   label: option.label,
                                                   trailingIcon: option.trailingIcon,
                                                   chips: option.chips.map { chip in
                                let isSameChip = isSame(chip, firstChip)
                                var isSelected = isSameChip ? !chip.isSelected : chip.isSelected

                                if group.mode == .single && isSameGroup && !isSameOption {
                                    isSelected = false
                                }

                                return getChipModel(original: chip, isSelected: isSelected)
                            })
                        })
                    }
                }
            } else {
                //TODO: Open modal
            }
        }
    }
}

extension OceanSwiftUI {

    public struct FilterBarGroup {
        var id: UUID
        var mode: FilterBarGroupChoiceMode
        var options: [OceanSwiftUI.FilterBarOption]

        public init(id: UUID = UUID(),
                    mode: FilterBarGroupChoiceMode = .single,
                    options: [OceanSwiftUI.FilterBarOption]) {
            self.id = id
            self.mode = mode
            self.options = options
        }
    }

    public struct FilterBarOption {
        var leadingIcon: UIImage?
        var label: String
        var trailingIcon: UIImage?

        var chips: [Ocean.ChipModel]

        var isSelected: Bool { chips.contains { $0.isSelected } }

        public init(leadingIcon: UIImage? = nil,
                    label: String,
                    trailingIcon: UIImage? = nil,
                    chips: [Ocean.ChipModel]) {
            self.leadingIcon = leadingIcon
            self.label = label
            self.trailingIcon = trailingIcon
            self.chips = chips
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    chips: [Ocean.ChipModel]) {
            self.leadingIcon = leadingIcon
            self.label = chips.first?.title ?? ""
            self.trailingIcon = trailingIcon
            self.chips = chips
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    chip: Ocean.ChipModel) {
            self.leadingIcon = leadingIcon
            self.label = chip.title
            self.trailingIcon = trailingIcon
            self.chips = [chip]
        }
    }

    public enum FilterBarGroupChoiceMode {
        case single
        case multiple
    }
}

extension OceanSwiftUI.FilterBar {
    public static func filterBar(builder: OceanSwiftUI.FilterBar.Builder? = nil) -> OceanSwiftUI.FilterBar {
        return OceanSwiftUI.FilterBar { filterBar in
            builder?(filterBar)
        }
    }
}
