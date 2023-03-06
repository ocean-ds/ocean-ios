//
//  TabViewController.swift
//  OceanDesignSystem
//
//  Created by Leticia Fernandes on 25/03/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class TabViewController: UIViewController, OceanNavigationBar {

    private lazy var tabView: Ocean.Tab = {
        Ocean.Tab { tab in
            tab.items = [OceanTabItem(title: "Item", badgeNumber: 3),
                         OceanTabItem(title: "Item"),
                         OceanTabItem(title: "Item", badgeNumber: 2, status: .alert)]

            tab.onTouch = { selectedIndex in
                print(selectedIndex)
            }
        }
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(self.tabView)

        self.tabView.oceanConstraints
            .topToTop(to: self.view)
            .leadingToLeading(to: self.view)
            .trailingToTrailing(to: self.view)
            .make()
    }
}
