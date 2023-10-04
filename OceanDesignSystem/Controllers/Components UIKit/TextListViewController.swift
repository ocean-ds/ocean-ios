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
            textList.text = "text"
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
            textList.arrow = true
            textList.badge = true
            textList.onTouch = {
                textList.hasCheckbox = !textList.hasCheckbox
            }
        }
        
        let textList2 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitle = "Subtitle"
            textList.arrow = true
        }
        
        let textList3 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
            textList.swipe = true
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
            textList.tooltipMessage = "toolptip message"
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
            textList.buttonTitle = "Button"
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
            textList.tagImageStatus = true
            textList.arrow = true
            textList.arrowTintColor = Ocean.color.colorInterfaceDarkUp
        }

        let textList12 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "R$ 40,00",
                                               newValue: "Zero",
                                               color: Ocean.color.colorStatusPositiveDeep)
        }

        let textList13 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "R$ 1.000,00",
                                               bold: true)
        }

        let textList14 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "R$ 1.000,00")
        }

        let textList15 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "R$ 4,00",
                                               imageIcon: Ocean.icon.giftSolid,
                                               color: Ocean.color.colorStatusPositiveDeep)
        }

        let textList16 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "Calculada no dia",
                                               color: Ocean.color.colorStatusNeutralDeep)
        }

        let textList17 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.subtitleTextLabel = .init(value: "Calculada no dia",
                                               imageIcon: Ocean.icon.exclamationCircleSolid,
                                               color: Ocean.color.colorStatusNeutralDeep)
        }
        
        let textList18 = Ocean.TextList.cell { textList in
            textList.title = "Title"
            textList.textTextLabel = Ocean.TextLabelModel(value: "Text", bold: true, color: Ocean.color.colorStatusPositiveDeep)
            textList.image = Ocean.icon.documentOutline?.withRenderingMode(.alwaysTemplate)
            textList.arrow = true
            textList.badge = true
        }

        scrollableContentView.addSubview(stack)
        stack.oceanConstraints
            .fill(to: scrollableContentView)
            .make()

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
         textList11,
         textList12,
         textList13,
         textList14,
         textList15,
         textList16,
         textList17,
         textList18].forEach { textListCell in
            stack.addArrangedSubview(textListCell)
            textListCell.oceanConstraints
                .width(to: self.view)
                .make()
        }
    }

    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollableContentView)

        applyScrollViewDefaultContraints()
    }

    private func applyScrollViewDefaultContraints() {
        scrollView.oceanConstraints
            .fill(to: view)
            .make()
        
        scrollableContentView.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }

    private func triggerButton() {
        print("button tapped")
    }
}
