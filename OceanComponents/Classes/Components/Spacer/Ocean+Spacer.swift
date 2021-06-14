//
//  Ocean+Spacer.swift
//  Blu
//
//  Created by Victor C Tavernari on 30/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation
import OceanTokens

extension Ocean {
    public class Spacer: UIView {
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        public convenience init(space: CGFloat) {
            self.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false

            self.heightAnchor.constraint(equalToConstant: space).isActive = true
            self.widthAnchor.constraint(equalToConstant: space).isActive = true
        }

        public convenience init(lessThan space: CGFloat) {
            self.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false

            self.heightAnchor.constraint(lessThanOrEqualToConstant: space).isActive = true
            self.widthAnchor.constraint(lessThanOrEqualToConstant: space).isActive = true

            let constraints = self.heightAnchor.constraint(equalToConstant: space)
            constraints.priority = .defaultLow
            constraints.isActive = true
        }

        public convenience init(greaterThan space: CGFloat) {
            self.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false

            self.heightAnchor.constraint(greaterThanOrEqualToConstant: space).isActive = true
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: space).isActive = true

            let constraints = self.heightAnchor.constraint(equalToConstant: space)
            constraints.priority = .defaultLow
            constraints.isActive = true
        }

        public convenience init(lessThan less: CGFloat, greaterThan greater: CGFloat) {
            self.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false

            self.heightAnchor.constraint(greaterThanOrEqualToConstant: greater).isActive = true
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: greater).isActive = true

            self.heightAnchor.constraint(lessThanOrEqualToConstant: less).isActive = true
            self.widthAnchor.constraint(lessThanOrEqualToConstant: less).isActive = true

            let constraints = self.heightAnchor.constraint(equalToConstant: less)
            constraints.priority = .defaultLow
            constraints.isActive = true
        }
    }
}
