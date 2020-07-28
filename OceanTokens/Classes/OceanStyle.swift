//
//  Ocean.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit

public struct OceanStyle {
    public struct OceanRadius {
        private let view: UIView
        init(view: UIView) {
            self.view = view
        }
        
        public func applyCircular() {
            self.view.layer.cornerRadius = self.view.bounds.height * Ocean.size.borderRadiusCircular
        }
        
        public func applyLg() {
            self.view.layer.cornerRadius = Ocean.size.borderRadiusLg
        }
        
        public func applyMd() {
            self.view.layer.cornerRadius = Ocean.size.borderRadiusMd
        }
        public func applyPill() {
            self.view.layer.cornerRadius = Ocean.size.borderRadiusCircular * self.view.bounds.height
        }
        public func applyNone() {
            self.view.layer.cornerRadius = 0
        }
        public func applySm() {
            self.view.layer.cornerRadius = Ocean.size.borderRadiusSm
        }
    }
    
    public struct OceanBorderWidth {
        private let view: UIView
        init(view: UIView) {
            self.view = view
        }
        public func applyThin() {
            self.view.layer.borderWidth = Ocean.size.borderWidthThin
        }
        public func applyThick() {
            self.view.layer.borderWidth = Ocean.size.borderWidthThick
        }
        public func applyNone() {
            self.view.layer.borderWidth = Ocean.size.borderWidthNone
        }
        public func applyHeavy() {
            self.view.layer.borderWidth = Ocean.size.borderWidthHeavy
        }
        public func applyHairline() {
            self.view.layer.borderWidth = Ocean.size.borderWidthHairline
        }
    }
    public struct OceanOpacity {
        private let view: UIView
        init(view: UIView) {
            self.view = view
        }
    }
    
    public struct OceanShadow {
        private let view: UIView
        init(view: UIView) {
            self.view = view
        }
        public func applyLevel1() {
            self.view.applyShadow(parameters: Ocean.shadow.shadowLevel1)
        }
        public func applyLevel2() {
            self.view.applyShadow(parameters: Ocean.shadow.shadowLevel2)
        }
        public func applyLevel3() {
            self.view.applyShadow(parameters: Ocean.shadow.shadowLevel3)
        }
        public func applyLevel4() {
            self.view.applyShadow(parameters: Ocean.shadow.shadowLevel4)
        }
    }
    private let view: UIView
    init(view: UIView) {
       self.view = view
    }
    public var radius: OceanRadius { OceanRadius(view: self.view) }
    public var shadow: OceanShadow { OceanShadow(view: self.view) }
    public var borderWidth: OceanBorderWidth { OceanBorderWidth(view: self.view) }
}



