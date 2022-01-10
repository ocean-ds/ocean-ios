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
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
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
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
        }
        
        let textList4 = Ocean.TextList.cell { textList in
            textList.title = "Title"
        }
        
        let textList5 = Ocean.TextList.cellInverseHighlight { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
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
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
        }
        
        let textList8 = Ocean.TextList.cellInverseHighlight { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
        }

        let textList9 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subitle"
            textList.text = "Text"
            textList.setupButtonLink(id: "1", title: "Botão") { itemId in
                print(itemId)
            }
        }

        [textList1,
         textList2,
         textList3,
         textList4,
         textList5,
         textList6,
         textList7,
         textList8,
         textList9].forEach { textListCell in
            stack.addArrangedSubview(textListCell)
        }
        
        self.add(view: stack)

        [textList1,
         textList2,
         textList3,
         textList4,
         textList5,
         textList6,
         textList7,
         textList8,
         textList9].forEach { textListCell in
            textListCell.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
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
