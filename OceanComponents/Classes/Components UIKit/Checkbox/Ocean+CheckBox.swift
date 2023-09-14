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
        public enum Icon {
            case check
            case minus
        }
        
        private lazy var icon: CGPath = checkIcon
        private lazy var checkIcon: CGPath = setupCheckIcon()
        private lazy var minusIcon: CGPath = setupMinusIcon()
        
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
        
        override var foregroundExpandPath: CGPath {
            get {
                let squareSize = size * 0.9
                let center = size * 0.5 - squareSize * 0.5
                return UIBezierPath(roundedRect: CGRect(x: center, y: center, width: squareSize, height: squareSize), cornerRadius: Ocean.size.borderRadiusSm).cgPath
            }
        }
        
        override var foregroundShrinkPath: CGPath {
            get {
                return icon
            }
        }
        
        override func toogleRadio() {
            isSelected = !isSelected
            onTouch?()
            generator.selectionChanged()
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public convenience init(setup: (CheckBox) -> Void) {
            self.init()
            setup(self)
        }
        
        public func setupIconType(_ type: Icon) {
            switch type {
            case .check:
                icon = checkIcon
            case .minus:
                icon = minusIcon
            }
        }
        
        private func setupCheckIcon() -> CGPath {
            let bezier2Path = UIBezierPath()
            bezier2Path.move(to: CGPoint(x: 4.75, y: 9.75))
            bezier2Path.addCurve(to: CGPoint(x: 5.75, y: 11.75), controlPoint1: CGPoint(x: 4.25, y: 10.75), controlPoint2: CGPoint(x: 5.75, y: 11.75))
            bezier2Path.addCurve(to: CGPoint(x: 7.75, y: 13.75), controlPoint1: CGPoint(x: 5.75, y: 11.75), controlPoint2: CGPoint(x: 7.25, y: 13.25))
            bezier2Path.addCurve(to: CGPoint(x: 8.75, y: 14.25), controlPoint1: CGPoint(x: 7.94, y: 13.94), controlPoint2: CGPoint(x: 8.75, y: 14.25))
            bezier2Path.addCurve(to: CGPoint(x: 9.75, y: 13.75), controlPoint1: CGPoint(x: 8.75, y: 14.25), controlPoint2: CGPoint(x: 9.44, y: 14.06))
            bezier2Path.addCurve(to: CGPoint(x: 15.65, y: 7.25), controlPoint1: CGPoint(x: 10.25, y: 13.25), controlPoint2: CGPoint(x: 15.65, y: 7.25))
            bezier2Path.addCurve(to: CGPoint(x: 15.75, y: 5.75), controlPoint1: CGPoint(x: 15.65, y: 7.25), controlPoint2: CGPoint(x: 16.75, y: 6.25))
            bezier2Path.addCurve(to: CGPoint(x: 13.75, y: 6.75), controlPoint1: CGPoint(x: 14.75, y: 5.25), controlPoint2: CGPoint(x: 13.75, y: 6.75))
            bezier2Path.addLine(to: CGPoint(x: 8.75, y: 12.25))
            bezier2Path.addLine(to: CGPoint(x: 6.25, y: 9.75))
            bezier2Path.addCurve(to: CGPoint(x: 4.75, y: 9.75), controlPoint1: CGPoint(x: 6.25, y: 9.75), controlPoint2: CGPoint(x: 5.25, y: 8.75))
            bezier2Path.close()
            UIColor.gray.setFill()
            bezier2Path.fill()
            UIColor.black.setStroke()
            bezier2Path.lineWidth = 0.5
            bezier2Path.lineCapStyle = .round
            bezier2Path.lineJoinStyle = .round
            bezier2Path.stroke()
            return bezier2Path.cgPath
        }
        
        private func setupMinusIcon() -> CGPath {
            let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 5, y: 9, width: 11, height: 2),
                                              cornerRadius: 0.5)
            UIColor.gray.setFill()
            rectangle2Path.fill()
            return rectangle2Path.cgPath
        }
    }
}
