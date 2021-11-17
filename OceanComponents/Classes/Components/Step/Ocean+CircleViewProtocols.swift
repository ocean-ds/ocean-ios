//
//  Ocean+CircleViewProtocols.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import UIKit

protocol ICircleViewDrawable {
    var circleBorderColor: UIColor { get set }
    var circleFilledColor: UIColor { get set }
    var circleRadius: CGFloat { get set }
    var circleBorderWidth: CGFloat { get set }
    
    func drawCircle()
}

protocol ICheckCircleViewDrawable: ICircleViewDrawable {
    var image: UIImage? { get set }
    
    func drawImage()
}

protocol ILineDrawable {
    var lineBorderColor: UIColor? { get set }
    var lineBorderHeight: CGFloat { get set }
    var shouldShowLeftLine: Bool { get set }
    var shouldShowRightLine: Bool { get set }
    
    func drawLeftLine()
    func drawRightLine()
}
