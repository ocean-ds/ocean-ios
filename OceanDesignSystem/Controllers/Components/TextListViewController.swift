//
//  TextListViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 09/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TextListViewController : UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 0
        
        let textList1 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.text = "text"
            textList.image = Ocean.icon.documentOutline
            textList.arrow = true
            textList.badge = true
        }
        
        let textList2 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.arrow = true
        }
        
        let textList3 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.image = Ocean.icon.documentOutline
        }
        
        let textList4 = Ocean.TextList.cell { textList in
            textList.title = "Title"
        }
        
        let textList5 = Ocean.TextList.cellInverseHighlight { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.image = Ocean.icon.documentOutline
            textList.arrow = true
        }
        
        let textList6 = Ocean.TextList.cellInverse { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.arrow = true
        }
        
        let textList7 = Ocean.TextList.cellInverse { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.image = Ocean.icon.documentOutline
        }
        
        let textList8 = Ocean.TextList.cellInverseHighlight { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
        }
        
        stack.addArrangedSubview(textList1)
        stack.addArrangedSubview(textList2)
        stack.addArrangedSubview(textList3)
        stack.addArrangedSubview(textList4)
        stack.addArrangedSubview(textList5)
        stack.addArrangedSubview(textList6)
        stack.addArrangedSubview(textList7)
        stack.addArrangedSubview(textList8)
        
        self.add(view: stack)
        
        textList1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList2.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList3.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList4.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList5.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList6.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList7.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textList8.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
