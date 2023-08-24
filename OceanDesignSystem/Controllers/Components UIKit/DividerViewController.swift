//
//  DividerViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 25/06/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class DividerViewController : UIViewController {
    
    lazy var dividerVertical: Ocean.Divider = {
        let divider = Ocean.Divider(height: 16, axis: .vertical)
 
        return divider
    }()
    
    lazy var dividerHorizontal: Ocean.Divider = {
        let divider = Ocean.Divider()
 
        return divider
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXs
        
        stack.addArrangedSubview(Ocean.Divider())
        stack.addArrangedSubview(dividerVertical)
        
        self.add(view: stack)
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
