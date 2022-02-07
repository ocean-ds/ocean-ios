//
//  Ocean.StackView+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import UIKit
import OceanTokens

extension UIStackView {
    @discardableResult
    public func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }

    @discardableResult
    public func add(_ arrangedSubviews: [UIView]) -> Self {
        arrangedSubviews.forEach { addArrangedSubview($0) }
        return self
    }

    public func setMargins(top: CGFloat = 0,
                           left: CGFloat = 0,
                           bottom: CGFloat = 0,
                           right: CGFloat = 0) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = .init(top: top,
                                   left: left,
                                   bottom: bottom,
                                   right: right)
    }
}
