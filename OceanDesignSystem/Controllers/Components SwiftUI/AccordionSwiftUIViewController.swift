//
//  AccordionSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 21/12/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import OceanComponents
import SwiftUI

class AccordionSwiftUIViewController: UIViewController {
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

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            self.accordion
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}
