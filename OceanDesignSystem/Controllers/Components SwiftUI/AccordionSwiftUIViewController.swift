//
//  AccordionSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 21/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

class AccordionSwiftUIViewController: UIViewController {

    lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    lazy var scrollableContentView: UIView = { UIView(frame: .zero) }()

    lazy var titleAccordion = "What is Lorem Ipsum What is Lorem Ipsum What is Lorem Ipsum What is Lorem Ipsum?"
    lazy var contentAccordion = """
    Lorem Ipsum is simply dummy text of <b>the printing</b> and typesetting industry. <br><br>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make
    """

    lazy var accordion: OceanSwiftUI.Accordion = {
        OceanSwiftUI.Accordion { accordion in
            accordion.parameters.items = [
                .init(title: self.titleAccordion, text: self.contentAccordion),
                .init(title: self.titleAccordion, text: self.contentAccordion, status: .expanded),
                .init(title: self.titleAccordion, text: self.contentAccordion, hasDivider: false)
            ]
            accordion.parameters.onUpdateUI = {
                self.accordion.uiView.updateUIView()
            }
        }
    }()

    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill

        stack.add([
            accordion.uiView
        ])

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
