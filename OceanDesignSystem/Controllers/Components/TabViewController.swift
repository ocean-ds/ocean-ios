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
            tab.items = [OceanTabItem(title: "Item 1", badgeNumber: 3),
                         OceanTabItem(title: "Item 2", badgeNumber: 12),
                         OceanTabItem(title: "Item 3", badgeNumber: 2)]

            tab.onTouch = { selectedIndex in
                print(selectedIndex)
            }
        }
    }()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(self.tabView)
        self.tabView.setConstraints(([.topToTop(0),
                                      .horizontalMargin(.zero),
                                      .height(58)],
                                     toView: self.view))
    }

}
