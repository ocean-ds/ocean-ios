//
//  UILabel+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 08/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UILabel {
    public convenience init(_ builder: (UILabel) -> Void) {
        self.init()
        builder(self)
    }
}
