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
        
       
        
        override var withAnimation: Bool {
            get {
                return false
            }
        }
        
        override var backgroundPath: CGPath {
            get {
                return UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size, height: size), cornerRadius: Ocean.size.borderRadiusSm).cgPath
            }
        }

        override var foregroundShrinkPath: CGPath {
            get {
                self.setupCheckIcon()
            }
        }
        
        override var foregroundExpandPath: CGPath {
            get {
                let squareSize = size * 0.9
                let center = size * 0.5 - squareSize * 0.5
                return UIBezierPath(roundedRect: CGRect(x: center, y: center, width: squareSize, height: squareSize), cornerRadius: Ocean.size.borderRadiusSm).cgPath
            }
        }
        
        override func toogleRadio() {
            isSelected = !isSelected
            onTouch?()
            generator.selectionChanged()
        }
        
        private func setupCheckIcon() -> CGPath {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 5, y: 10.18))
            bezierPath.addLine(to: CGPoint(x: 8.85, y: 14))
            bezierPath.addLine(to: CGPoint(x: 15, y: 7.64))
            bezierPath.addLine(to: CGPoint(x: 14.23, y: 7))
            bezierPath.addLine(to: CGPoint(x: 8.85, y: 12.73))
            bezierPath.addLine(to: CGPoint(x: 5.77, y: 9.55))
            bezierPath.addLine(to: CGPoint(x: 5, y: 10.18))
            bezierPath.close()
            UIColor.gray.setFill()
            bezierPath.fill()
            UIColor.black.setStroke()
            bezierPath.lineWidth = 3
            bezierPath.lineCapStyle = .round
            bezierPath.lineJoinStyle = .round
            bezierPath.stroke()
            return bezierPath.cgPath
        }
    }
}
