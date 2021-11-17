//
//  Ocean+IStepViewCircleFactory.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import UIKit

protocol IStepViewCircleFactory {
    associatedtype StepCircleView
    
    func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor, circleFilledColor: UIColor) -> StepCircleView
}
