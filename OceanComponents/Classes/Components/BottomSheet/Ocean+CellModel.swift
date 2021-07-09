//
//  Ocean+CellModel.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public struct CellModel {
        let value: String
        var isSelected: Bool
        
        public init(value: String, isSelected: Bool = false) {
            self.value = value
            self.isSelected = isSelected
        }
    }
}
