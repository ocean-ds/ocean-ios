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
        let title: String
        let subTitle: String
        let imageIcon: UIImage?
        let hideChevron: Bool
        var isSelected: Bool
        
        public init(title: String, isSelected: Bool = false, subTitle: String = "", imageIcon: UIImage? = nil, hideChevron: Bool = true) {
            self.title = title
            self.subTitle = subTitle
            self.imageIcon = imageIcon
            self.isSelected = isSelected
            self.hideChevron = hideChevron
        }
    }
}
