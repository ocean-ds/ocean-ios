//
//  UIStackView+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 03/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIStackView {
    convenience init(builder: (UIStackView) -> Void) {
        self.init()
        builder(self)
    }
}
