//
//  UILabel+builder.swift
//  Blu
//
//  Created by Victor C Tavernari on 08/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UILabel {
    public typealias BuilderLabel = (UILabel) -> Void
    
    public convenience init(_ builder: BuilderLabel) {
        self.init()
        builder(self)
    }
}
