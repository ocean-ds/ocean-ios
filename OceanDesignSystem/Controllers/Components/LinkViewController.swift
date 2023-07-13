//
//  LinkViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 13/07/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class LinkViewController: UIViewController {
    
    lazy var mediumChevronLink: Ocean.Link = {
        let link = Ocean.Link()
        link.title = "link medium type chevron"
        link.size = .medium
        link.iconType = .chevron
        link.onTouch = { print("link onTouch") }
 
        return link
    }()
    
    lazy var mediumExternalLink: Ocean.Link = {
        let link = Ocean.Link()
        link.title = "link medium type external"
        link.size = .medium
        link.iconType = .external
        link.onTouch = { print("link onTouch") }
 
        return link
    }()
    
    lazy var smallWithoutIconLink: Ocean.Link = {
        let link = Ocean.Link()
        link.title = "link small without icon"
        link.size = .small
        link.iconType = .none
        link.onTouch = { print("link onTouch") }
 
        return link
    }()
    
    lazy var textWithHtmlLink: Ocean.Link = {
        let link = Ocean.Link()
        link.attributedTitle = "<u>text With Html Link</u>".htmlToAttributedText(
            size: Ocean.font.fontSizeXxxs,
            color: Ocean.color.colorInterfaceDarkDown
        )
        link.onTouch = { print("link onTouch") }
 
        return link
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 16
        
        stack.add([
            mediumChevronLink,
            mediumExternalLink,
            smallWithoutIconLink,
            textWithHtmlLink
        ])
        
        return stack
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainStack.oceanConstraints
            .centerY(to: view)
            .centerX(to: view)
            .make()
    }
}
