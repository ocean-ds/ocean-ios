//
//  OceanSwiftUI+FilterBarGroup.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 09/01/24.
//

import OceanTokens

extension OceanSwiftUI {

    public struct FilterBarGroup {
        var id: UUID
        var mode: FilterBarChoiceMode
        var options: [FilterBarOption]

        public init(id: UUID = UUID(),
                    mode: FilterBarChoiceMode = .single,
                    options: [FilterBarOption]) {
            self.id = id
            self.mode = mode
            self.options = options
        }
    }
}
