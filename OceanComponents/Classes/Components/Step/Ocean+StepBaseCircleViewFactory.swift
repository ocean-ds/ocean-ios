//
//  Ocean+StepBaseCircleViewFactory.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    final class StepBaseCircleViewFactory: IStepViewCircleFactory {
        typealias StepViewCircle = ICircleViewDrawable & ILineDrawable
        
        func create(frame: CGRect, circleRadius: CGFloat, circleBorderColor: UIColor, circleFilledColor: UIColor) -> StepViewCircle {
            return StepBaseCircleView(frame: frame,
                                      circleRadius: circleRadius,
                                      circleBorderColor: circleBorderColor,
                                      circleFilledColor: circleFilledColor)
        }
    }
}
