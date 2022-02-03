//
//  TooltipViewController.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 06/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class TooltipViewController: UIViewController {
    
    private lazy var contentStack: Ocean.StackView = {
        let contentStack = Ocean.StackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(leftButtonExampleStack)
        return contentStack
    }()
    
    private lazy var leftButtonExampleStack: Ocean.StackView = {
        let contentStack = Ocean.StackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.distribution = .fill
        contentStack.alignment = .leading
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(leftButtonExample)

        return contentStack
    }()
    
    private lazy var leftButtonExample: Ocean.ButtonPrimary = {
        Ocean.Button.primaryMD { button in
            button.text = "Show tooltip"
            button.onTouch = {
                self.showActionButton()
            }
        }
    }()
    
    private var tooltipComponent: Ocean.Tooltip = {
        Ocean.Tooltip { component in
            component.message = "Message test"
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showActionButton()
    }
    
    func showActionButton() {
        tooltipComponent.show(target: leftButtonExample, position: .top, presenter: self.contentStack)
    }

}
