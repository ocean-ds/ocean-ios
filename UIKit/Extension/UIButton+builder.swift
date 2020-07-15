//
//  UIButton+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 03/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIButton {
    convenience init(builder: (UIButton) -> Void) {
        self.init()
        builder(self)
    }
}
