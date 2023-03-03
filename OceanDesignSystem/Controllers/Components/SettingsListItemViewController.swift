//
//  SettingsListItemViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 31/01/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class SettingsListItemViewController: UIViewController {
    lazy var settingListItem1: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.actionText = "Label"
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var settingListItem2: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.type = .pending
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.actionText = "Label"
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var settingListItem3: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.type = .activated
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.caption = "Caption"
        item.actionText = "Label"
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var settingListItem4: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.type = .blockedActivate
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.caption = "Caption"
        item.actionText = "Label"
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var settingListItem5: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.type = .blocked
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.caption = "Caption"
        item.actionText = "Label"
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var settingListItem6: Ocean.SettingsListItem = {
        let item = Ocean.SettingsListItem()
        item.type = .blocked
        item.title = "Title"
        item.subtitle = "Subtitle"
        item.hasDivider = false
        item.onTouchButton = { self.onClick() }
       
        return item
    }()
    
    lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        [settingListItem1,
         settingListItem2,
         settingListItem3,
         settingListItem4,
         settingListItem5,
         settingListItem6].forEach{ card in
            stack.addArrangedSubview(card)
        }
        
        return stack
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(mainStack)

        mainStack.oceanConstraints
            .topToTop(to: self.view, constant: 16)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }
    
    private func onClick() -> Void {
        print("click!")
    }
}
