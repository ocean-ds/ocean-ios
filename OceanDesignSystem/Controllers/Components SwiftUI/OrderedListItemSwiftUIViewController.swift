//
//  OrderedListItemSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 29/11/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import SwiftUI

class OrderedListItemSwiftUIViewController: UIViewController {
    lazy var item1: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.orderedDefault { item in
            item.parameters.number = 1
            item.parameters.title = "This is Title"
            item.parameters.text = "<b>Lorem</b> ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in."
        }
    }()
    
    lazy var item2: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.orderedDefault { item in
            item.parameters.number = 2
            item.parameters.text = "Lorem ipsum dolor sit amet."
        }
    }()
    
    lazy var item3: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.orderedNegative { item in
            item.parameters.number = 3
            item.parameters.text = "Velit amet <i>Lorem</i> sem tempus volutpat nulla posuere consectetur ac in."
        }
    }()
    
    lazy var item4: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.unorderedDefault { item in
            item.parameters.text = "Lorem ipsum **Lorem** dolor <br>sit amet, consectetur adipiscing elit."
        }
    }()
    
    lazy var item5: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.unorderedDefault { item in
            item.parameters.text = "Velit amet sem **Lorem** tempus volutpat nulla posuere consectetur ac in."
        }
    }()
    
    lazy var item6: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.unorderedNegative { item in
            item.parameters.title = "This is Title"
            item.parameters.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in."
        }
    }()
    
    private lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs

        stack.add([
            item1.uiView,
            item2.uiView,
            item3.uiView,
            item4.uiView,
            item5.uiView,
            item6.uiView
        ])

        stack.setMargins(allMargins: Ocean.size.spacingStackXs)

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
            .topToTop(to: self.view)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }
}
