//
//  Ocean+StepView.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    open class StepView: UIView, StepViewContainer {
        private var stepViewWidth: CGFloat = 30
        private var stepViewHeight: CGFloat = 22
        private var stepViews = [StepBaseCircleView]()
        
        public var numberOfSteps: Int = 0
        public var selectedStep: Int = 1
        
        public var circleNextStepBorderColor: UIColor = Ocean.color.colorComplementaryPure
        public var circleNextStepFilledColor: UIColor = .clear
        
        public var circleBorderColor: UIColor = Ocean.color.colorInterfaceLightDown
        public var circleFilledColor: UIColor = .clear
        public var circleRadius: CGFloat = 10
        public var circleBorderWidth: CGFloat = 2
        
        public var selectedCircleBorderColor: UIColor = Ocean.color.colorComplementaryPure
        public var selectedCircleFilledColor: UIColor = Ocean.color.colorComplementaryPure
        public var selectedCircleRadius: CGFloat = 18
        
        public var lineBorderColor: UIColor = Ocean.color.colorInterfaceLightDown
        public var lineBorderHeight: CGFloat = 2
        
        public var selectedLineBorderColor: UIColor = Ocean.color.colorComplementaryPure
        public var selectedLineBorderHeight: CGFloat = 2
        
        convenience public init(numberOfSteps: Int) {
            self.init(frame: .zero)
            self.numberOfSteps = numberOfSteps
        }
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            backgroundColor = .clear
        }
        
        public func showNextStep() {
            moveTo(step: selectedStep + 1)
        }
        
        public func showPreviousStep() {
            moveTo(step: selectedStep - 1)
        }
        
        public func moveTo(step: Int) {
            if step > numberOfSteps || step < 1 {
                return
            }
            
            if step > selectedStep && step - selectedStep == 1 {
                createStepView(for: selectedStep-1, in: numberOfSteps, with: step-1)
                createStepView(for: step-1, in: numberOfSteps, with: step-1)
            }
            else {
                selectedStep = step
                createStepViews()
            }
            selectedStep = step
        }
        
        override open func draw(_ rect: CGRect) {
            prepareForDraw()
            createStepViews()
        }
        
        private func createStepViews() {
            for index in 0 ..< numberOfSteps {
                createStepView(for: index, in: numberOfSteps, with: selectedStep - 1)
            }
        }
        
        private func createStepView(for index: Int, in viewAmount: Int, with selectedStep: Int) {
            var stepView: ICircleViewDrawable & ILineDrawable
            let stepViewFrame = CGRect(x: CGFloat(index) * stepViewWidth,
                                       y: 0,
                                       width: stepViewWidth,
                                       height: stepViewHeight)
            
            if index < selectedStep {
                let factory = StepCheckCircleViewFactory()
                stepView = factory.create(frame: stepViewFrame,
                                          circleRadius: selectedCircleRadius,
                                          circleBorderColor: selectedCircleBorderColor,
                                          circleFilledColor: selectedCircleFilledColor)
                stepView.lineBorderColor = selectedLineBorderColor
                stepView.lineBorderHeight = selectedLineBorderHeight
            } else if index == selectedStep {
                let factory = StepBaseCircleViewFactory()
                stepView = factory.create(frame: stepViewFrame,
                                          circleRadius: circleRadius,
                                          circleBorderColor: circleBorderColor,
                                          circleFilledColor: circleFilledColor)
                stepView.circleFilledColor = circleNextStepFilledColor
                stepView.circleBorderColor = circleNextStepBorderColor
                stepView.lineBorderColor = selectedLineBorderColor
                stepView.lineBorderHeight = selectedLineBorderHeight
            } else {
                let factory = StepBaseCircleViewFactory()
                stepView = factory.create(frame: stepViewFrame,
                                          circleRadius: circleRadius,
                                          circleBorderColor: circleBorderColor,
                                          circleFilledColor: circleFilledColor)
                stepView.circleFilledColor = circleFilledColor
                stepView.circleBorderColor = circleBorderColor
                stepView.lineBorderColor = lineBorderColor
                stepView.lineBorderHeight = lineBorderHeight
            }
            
            stepView.shouldShowLeftLine = index == 0 ? false : true
            stepView.shouldShowRightLine = index == viewAmount - 1 ? false : true
            
            stepView.circleBorderWidth = circleBorderWidth
            
            replaceView(with: stepView as! StepBaseCircleView, on: index)
        }
        
        private func replaceView(with view: StepBaseCircleView, on index: Int) {
            if index < stepViews.count {
                willRemoveSubview(stepViews[index])
                stepViews[index].removeFromSuperview()
                stepViews.remove(at: index)
                stepViews.insert(view, at: index)
                
                addSubview(view)
            }
        }
        
        private func prepareForDraw() {
            for view in subviews { view.removeFromSuperview() }
            
            let stepViewRect = CGRect(x: 0, y: 0, width: stepViewWidth, height: frame.height)
            self.stepViews = [StepBaseCircleView].init(repeating: StepBaseCircleView(frame: stepViewRect), count: numberOfSteps)
        }
    }
}
