//
//  TagViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 03/09/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TagViewController : UIViewController {
    let tag1 = Ocean.Tag { view in
        view.title = "Label"
        view.status = .neutral1
    }
    
    let tag2 = Ocean.Tag { view in
        view.title = "Label"
        view.status = .neutral2
    }
    
    let tag3 = Ocean.Tag { view in
        view.title = "Label"
        view.status = .positive
    }
    
    let tag4 = Ocean.Tag { view in
        view.title = "Label"
        view.status = .warning
    }
    
    let tag5 = Ocean.Tag { view in
        view.title = "Label"
        view.status = .negative
    }
    
    let tag6 = Ocean.Tag { view in
        view.title = "Label"
        view.image = Ocean.icon.mapSolid
        view.status = .neutral1
    }
    
    let tag7 = Ocean.Tag { view in
        view.title = "Label"
        view.image = Ocean.icon.tagSolid
        view.status = .neutral2
    }
    
    let tag8 = Ocean.Tag { view in
        view.title = "Label"
        view.image = Ocean.icon.checkCircleSolid
        view.status = .positive
    }
    
    let tag9 = Ocean.Tag { view in
        view.title = "Label"
        view.image = Ocean.icon.exclamationCircleSolid
        view.status = .warning
    }
    
    let tag10 = Ocean.Tag { view in
        view.title = "Label"
        view.image = Ocean.icon.xCircleSolid
        view.status = .negative
    }
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack1 = UIStackView()
        stack1.distribution = .fill
        stack1.axis = .vertical
        stack1.spacing = Ocean.size.spacingStackXs
        stack1.translatesAutoresizingMaskIntoConstraints = false
        
        stack1.addArrangedSubview(tag1)
        stack1.addArrangedSubview(tag2)
        stack1.addArrangedSubview(tag3)
        stack1.addArrangedSubview(tag4)
        stack1.addArrangedSubview(tag5)
        
        self.view.addSubview(stack1)
        
        let stack2 = UIStackView()
        stack2.distribution = .fill
        stack2.axis = .vertical
        stack2.spacing = Ocean.size.spacingStackXs
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        stack2.addArrangedSubview(tag6)
        stack2.addArrangedSubview(tag7)
        stack2.addArrangedSubview(tag8)
        stack2.addArrangedSubview(tag9)
        stack2.addArrangedSubview(tag10)
        
        self.view.addSubview(stack2)
        
        NSLayoutConstraint.activate([
            stack1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Ocean.size.spacingStackMd),
            stack1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stack2.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: Ocean.size.spacingStackXs),
            stack2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
