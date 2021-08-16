//
//  BottomNavigationBarViewController.swift
//  OceanDesignSystem
//
//  Created by Vini on 16/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class BottomNavigationBarViewController : UITabBarController, OceanBottomNavigationBar {
    let vc1 = UIViewController()
    let vc2 = UIViewController()
    let vc3 = UIViewController()
    let vc4 = UIViewController()
    let vc5 = UIViewController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomNavigation()
        self.view.backgroundColor = .white
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vc1.tabBarItem = UITabBarItem(title: "Label", image: Ocean.icon.documentOutline, selectedImage: nil)
        vc2.tabBarItem = UITabBarItem(title: "Label", image: Ocean.icon.documentOutline, selectedImage: nil)
        vc3.tabBarItem = UITabBarItem(title: "Label", image: Ocean.icon.documentOutline, selectedImage: nil)
        vc4.tabBarItem = UITabBarItem(title: "Label", image: Ocean.icon.documentOutline, selectedImage: nil)
        vc5.tabBarItem = UITabBarItem(title: "Label", image: Ocean.icon.documentOutline, selectedImage: nil)
        
        self.viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
}
