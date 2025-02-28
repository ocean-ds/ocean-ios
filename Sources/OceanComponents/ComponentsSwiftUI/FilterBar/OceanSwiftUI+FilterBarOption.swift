//
//  OceanSwiftUI+FilterBarOption.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 09/01/24.
//

import OceanTokens
import UIKit

extension OceanSwiftUI {

    public struct FilterBarOption {
        public var leadingIcon: UIImage?
        public var title: String
        public var trailingIcon: UIImage?
        public var shouldShowTrailingIcon: Bool

        public var mode: FilterBarChoiceMode
        public var chips: [Ocean.ChipModel]

        public var beginDate: Date?
        public var endDate: Date?

        public var isSelected: Bool { chips.contains { $0.isSelected } || (beginDate != nil && endDate != nil) }
        public var label: String {
            if chips.count == 1 || !isSelected || mode == .multiple {
                return title
            } else if let beginDate = beginDate, let endDate = endDate, mode == .dateRange {
                return "\(beginDate.shortDateFormat()) a \(endDate.shortDateFormat())"
            } else {
                return chips.first { $0.isSelected }!.title
            }
        }

        public init(leadingIcon: UIImage? = nil,
                    title: String,
                    trailingIcon: UIImage? = nil,
                    shouldShowTrailingIcon: Bool = true,
                    mode: FilterBarChoiceMode = .single,
                    chips: [Ocean.ChipModel],
                    beginDate: Date? = nil,
                    endDate: Date? = nil) {
            self.leadingIcon = leadingIcon
            self.title = title
            self.trailingIcon = trailingIcon
            self.shouldShowTrailingIcon = shouldShowTrailingIcon
            self.mode = mode
            self.chips = chips
            self.beginDate = beginDate
            self.endDate = endDate
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    shouldShowTrailingIcon: Bool = true,
                    mode: FilterBarChoiceMode = .single,
                    chips: [Ocean.ChipModel]) {
            self.leadingIcon = leadingIcon
            self.title = chips.first?.title ?? ""
            self.trailingIcon = trailingIcon
            self.shouldShowTrailingIcon = shouldShowTrailingIcon
            self.mode = mode
            self.chips = chips
        }

        public init(leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    shouldShowTrailingIcon: Bool = true,
                    mode: FilterBarChoiceMode = .single,
                    chip: Ocean.ChipModel) {
            self.leadingIcon = leadingIcon
            self.title = chip.title
            self.trailingIcon = trailingIcon
            self.shouldShowTrailingIcon = shouldShowTrailingIcon
            self.mode = mode
            self.chips = [chip]
        }

        public init(title: String, beginDate: Date?, endDate: Date?) {
            self.title = title
            self.shouldShowTrailingIcon = true
            self.mode = .dateRange
            self.chips = []
            self.beginDate = beginDate
            self.endDate = endDate
        }
    }
}
