//
//  OceanSwiftUI+FilterBarOption.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 09/01/24.
//

import OceanTokens

extension OceanSwiftUI {
    
    public struct FilterBarOption {
        public var leadingIcon: UIImage?
        public var title: String
        public var trailingIcon: UIImage?

        public var mode: FilterBarChoiceMode
        public var chips: [Ocean.ChipModel]

        public var isSelected: Bool { chips.contains { $0.isSelected } }
        public var label: String {
            chips.count == 1 || !isSelected
            ? title
            : chips.first { $0.isSelected }!.title
        }

        public init(leadingIcon: UIImage? = nil,
                    title: String,
                    trailingIcon: UIImage? = nil,
                    mode: FilterBarChoiceMode = .single,
                    chips: [Ocean.ChipModel]) {
            self.leadingIcon = leadingIcon
            self.title = title
            self.trailingIcon = trailingIcon
            self.mode = mode
            self.chips = chips
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    mode: FilterBarChoiceMode = .single,
                    chips: [Ocean.ChipModel]) {
            self.leadingIcon = leadingIcon
            self.title = chips.first?.title ?? ""
            self.trailingIcon = trailingIcon
            self.mode = mode
            self.chips = chips
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    mode: FilterBarChoiceMode = .single,
                    chip: Ocean.ChipModel) {
            self.leadingIcon = leadingIcon
            self.title = chip.title
            self.trailingIcon = trailingIcon
            self.mode = mode
            self.chips = [chip]
        }
    }
}
