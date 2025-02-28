//
//  Ocean+StepCheckCircleViewFactory.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    final class StepCheckCircleViewFactory: IStepViewCircleFactory {
        typealias StepViewCircle = ICheckCircleViewDrawable & ILineDrawable
        
        func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor, circleFilledColor: UIColor) -> StepViewCircle {
            return StepCheckCircleView(frame: frame,
                                       circleRadius: circleRadius,
                                       circleBorderColor: circleBorderColor,
                                       circleFilledColor: circleFilledColor)
        }
    }
}
