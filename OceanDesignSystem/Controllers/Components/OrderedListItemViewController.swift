//
//  OrderedListItemViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 06/12/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class OrderedListItemViewController : UIViewController {
    let component1 = Ocean.ListItem.ordered { view in
        view.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in."
        view.number = 1
    }

    let component2 = Ocean.ListItem.ordered { view in
        view.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in. Lorem ipsum dolor sit amet"
        view.number = 2
    }

    let component3 = Ocean.ListItem.ordered { view in
        view.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet"
        view.number = 3
    }

    let component4 = Ocean.ListItem.ordered { view in
        view.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        view.number = 4
    }

    let component5 = Ocean.ListItem.ordered { view in
        view.title = "Lorem ipsum dolor sit amet."
        view.number = 5
    }

    let component6 = Ocean.ListItem.unordered { view in
        view.title = "Lorem ipsum dolor sit amet."
    }

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let stack1 = Ocean.StackView()
        stack1.distribution = .fill
        stack1.axis = .vertical
        stack1.spacing = Ocean.size.spacingStackXs
        stack1.translatesAutoresizingMaskIntoConstraints = false

        stack1.addArrangedSubview(component1)
        stack1.addArrangedSubview(component2)
        stack1.addArrangedSubview(component3)
        stack1.addArrangedSubview(component4)
        stack1.addArrangedSubview(component5)
        stack1.addArrangedSubview(component6)

        self.view.addSubview(stack1)

        NSLayoutConstraint.activate([
            stack1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Ocean.size.spacingStackMd),
            stack1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Ocean.size.spacingStackXs),
            stack1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Ocean.size.spacingStackXs),
        ])
    }
}
