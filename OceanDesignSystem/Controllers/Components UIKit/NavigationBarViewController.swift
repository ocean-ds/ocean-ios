//
//  NavigationBarViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 22/07/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class NavigationBarViewController : UIViewController, OceanNavigationBar {
    public var navigationTitle: String = "NavigationBar"
    public var navigationBackgroundColor: UIColor? = Ocean.color.colorBrandPrimaryPure
    public var navigationTintColor: UIColor = Ocean.color.colorInterfaceLightPure
    public var navigationLargeTitle: Bool = false
    
    public override func viewDidLoad() {
        setupNavigation()
        showNavigation()
        addCloseButton(action: #selector(closeClick))
        addOptionsButton(options: [OceanNavigationBarOption(title: "Item 1", image: Ocean.icon.documentTextOutline, action: {
            print("Item 1")
        }),
        OceanNavigationBarOption(title: "Item 2", image: Ocean.icon.xCircleOutline, isDestructive: true, action: {
            print("Item 2")
        })])
        self.view.backgroundColor = .white
        
        let stack = Ocean.StackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = Ocean.size.spacingStackXxs
        
        stack.addArrangedSubview(Ocean.Button.primaryMD { button in
            button.text = "Primary"
            button.onTouch = {
                self.navigationBackgroundColor = Ocean.color.colorBrandPrimaryPure
                self.navigationTintColor = Ocean.color.colorInterfaceLightPure
                self.navigationLargeTitle = false
                self.setupNavigation()
            }
        })
        stack.addArrangedSubview(Ocean.Button.secondaryMD { button in
            button.text = "Secondary"
            button.onTouch = {
                self.navigationBackgroundColor = Ocean.color.colorInterfaceLightPure
                self.navigationTintColor = Ocean.color.colorBrandPrimaryPure
                self.navigationLargeTitle = false
                self.setupNavigation()
            }
        })
        stack.addArrangedSubview(Ocean.Button.primaryMD { button in
            button.text = "Primary Large"
            button.onTouch = {
                self.navigationBackgroundColor = Ocean.color.colorBrandPrimaryPure
                self.navigationTintColor = Ocean.color.colorInterfaceLightPure
                self.navigationLargeTitle = true
                self.setupNavigation()
            }
        })
        stack.addArrangedSubview(Ocean.Button.secondaryMD { button in
            button.text = "Secondary Large"
            button.onTouch = {
                self.navigationBackgroundColor = Ocean.color.colorInterfaceLightPure
                self.navigationTintColor = Ocean.color.colorBrandPrimaryPure
                self.navigationLargeTitle = true
                self.setupNavigation()
            }
        })
        
        self.add(view: stack)
    }
    
    @objc func closeClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
