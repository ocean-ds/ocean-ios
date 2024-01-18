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
    
    lazy var item7: OceanSwiftUI.OrderedListItem = {
        return OceanSwiftUI.OrderedListItem.unorderedDefault() { item in
            item.parameters.title = "This is Title"
            item.parameters.icon = Ocean.icon.placeholderSolid
            item.parameters.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Velit amet sem tempus volutpat nulla posuere consectetur ac in."
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack(spacing: Ocean.size.spacingStackXs) {
            item1
            item2
            item3
            item4
            item5
            item6
            item7
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

@available(iOS 13.0, *)
struct OrderedListItemSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            OrderedListItemSwiftUIViewController()
        }
    }
}
