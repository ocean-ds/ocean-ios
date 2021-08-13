//
//  Ocean+CheckBox.swift
//  OceanComponents
//
//  Created by Vini on 12/08/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class CheckBox: RadioButton {
        override var backgroundPath: CGPath {
            get {
                return UIBezierPath(rect: CGRect(x: 0, y: 0, width: size, height: size)).cgPath
            }
        }
        
        override var foregroundShrinkPath: CGPath {
            get {
                let squareSize = size * 0.3
                let center = size * 0.5 - squareSize * 0.5
                return UIBezierPath(rect: CGRect(x: center, y: center, width: squareSize, height: squareSize)).cgPath
            }
        }
        
        override var foregroundExpandPath: CGPath {
            get {
                let squareSize = size * 0.9
                let center = size * 0.5 - squareSize * 0.5
                return UIBezierPath(rect: CGRect(x: center, y: center, width: squareSize, height: squareSize)).cgPath
            }
        }
        
        override func toogleRadio() {
            isSelected = !isSelected
            onTouch?()
            generator.selectionChanged()
        }
    }
}
