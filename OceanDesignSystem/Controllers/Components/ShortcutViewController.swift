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
    let shortcut1 = Ocean.Shortcut()
    
    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0
        
        stack.addArrangedSubview(shortcut1)
        
        shortcut1.onTouch = { index in
            print(index)
        }
        
        self.add(view: stack)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        shortcut1.addData(with: [
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label"),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label", isHighlight: true),
            Ocean.ShortcutModel(image: Ocean.icon.documentOutline!, title: "Label", isHighlight: true)
        ])
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            shortcut1.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
