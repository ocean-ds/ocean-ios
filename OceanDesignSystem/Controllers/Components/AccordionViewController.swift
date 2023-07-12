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
    
    private lazy var accordion: Ocean.Accordion = {
        let item = Ocean.Accordion()
        item.itemModel = .init(title: "What is Lorem Ipsum?", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make")
        
        return item
    }()
    
    private lazy var accordion2: Ocean.Accordion = {
        let item = Ocean.Accordion()
        item.itemModel = .init(title: "What is Lorem Ipsum?", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make", hasDivider: false)
        
        return item
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        
        stack.add([accordion, accordion2])
        
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
