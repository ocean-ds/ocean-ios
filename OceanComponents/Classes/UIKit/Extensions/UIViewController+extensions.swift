//
//  UIViewController+extensions.swift
//  OceanComponents
//
//  Created by Alex Gomes on 17/08/20.
//

import Foundation
extension UIViewController {

    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
