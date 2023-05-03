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
        public var options: [Ocean.ChipModel] = []
        public var primaryButtonTitle: String
        public var secondaryButtonTitle: String
        
        public init(modalTitle: String,
                    options: [Ocean.ChipModel],
                    primaryButtonTitle: String = "Filtrar",
                    secondaryButtonTitle: String = "Cancelar") {
            self.modalTitle = modalTitle
            self.options = options
            self.primaryButtonTitle = primaryButtonTitle
            self.secondaryButtonTitle = secondaryButtonTitle
        }
    }
}
