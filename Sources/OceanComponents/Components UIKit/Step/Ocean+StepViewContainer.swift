//
//  Ocean+StepViewContainer.swift
//  OceanComponents
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//

import Foundation

public protocol StepViewContainer {
    var numberOfSteps: Int { get set }
    var selectedStep: Int { get set }
    
    func showNextStep()
    func showPreviousStep()
    func moveTo(step: Int)
}
