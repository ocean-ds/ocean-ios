//
//  Ocean+Card.swift
//  OceanComponents
//
//  Created by Vini on 07/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class Card: UIView {
        public typealias CardBuilder = (Card) -> Void
        
        public var withShadow: Bool = false
        
        public var view: UIView = UIView() {
            didSet {
                updateView()
            }
        }
        
        public convenience init(builder: CardBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        internal func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.ocean.radius.applyMd()
            self.ocean.borderWidth.applyHairline()
            self.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            if withShadow {
                self.ocean.shadow.applyLevel1()
            }
        }
        
        internal func updateView() {
            self.subviews.forEach { subview in
                subview.removeFromSuperview()
            }
            
            self.add(view: view)
        }
    }
}
