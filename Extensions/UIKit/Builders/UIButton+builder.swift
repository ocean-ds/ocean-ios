//
//  UIButton+builder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 01/09/22.
//

import Foundation
import UIKit

extension UIButton {
    public convenience init(builder: (UIButton) -> Void) {
        self.init()
        builder(self)
    }
}
