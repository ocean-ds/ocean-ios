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
    
    @IBOutlet weak var horizontalPositionControll: UISegmentedControl!
    @IBOutlet weak var verticalPositionControll: UISegmentedControl!
    private var verticalPosition: Ocean.Tooltip.Position = .top
    
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
        return button
    }()
    
    private var tooltipComponent: Ocean.Tooltip = {
        Ocean.Tooltip { component in
            component.title = "Title test"
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
        show()
    }
    
    @IBAction func horizontalValueChanged(_ sender: Any) {
        
        switch horizontalPositionControll.selectedSegmentIndex {
        case 0:
            leftButtonExampleStack.alignment = .leading
        case 1:
            leftButtonExampleStack.alignment = .trailing
        default:
            break
        }

        show()
    }
    
    @IBAction func verticalValueChanged(_ sender: Any) {
        switch verticalPositionControll.selectedSegmentIndex {
        case 0:
            verticalPosition = .top
        case 1:
            verticalPosition = .bottom
        default:
            break
        }

        show()
    }
    
    private func show() {
        tooltipComponent.removeFromSuperview()
        tooltipComponent.show(presenter: self.view, target: leftButtonExample, position: verticalPosition, parent: leftButtonExampleStack)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
