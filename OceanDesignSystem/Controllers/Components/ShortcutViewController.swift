//
//  ShortcutViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 23/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ShortcutViewController : UIViewController {
    lazy var shortcut1: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var shortcut2: Ocean.Shortcut = {
        let view = Ocean.Shortcut()
        view.size = .medium
        view.direction = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(shortcut1)
        stack.addArrangedSubview(shortcut2)
        
        shortcut1.onTouch = { index in
            print(index)
        }
        
        self.add(view: stack)

        NSLayoutConstraint.activate([
            shortcut1.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        shortcut1.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 3, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 9, badgeStatus: .highlight, title: "Label")
        ])
        shortcut2.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label", subtitle: "Label subtitle"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label", subtitle: "Label subtitle"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 3, title: "Label", subtitle: "Label subtitle"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, badgeNumber: 0, badgeStatus: .neutral, title: "Label", subtitle: "Label subtitle")
        ], quantityPage: 2)
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Ocean.size.spacingStackXs),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Ocean.size.spacingStackXs)
        ])
    }
}
