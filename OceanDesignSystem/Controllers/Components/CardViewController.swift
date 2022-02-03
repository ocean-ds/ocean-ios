//
//  CardViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 07/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class CardViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorInterfaceLightUp
        
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(Ocean.Card { view in
            view.view = Ocean.Spacer(space: Ocean.size.spacingStackXxxl)
        })
        stack.addArrangedSubview(Ocean.Card { view in
            view.view = Ocean.Spacer(space: Ocean.size.spacingStackXxxl)
            view.withShadow = true
        })
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
