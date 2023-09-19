//
//  Ocean+CheckboxesModel.swift
//  Charts
//
//  Created by Acassio Mendonça on 18/09/23.
//

import Foundation
import OceanTokens

extension Ocean.CheckBoxGroup {
    public struct CheckboxesModel {
        public var selectAllText: String
        public var checkboxes: [CheckboxModel]
        public var onChange: (([CheckboxModel]) -> Void)
        
        public init(selectAllText: String,
                    checkboxes: [CheckboxModel],
                    onChange: @escaping (([CheckboxModel]) -> Void)) {
            self.selectAllText = selectAllText
            self.checkboxes = checkboxes
            self.onChange = onChange
        }
    }
}
