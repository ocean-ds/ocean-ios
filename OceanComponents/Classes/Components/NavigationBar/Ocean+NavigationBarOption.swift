//
//  Ocean+NavigationBarOption.swift
//  OceanComponents
//
//  Created by Vini on 22/07/21.
//

import Foundation

public class OceanBarButtonItem: UIBarButtonItem {
    var options: [OceanNavigationBarOption] = []
}

public struct OceanNavigationBarOption {
    let title: String
    let image: UIImage?
    let isDestructive: Bool
    let action: () -> Void
    
    public init(title: String,
         image: UIImage?,
         isDestructive: Bool = false,
         action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.isDestructive = isDestructive
        self.action = action
    }
}
