//
//  Ocean+Divider.swift
//  OceanComponents
//
//  Created by Vini on 25/06/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public class Divider: UIView {
        private var widhtConstraint: NSLayoutDimension?
        private var width: CGFloat = UIScreen.main.bounds.width
        private var height: CGFloat = 1
        
        public convenience init() {
            self.init(frame: .zero)
            setupUI()
        }
        
        public convenience init(width: CGFloat) {
            self.init(frame: .zero)
            self.width = width
            setupUI()
        }
        
        public convenience init(height: CGFloat) {
            self.init(frame: .zero)
            self.height = height
            setupUI()
        }
        
        public convenience init(width: CGFloat, height: CGFloat) {
            self.init(frame: .zero)
            self.width = width
            self.height = height
            setupUI()
        }
        
        public convenience init(widthConstraint: NSLayoutDimension) {
            self.init(frame: .zero)
            self.widhtConstraint = widhtConstraint
            self.height = height
            setupUI()
        }
        
        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightDown
            translatesAutoresizingMaskIntoConstraints = false
            
            heightAnchor.constraint(equalToConstant: self.height).isActive = true
            if let widthConstraint = widhtConstraint {
                widthAnchor.constraint(equalTo: widthConstraint).isActive = true
            } else {
                widthAnchor.constraint(equalToConstant: self.width).isActive = true
            }
        }
    }
}
