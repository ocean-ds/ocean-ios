//
//  AlertBoxViewController.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 24/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class AlertBoxViewController: UIViewController {
    
    lazy var contentStack: UIStackView = {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 0
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(alertBoxComponent)

        return contentStack
    }()
    
    private lazy var alertBoxComponent: Ocean.AlertBox = {
        Ocean.AlertBox { component in
            component.size = .small
            component.text = "Na hora de pagar lembre-se de conferir os dados de quem vai receber o dinheiro."
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}
