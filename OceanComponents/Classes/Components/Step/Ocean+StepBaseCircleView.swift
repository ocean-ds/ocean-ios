//
//  Ocean+StepBaseCircleView.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    class StepBaseCircleView: UIView, ICircleViewDrawable, ILineDrawable {
        private var path: UIBezierPath!
        private var lineWidth: CGFloat {
            return (frame.width - circleRadius) / 2
        }
        
        var circleBorderColor: UIColor = Ocean.color.colorComplementaryPure
        var circleFilledColor: UIColor = .clear
        var circleRadius: CGFloat = 40
        var circleBorderWidth: CGFloat = 2
        
        var lineBorderColor: UIColor?
        var lineBorderHeight: CGFloat = 2
        var shouldShowLeftLine: Bool = false
        var shouldShowRightLine: Bool = false

        convenience init(frame: CGRect,
                         circleRadius: CGFloat,
                         circleBorderColor: UIColor,
                         circleFilledColor: UIColor) {
            self.init(frame: frame)
            self.circleRadius = circleRadius
            self.circleBorderColor = circleBorderColor
            self.circleFilledColor = circleFilledColor
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override func draw(_ rect: CGRect) {
            createStepView()
        }
        
        private func createStepView() {
            drawCircle()
            if shouldShowLeftLine { drawLeftLine() }
            if shouldShowRightLine { drawRightLine() }
        }
        
        func drawCircle() {
            // create circle bezier path
            path = UIBezierPath(ovalIn: CGRect(x: frame.width / 2 - circleRadius / 2,
                                               y: frame.height / 2 - circleRadius / 2,
                                               width: circleRadius,
                                               height: circleRadius))
            
            // fill circle
            circleFilledColor.setFill()
            path.fill()
            
            // draw circle border
            circleBorderColor.setStroke()
            path.lineWidth = circleBorderWidth
            path.stroke()
        }
        
        func drawLeftLine() {
            path = UIBezierPath(rect: CGRect(x: 0, y: frame.height / 2, width: lineWidth, height: lineBorderHeight))
            (lineBorderColor ?? circleBorderColor).setFill()
            path.fill()
        }
        
        func drawRightLine() {
            path = UIBezierPath(rect: CGRect(x: lineWidth + circleRadius, y: frame.height / 2, width: lineWidth, height: lineBorderHeight))
            (lineBorderColor ?? circleBorderColor).setFill()
            path.fill()
        }
    }
}
