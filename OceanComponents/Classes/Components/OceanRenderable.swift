//
//  RenderViewController.swift
//  Blu
//
//  Created by Victor C Tavernari on 29/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

protocol OceanRenderable {
    var mainStack: UIStackView! { get }
}

extension OceanRenderable {
    func add(view: UIView) {
        self.mainStack.addArrangedSubview(view)
        self.mainStack.updateConstraints()
    }

    func insert(view: UIView, at index: Int) {
        self.mainStack.insertArrangedSubview(view, at: index)
        self.mainStack.updateConstraints()
    }

    func remove(view: UIView) {
        self.mainStack.removeArrangedSubview(view)
        self.mainStack.updateConstraints()
    }
}

