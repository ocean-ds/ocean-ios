//
//  AccordionViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 12/07/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

class AccordionViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    lazy var scrollableContentView: UIView = { UIView(frame: .zero) }()
    
    var titleAccordion = "What is Lorem Ipsum What is Lorem Ipsum What is Lorem Ipsum What is Lorem Ipsum?"
    var contentAccordion = """
    Lorem Ipsum is simply dummy text of <b>the printing</b> and typesetting industry. <br><br>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make
    """.htmlToAttributedText(size: Ocean.font.fontSizeXxxs,
                             color: Ocean.color.colorInterfaceDarkDown)
    
    private lazy var accordion = Ocean.Accordion(
        model: .init(
            title: titleAccordion,
            contentAttributedString: contentAccordion
        )
    )
    
    private lazy var accordion2 = Ocean.Accordion(
        model: .init(
            title: titleAccordion,
            contentAttributedString: contentAccordion,
            status: .expanded
        )
    )
    
    private lazy var accordion3 = Ocean.Accordion(
        model: .init(
            title: "Title",
            content: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
        )
    )
    
    private lazy var accordion4 = Ocean.Accordion(
        model: .init(
            title: titleAccordion,
            contentAttributedString: contentAccordion
        )
    )
    
    private lazy var accordion5 = Ocean.Accordion(
        model: .init(
            title: titleAccordion,
            contentAttributedString: contentAccordion,
            hasDivider: false
        )
    )
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        
        stack.add([accordion,
                   accordion2,
                   accordion3,
                   accordion4,
                   accordion5])
        
        stack.setMargins(horizontal: Ocean.size.spacingStackXs)
        
        return stack
    }()
    
    
    public override func viewDidLoad() {
        self.addScrollView()
        self.view.backgroundColor = .white

        scrollableContentView.addSubview(mainStack)
        mainStack.oceanConstraints
            .fill(to: scrollableContentView)
            .make()
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
}
