//
//  Ocean+TextLabelModel.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 21/07/22.
//

import OceanTokens
import UIKit

extension Ocean {
    public struct TextLabelModel {
        let value: String
        let newValue: String?
        let imageIcon: UIImage?
        let bold: Bool
        let color: UIColor?

        public init(value: String,
                    newValue: String? = nil,
                    imageIcon: UIImage? = nil,
                    bold: Bool = false,
                    color: UIColor? = nil) {
            self.value = value
            self.newValue = newValue
            self.imageIcon = imageIcon
            self.bold = bold
            self.color = color
        }
    }
}
