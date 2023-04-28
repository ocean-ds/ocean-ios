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
        
        private var widthConstraint: NSLayoutDimension?
        private var heightConstraint: NSLayoutDimension?
        private var width: CGFloat?
        private (set) var height: CGFloat?
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
            self.widthConstraint = widthConstraint
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
            setDimensions()
        }
        
        private func setDimensions() {
            translatesAutoresizingMaskIntoConstraints = false

            if let widthConstraint = widthConstraint {
                widthAnchor.constraint(equalTo: widthConstraint).isActive = true
            } else {
                adjustWidthDimension()
            }
            
            if let heightConstraint = heightConstraint {
                heightConstraint.constraint(equalTo: heightConstraint).isActive = true
            } else {
                adjustHeightDimension()
            }
        }
        
        private func adjustWidthDimension() {
            let width = self.width ?? (axisDivider == .vertical ? 1 : UIScreen.main.bounds.width)
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        private func adjustHeightDimension() {
            let height = self.height ?? (axisDivider == .vertical ? UIScreen.main.bounds.height : 1)
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
