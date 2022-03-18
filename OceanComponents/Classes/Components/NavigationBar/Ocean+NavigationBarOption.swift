//
//  Ocean+NavigationBarOption.swift
//  OceanComponents
//
//  Created by Vini on 22/07/21.
//

import Foundation
import UIKit
import OceanTokens

public class OceanBarButtonItem: UIBarButtonItem {
    var options: [OceanNavigationBarOption] = []
}

public struct OceanNavigationBarOption {
    public let title: String
    public let image: UIImage?
    public let tintColor: UIColor?
    public let isDestructive: Bool
    public let action: () -> Void

    public init(title: String,
                image: UIImage?,
                tintColor: UIColor? = Ocean.color.colorBrandPrimaryPure,
                isDestructive: Bool = false,
                action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.tintColor = tintColor
        self.isDestructive = isDestructive
        self.action = action
    }
}
