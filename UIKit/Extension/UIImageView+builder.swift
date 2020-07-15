//
//  UIImageView+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 07/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIImageView {
    public convenience init(_ builder: (UIImageView) -> Void) {
        self.init()
        builder(self)
    }
}
