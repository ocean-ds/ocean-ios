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
        public var isSelected: Bool
        public let hideChevron: Bool
        public var badgeNumber: Int?

        public init(title: String,
                    subTitle: String = "",
                    imageIcon: UIImage? = nil,
                    isSelected: Bool = false,
                    hideChevron: Bool = true,
                    badgeNumber: Int? = nil) {
            self.title = title
            self.subTitle = subTitle
            self.imageIcon = imageIcon
            self.isSelected = isSelected
            self.hideChevron = hideChevron
            self.badgeNumber = badgeNumber
        }
    }
}
