//
//  UIImageView+builder.swift
//  OceanComponents
//
//  Created by Vini on 11/06/21.
//

import Foundation
import UIKit

extension UIImageView {
    public convenience init(_ builder: (UIImageView) -> Void) {
        self.init()
        builder(self)
    }
}
