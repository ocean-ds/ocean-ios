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
        private (set) var width: CGFloat?
        private (set) var height: CGFloat?
        private var axisDivider: AxisDivider = .horizontal
        private var color = Ocean.color.colorInterfaceLightDown
        
        public convenience init() {
            self.init(frame: .zero)
            self.axisDivider = .horizontal
            setupUI()
        }
        
        public convenience init(width: CGFloat,
                                axis: AxisDivider = .horizontal,
                                color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.init(frame: .zero)
            self.width = width
            self.axisDivider = axis
            self.color = color
            setupUI()
        }
        
        public convenience init(height: CGFloat,
                                axis: AxisDivider = .horizontal,
                                color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.init(frame: .zero)
            self.height = height
            self.axisDivider = axis
            self.color = color
            setupUI()
        }
        
        public convenience init(width: CGFloat,
                                height: CGFloat,
                                axis: AxisDivider = .horizontal,
                                color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.init(frame: .zero)
            self.width = width
            self.height = height
            self.axisDivider = axis
            self.color = color
            setupUI()
        }
        
        public convenience init(widthConstraint: NSLayoutDimension,
                                axis: AxisDivider = .horizontal,
                                color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.init(frame: .zero)
            self.widthConstraint = widthConstraint
            self.axisDivider = axis
            self.color = color
            setupUI()
        }
        
        public convenience init(heightConstraint: NSLayoutDimension,
                                axis: AxisDivider = .horizontal,
                                color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.init(frame: .zero)
            self.heightConstraint = heightConstraint
            self.axisDivider = axis
            self.color = color
            setupUI()
        }
        
        override public func layoutSubviews() {
            super.layoutSubviews()
            setDimensions(activate: true)
        }
        
        private func setupUI() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = self.color
            setDimensions(activate: false)
        }
        
        private func setDimensions(activate: Bool) {
            if activate {
                constraints.forEach { $0.isActive = activate }
                return 
            }
            
            if let widthConstraint = widthConstraint {
                _ = widthAnchor.constraint(equalTo: widthConstraint)
            } else {
                adjustWidthDimension()
            }
            
            if let heightConstraint = heightConstraint {
                _ = heightAnchor.constraint(equalTo: heightConstraint)
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
