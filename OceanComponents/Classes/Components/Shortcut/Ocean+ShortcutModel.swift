//
//  Ocean+ShortcutModel.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public struct ShortcutModel {
        let image: UIImage
        let title: String
        let isHighlight: Bool
        
        public init(image: UIImage, title: String, isHighlight: Bool = false) {
            self.image = image
            self.title = title
            self.isHighlight = isHighlight
        }
    }
}
