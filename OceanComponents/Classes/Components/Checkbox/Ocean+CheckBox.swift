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
                let bezierPath = UIBezierPath()
                bezierPath.move(to: CGPoint(x: 6.24, y: 11.11))
                bezierPath.addLine(to: CGPoint(x: 11.44, y: 16.83))
                bezierPath.addLine(to: CGPoint(x: 9.91, y: 16.88))
                bezierPath.addLine(to: CGPoint(x: 17.71, y: 6.88))
                bezierPath.addCurve(to: CGPoint(x: 19.12, y: 6.71), controlPoint1: CGPoint(x: 18.05, y: 6.45), controlPoint2: CGPoint(x: 18.68, y: 6.37))
                bezierPath.addCurve(to: CGPoint(x: 19.29, y: 8.12), controlPoint1: CGPoint(x: 19.55, y: 7.05), controlPoint2: CGPoint(x: 19.63, y: 7.68))
                bezierPath.addLine(to: CGPoint(x: 11.49, y: 18.12))
                bezierPath.addCurve(to: CGPoint(x: 9.96, y: 18.17), controlPoint1: CGPoint(x: 11.11, y: 18.6), controlPoint2: CGPoint(x: 10.38, y: 18.63))
                bezierPath.addLine(to: CGPoint(x: 4.76, y: 12.46))
                bezierPath.addCurve(to: CGPoint(x: 4.83, y: 11.05), controlPoint1: CGPoint(x: 4.39, y: 12.05), controlPoint2: CGPoint(x: 4.42, y: 11.42))
                bezierPath.addCurve(to: CGPoint(x: 6.24, y: 11.11), controlPoint1: CGPoint(x: 5.24, y: 10.67), controlPoint2: CGPoint(x: 5.87, y: 10.7))
                bezierPath.close()
                bezierPath.fill()
                return bezierPath.cgPath
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
    }
}
