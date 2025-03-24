//
//  TriangleView.swift
//  FSCalendar
//
//  Created by Pedro Azevedo on 06/07/21.
//

import OceanTokens
import UIKit

final class TriangleView: UIView {

    var color = Ocean.color.colorInterfaceDarkDeep {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear

        let layerHeight = self.layer.bounds.height
        let layerWidth = self.layer.bounds.width

        let line = UIBezierPath()

        line.move(to: CGPoint(x: 0, y: layerHeight))
        line.addLine(to: CGPoint(x: layerWidth, y: layerHeight))
        line.addLine(to: CGPoint(x: layerWidth/2, y: 0))
        line.addLine(to: CGPoint(x: 0, y: layerHeight))
        line.close()

        color.setStroke()
        color.setFill()
        line.lineWidth = 3.0
        line.fill()
        line.stroke()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = line.cgPath
        self.layer.mask = shapeLayer
    }
}
