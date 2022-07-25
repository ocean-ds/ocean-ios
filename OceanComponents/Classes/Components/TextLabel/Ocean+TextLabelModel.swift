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
        var color: UIColor?
        let colorString: String?

        public init(value: String,
                    newValue: String? = nil,
                    imageIcon: UIImage? = nil,
                    bold: Bool = false,
                    color: UIColor? = nil,
                    colorString: String? = nil) {
            self.value = value
            self.newValue = newValue
            self.imageIcon = imageIcon
            self.bold = bold
            self.color = color
            self.colorString = colorString
        }
    }
}
