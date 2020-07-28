//
//  UIView+superviewConstraints.swift
//  Blu
//
//  Created by Victor C Tavernari on 29/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation

extension UIView {
    func leadingSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        self.leadingAnchor
            .constraint(equalTo: superview.leadingAnchor,
                        constant: constant)
            .isActive = true
    }

    func trailingSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        superview.trailingAnchor
            .constraint(equalTo: self.trailingAnchor,
                        constant: constant)
            .isActive = true
    }

    func topSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        self.topAnchor
            .constraint(equalTo: superview.topAnchor,
                        constant: constant)
            .isActive = true
    }

    func bottomSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        superview.bottomAnchor
            .constraint(equalTo: self.bottomAnchor,
                        constant: constant)
            .isActive = true
    }

    func centerYSuperview(constant: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        self.centerYAnchor
            .constraint(equalTo: superview.centerYAnchor,
                        constant: constant)
            .isActive = true
    }
}
