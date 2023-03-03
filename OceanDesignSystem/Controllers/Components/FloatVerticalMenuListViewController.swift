//
//  FloatVerticalMenuListViewController.swift
//  OceanDesignSystem
//
//  Created by Leticia Fernandes on 17/03/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class FloatVerticalMenuListViewController: UIViewController, OceanNavigationBar {
    
    private lazy var navBarMenu: Ocean.FloatVerticalMenuList = {
        Ocean.FloatVerticalMenu.list { menu in
            menu.isHidden = false
            menu.navigationItem = self.navigationItem
            menu.options = [OceanNavigationBarOption(title: "Item Menu 1",
                                                     image: Ocean.icon.annotationSolid,
                                                     action: self.actionItemMenu1),
                            OceanNavigationBarOption(title: "Item Menu 2",
                                                     image: Ocean.icon.bookmarkSolid,
                                                     action: self.actionItemMenu2)]
            menu.onTouch = { option in
                option.action()
            }
        }
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = Ocean.color.colorStatusPositiveUp
        self.navigationController?.navigationBar.isHidden = false
        self.setupNavBar()
    }

    private func setupNavBar() {
        self.view.addSubview(navBarMenu)

        self.navBarMenu.oceanConstraints
            .fill(to: self.view)
    }
    
    @objc func actionItemMenu1() {
        print("On touch itemMenu1")
    }
    
    @objc func actionItemMenu2() {
        self.navigationController?.popViewController(animated: true)
    }
}
