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
  
        public enum AxisDivider {
            case horizontal
            case vertical
        }
        
        private var widhtConstraint: NSLayoutDimension?
        private var heightConstraint: NSLayoutDimension?
        private var width: CGFloat = UIScreen.main.bounds.width
        private (set) var height: CGFloat = 1
        private var axisDivider: AxisDivider = .horizontal
        
        public convenience init() {
            self.init(frame: .zero)
            self.axisDivider = .horizontal
            setupUI()
        }
        
        public convenience init(width: CGFloat,
                                axis: AxisDivider = .horizontal) {
            self.init(frame: .zero)
            self.width = width
            self.axisDivider = axis
            setupUI()
        }
        
        public convenience init(height: CGFloat,
                                axis: AxisDivider = .horizontal) {
            self.init(frame: .zero)
            self.height = height
            self.axisDivider = axis
            setupUI()
        }
        
        public convenience init(width: CGFloat,
                                height: CGFloat,
                                axis: AxisDivider = .horizontal) {
            self.init(frame: .zero)
            self.width = width
            self.height = height
            self.axisDivider = axis
            setupUI()
        }
        
        public convenience init(widthConstraint: NSLayoutDimension,
                                axis: AxisDivider = .horizontal) {
            self.init(frame: .zero)
            self.widhtConstraint = widhtConstraint
            self.axisDivider = axis
            setupUI()
        }
        
        public convenience init(heightConstraint: NSLayoutDimension,
                                axis: AxisDivider = .horizontal) {
            self.init(frame: .zero)
            self.heightConstraint = heightConstraint
            self.axisDivider = axis
            setupUI()
        }
        
        private func setupUI() {
            backgroundColor = Ocean.color.colorInterfaceLightDown
            translatesAutoresizingMaskIntoConstraints = false
            
            if axisDivider == .vertical {
                adjustDimensions()
            }

            if let widthConstraint = widhtConstraint {
                widthAnchor.constraint(equalTo: widthConstraint).isActive = true
            } else {
                widthAnchor.constraint(equalToConstant: self.width).isActive = true
            }
            
            if let heightConstraint = heightConstraint {
                heightConstraint.constraint(equalTo: heightConstraint).isActive = true
            } else {
                heightAnchor.constraint(equalToConstant: self.height).isActive = true
            }
        }
        
        private func adjustDimensions() {
            width = width == UIScreen.main.bounds.width ? 1 : width
            height = height == 1 ? UIScreen.main.bounds.height : height
        }
    }
}
