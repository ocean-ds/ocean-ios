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
        public var modalTitle: String = ""
        public var multipleChoiceOptions: [Ocean.CellModel] = []
        public var primaryButtonTitle: String = "Filtrar"
        public var secondaryButtonTitle: String = "Cancelar"
        public var onPrimaryButtonPress: (([Ocean.CellModel]) -> Void)?
        public var onSecondaryButtonPress: (() -> Void)?
        
        public init(modalTitle: String,
                    multipleChoiceOptions: [Ocean.CellModel],
                    primaryButtonTitle: String,
                    secondaryButtonTitle: String,
                    onPrimaryButtonPress: (([Ocean.CellModel]) -> Void)? = nil,
                    onSecondaryButtonPress: (() -> Void)? = nil) {
            self.modalTitle = modalTitle
            self.multipleChoiceOptions = multipleChoiceOptions
            self.primaryButtonTitle = primaryButtonTitle
            self.secondaryButtonTitle = secondaryButtonTitle
            self.onPrimaryButtonPress = onPrimaryButtonPress
            self.onSecondaryButtonPress = onSecondaryButtonPress
        }
    }
}
