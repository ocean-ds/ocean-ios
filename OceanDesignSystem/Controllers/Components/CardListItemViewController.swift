//
//  CardListItemViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 18/10/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class CardListItemViewController: UIViewController {
    lazy var card1 = Ocean.CardListItem { card in
        card.title = "Title"
        card.subtitle = "Subtitle"
        card.caption = "Caption"
        card.onTouch = { print("card1") }
    }
    
    lazy var card2 = Ocean.CardListItem { card in
        card.title = "Title"
        card.subtitle = "Subtitle"
        card.onTouch = { print("card2") }
    }
    
    lazy var card3 = Ocean.CardListItem { card in
        card.title = "Title"
        card.caption = "Caption"
        card.onTouch = { print("card3") }
    }
    
    lazy var card4 = Ocean.CardListItem { card in
        card.title = "Title"
        card.subtitle = "Subtitle"
        card.caption = "Caption"
        card.leadingIcon = Ocean.icon.archiveOutline
        card.onTouch = { print("card4") }
    }
    
    lazy var card5 = Ocean.CardListItem { card in
        card.title = "Title"
        card.subtitle = "Subtitle"
        card.caption = "Caption"
        card.leadingIcon = Ocean.icon.archiveOutline
        card.trailingIcon = Ocean.icon.chevronRightSolid
        card.onTouch = { print("card5") }
    }
    
    lazy var card6 = Ocean.CardListItem { card in
        card.title = "Title"
        card.subtitle = "Subtitle"
        card.leadingIcon = Ocean.icon.archiveOutline
        card.trailingIcon = Ocean.icon.chevronRightSolid
        card.onTouch = { print("card5") }
    }
    
    lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        stack.setMargins(horizontal: Ocean.size.spacingInsetSm)
        
        [card1, card2, card3, card4, card5, card6].forEach{ card in
            stack.addArrangedSubview(card)
        }
        
        return stack
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.add(view: mainStack)
    }
}
