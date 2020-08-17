//
//  UIStackView+builder.swift
//  OceanComponents
//
//  Created by Alex Gomes on 13/08/20.
//

import Foundation
extension UIStackView {
    public typealias BuilderStackView = (UIStackView) -> Void
    
    convenience init(builder: BuilderStackView) {
        self.init()
        builder(self)
    }
}
