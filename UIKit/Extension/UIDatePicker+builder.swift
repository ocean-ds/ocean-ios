//
//  UIDatePicker+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 02/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIDatePicker {
    convenience init(builder: (UIDatePicker) -> Void) {
        self.init()
        builder(self)
    }
}
