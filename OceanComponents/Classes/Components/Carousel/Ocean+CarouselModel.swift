//
//  Ocean+CarouselModel.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 01/09/22.
//

import OceanTokens

extension Ocean {
    public struct CarouselModel {
        public let image: UIImage?
        public let imageUrl: String

        public init(image: UIImage? = nil,
                    imageUrl: String = "") {
            self.image = image
            self.imageUrl = imageUrl
        }
    }
}
