//
//  Image+extensions.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 03/01/25.
//

import SwiftUI

public extension Image {
    init(uiImage: UIImage?) {
        if let uiImage = uiImage {
            self.init(uiImage: uiImage)
        } else {
            self.init(uiImage: UIImage())
        }
    }
}
