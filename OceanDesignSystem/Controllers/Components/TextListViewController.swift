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

    lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    lazy var scrollableContentView: UIView = { UIView(frame: .zero) }()

    public override func viewDidLoad() {
        self.addScrollView()
        self.scrollableContentView.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
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
            textList.locked = true
        }
        
        let textList8 = Ocean.TextList.cellInverseHighlight { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.arrow = true
            textList.arrowTintColor = Ocean.color.colorInterfaceDarkUp
        }

        let textList9 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subitle"
            textList.text = "Text"
            textList.buttonTitle = "Botão"
            textList.onTouchButton = self.triggerButton
        }

        let textList10 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subitle"
            textList.tagImage = Ocean.icon.exclamationCircleSolid
            textList.tagTitle = "Tag sample"
            textList.arrow = true
            textList.arrowTintColor = Ocean.color.colorInterfaceDarkUp
        }

        let textList11 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subitle"
            textList.tagTitle = "Tag sample"
            textList.tagStatus = .positive
            textList.arrow = true
            textList.arrowTintColor = Ocean.color.colorInterfaceDarkUp
        }

        scrollableContentView.addSubview(stack)
        stack.setConstraints((.fillSuperView, toView: scrollableContentView))

        [textList1,
         textList2,
         textList3,
         textList4,
         textList5,
         textList6,
         textList7,
         textList8,
         textList9,
         textList10,
         textList11].forEach { textListCell in
            stack.addArrangedSubview(textListCell)
            textListCell.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }
    }

    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollableContentView)

        applyScrollViewDefaultContraints()
    }

    private func applyScrollViewDefaultContraints() {
        scrollView.setConstraints((.fillSuperView, toView: view))
        scrollableContentView.setConstraints(([.fillSuperView,
                                               .centerHorizontally], toView: scrollView),
                                             ([.fullWidth], toView: view))
    }

    private func triggerButton() {
        print("button tapped")
    }
}
