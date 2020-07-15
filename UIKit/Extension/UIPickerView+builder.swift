//
//  UIPickerView+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 03/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIPickerView {
    convenience init(builder: (UIPickerView) -> Void) {
        self.init()
        builder(self)
    }
}
