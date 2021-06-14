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
    
    var hasTopNotch: Bool {
        if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        } else {
            if #available(iOS 11.0, *) {
                return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            } else {
                return false
            }
        }
    }
}
