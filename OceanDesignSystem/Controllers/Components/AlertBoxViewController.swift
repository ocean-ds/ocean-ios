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
    lazy var alert1 = Ocean.Alert.info { alert in
        alert.title = "Informational title"
        alert.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    lazy var alert2 = Ocean.Alert.warning { alert in
        alert.title = "Warning title"
        alert.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    lazy var alert3 = Ocean.Alert.error { alert in
        alert.title = "Error title"
        alert.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        alert.textType = .longText
    }
    
    lazy var alert4 = Ocean.Alert.success { alert in
        alert.title = "Sucess title!"
        alert.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        alert.textType = .longText
    }
    
    lazy var alert5 = Ocean.Alert.info { alert in
        alert.text = "This is an informational message."
    }
    
    lazy var alert6 = Ocean.Alert.warning { alert in
        alert.text = "This is a warning message."
    }
    
    lazy var alert7 = Ocean.Alert.error { alert in
        alert.text = "This is an error message."
    }
    
    lazy var alert8 = Ocean.Alert.success { alert in
        alert.text = "This is a success message."
    }
    
    lazy var contentStack: Ocean.StackView = {
        let contentStack = Ocean.StackView()
        contentStack.axis = .vertical
        contentStack.spacing = Ocean.size.spacingStackXxs
        contentStack.distribution = .fill
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentStack.addArrangedSubview(alert1)
        contentStack.addArrangedSubview(alert2)
        contentStack.addArrangedSubview(alert3)
        contentStack.addArrangedSubview(alert4)
        contentStack.addArrangedSubview(alert5)
        contentStack.addArrangedSubview(alert6)
        contentStack.addArrangedSubview(alert7)
        contentStack.addArrangedSubview(alert8)

        return contentStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alert1.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert2.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert3.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert4.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert5.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert6.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert7.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            alert8.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
        ])
    }
}
