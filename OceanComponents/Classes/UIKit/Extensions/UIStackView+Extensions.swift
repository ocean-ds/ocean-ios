//
//  Ocean.StackView+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import UIKit
import OceanTokens

extension Ocean.StackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }

    @discardableResult func add(_ arrangedSubviews: [UIView]) -> Self {
        arrangedSubviews.forEach { addArrangedSubview($0) }
        return self
    }
}
