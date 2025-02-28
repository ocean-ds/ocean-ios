//
//  OceanSwiftUI+FilterBarGroup.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 09/01/24.
//

import OceanTokens
import Foundation

extension OceanSwiftUI {

    public struct FilterBarGroup {
        public var id: String
        public var mode: FilterBarChoiceMode
        public var options: [FilterBarOption]

        public init(id: String = UUID().uuidString,
                    mode: FilterBarChoiceMode = .single,
                    options: [FilterBarOption]) {
            self.id = id
            self.mode = mode
            self.options = options
        }
    }
}
