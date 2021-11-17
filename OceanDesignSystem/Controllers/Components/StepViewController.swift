//
//  StepViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Consulmagnos Romeiro on 16/11/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class StepViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stepView = Ocean.StepView(numberOfSteps: 4)
        view.addSubview(stepView)
        
        let buttonMinus = Ocean.Button.primarySM { view in
            view.text = "-"
            view.onTouch = {
                stepView.showPreviousStep()
            }
        }
        view.addSubview(buttonMinus)
        
        let buttonPlus = Ocean.Button.primarySM { view in
            view.text = "+"
            view.onTouch = {
                stepView.showNextStep()
            }
        }
        view.addSubview(buttonPlus)
        
        NSLayoutConstraint.activate([
            stepView.widthAnchor.constraint(equalToConstant: 116),
            stepView.heightAnchor.constraint(equalToConstant: 20),
            stepView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            buttonMinus.widthAnchor.constraint(equalToConstant: 60),
            buttonMinus.heightAnchor.constraint(equalToConstant: 30),
            buttonMinus.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonMinus.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            buttonPlus.widthAnchor.constraint(equalToConstant: 60),
            buttonPlus.heightAnchor.constraint(equalToConstant: 30),
            buttonPlus.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            buttonPlus.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}
