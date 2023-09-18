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
        public var selectAllLabel: String
        public var checkboxes: [CheckboxModel]
        public var onChange: (([CheckboxModel]) -> Void)
        
        public init(selectAllLabel: String,
                    checkboxes: [CheckboxModel],
                    onChange: @escaping (([CheckboxModel]) -> Void)) {
            self.selectAllLabel = selectAllLabel
            self.checkboxes = checkboxes
            self.onChange = onChange
        }
    }
}
