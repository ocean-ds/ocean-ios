//
//  Ocean+CellModel.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public struct CellModel {
        public let title: String
        public let subTitle: String
        public let imageIcon: UIImage?
        public let hideChevron: Bool
        public var isSelected: Bool

        public init(title: String,
                    isSelected: Bool = false,
                    subTitle: String = "",
                    imageIcon: UIImage? = nil,
                    hideChevron: Bool = true) {
            self.title = title
            self.subTitle = subTitle
            self.imageIcon = imageIcon
            self.isSelected = isSelected
            self.hideChevron = hideChevron
        }
    }
}
