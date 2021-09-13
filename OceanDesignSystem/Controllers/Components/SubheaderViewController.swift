//
//  SubheaderViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 13/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class SubheaderViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = Ocean.size.spacingStackXs
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let sb1 = Ocean.Subheader { view in
            view.image = Ocean.icon.annotationSolid
            view.title = "Title"
            view.subtitle = "Subtitle"
        }
        let sb2 = Ocean.Subheader { view in
            view.title = "Title"
            view.subtitle = "Subtitle"
        }
        let sb3 = Ocean.Subheader { view in
            view.title = "Title"
            view.size = .small
        }
        
        stack.addArrangedSubview(sb1)
        stack.addArrangedSubview(sb2)
        stack.addArrangedSubview(sb3)
        
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            sb1.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            sb2.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            sb3.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
