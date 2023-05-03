//
//  Ocean+FilterBarOptionsModel.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 25/04/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public struct FilterBarOptionsModel {
        public var modalTitle: String
        public var multipleChoiceOptions: [Ocean.ChipModel] = []
        public var primaryButtonTitle: String
        public var secondaryButtonTitle: String
        
        public init(modalTitle: String,
                    multipleChoiceOptions: [Ocean.ChipModel],
                    primaryButtonTitle: String = "Filtrar",
                    secondaryButtonTitle: String = "Cancelar") {
            self.modalTitle = modalTitle
            self.multipleChoiceOptions = multipleChoiceOptions
            self.primaryButtonTitle = primaryButtonTitle
            self.secondaryButtonTitle = secondaryButtonTitle
        }
    }
}
