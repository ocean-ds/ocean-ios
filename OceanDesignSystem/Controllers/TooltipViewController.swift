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
    
    private lazy var contentStack: UIStackView = {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.distribution = .fillProportionally
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(leftButtonExampleStack)
        return contentStack
    }()
    
    private lazy var leftButtonExampleStack: UIStackView = {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.distribution = .fillProportionally
        contentStack.alignment = .leading
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(leftButtonExample)

        return contentStack
    }()
    
    private lazy var leftButtonExample: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.widthAnchor.constraint(equalToConstant: 130).isActive = true
        button.setTitle("Show tooltip", for: .normal)
        button.addTarget(self, action: #selector(showActionButton), for: .touchUpInside)
        return button
    }()
    
    private var tooltipComponent: Ocean.Tooltip = {
        Ocean.Tooltip { component in
            component.message = "Message test"
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @objc func showActionButton() {
        tooltipComponent.show(target: leftButtonExample, position: .top)
    }

}
