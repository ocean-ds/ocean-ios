//
//  Ocean+CheckboxModel.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 18/09/23.
//

import Foundation
import OceanTokens

extension Ocean.CheckBoxGroup {
    public struct CheckboxModel: Equatable {
        public var title: String
        public var subtitle: String
        public var isSelected: Bool
        
        public init(title: String,
                    subtitle: String,
                    isSelected: Bool) {
            self.title = title
            self.subtitle = subtitle
            self.isSelected = isSelected
        }
    }
}
