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
        
        public var view: UIView? {
            didSet {
                updateUI()
            }
        }
        
        public convenience init(builder: CardBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            self.ocean.radius.applyMd()
            self.ocean.borderWidth.applyHairline(color: Ocean.color.colorInterfaceLightDown)
            if withShadow {
                self.ocean.shadow.applyLevel1()
            }
        }
        
        private func updateUI() {
            self.subviews.forEach { subview in
                subview.removeFromSuperview()
            }
            
            if let view = self.view {
                self.add(view: view)
            }
        }
    }
}
