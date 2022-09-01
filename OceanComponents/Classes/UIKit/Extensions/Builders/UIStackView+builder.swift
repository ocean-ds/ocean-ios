//
//  Ocean.StackView+builder.swift
//  OceanComponents
//
//  Created by Alex Gomes on 13/08/20.
//

import Foundation
import OceanTokens

extension Ocean.StackView {
    public typealias BuilderStackView = (Ocean.StackView) -> Void
    
    public convenience init(builder: BuilderStackView) {
        self.init()
        builder(self)
    }
}
