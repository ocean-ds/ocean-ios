//
//  Ocean+NavigationBar.swift
//  Blu
//
//  Created by Pedro Azevedo on 27/02/21.
//  Copyright © 2021 Blu. All rights reserved.
//

import OceanTokens
import UIKit

public protocol OceanNavigationBar: UIViewController {
    var navigationBackImage: UIImage? { get }
    var navigationTitle: String? { get }
    var navigationTintColor: UIColor { get }
    var navigationBackButtonTitle: String { get }
    var navigationBackgroundColor: UIColor? { get }
    var navigationShadow: Bool { get }
}

public extension OceanNavigationBar {
    public var navigationBackImage: UIImage? {
        return self.navigationController?.navigationBar.backIndicatorImage
    }
    
    public var navigationTitle: String? {
        return self.navigationController?.navigationItem.title
    }
    
    public var navigationTintColor: UIColor {
        return Ocean.color.colorBrandPrimaryPure
    }
    
    public var navigationBackButtonTitle: String {
        return ""
    }
    
    public var navigationBackgroundColor: UIColor? {
        return nil
    }
    
    public var navigationShadow: Bool {
        return false
    }
    
    public func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = navigationTintColor
        navigationController?.navigationBar.shadowImage = navigationShadow ? Ocean.icon.divider : UIImage()

        navigationController?.title = navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: navigationTintColor,
            NSAttributedString.Key.font: UIFont.init(name: Ocean.font.fontFamilyHighlightWeightExtraBold,
                                                     size: Ocean.font.fontSizeSm)!
        ]
        
        if navigationBackgroundColor != nil {
            navigationController?.navigationBar.backgroundColor = navigationBackgroundColor
            navigationController?.navigationBar.barTintColor = navigationBackgroundColor
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        navigationController?.navigationBar.backIndicatorImage = navigationBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = navigationBackImage
        navigationController?.navigationBar.backItem?.title = navigationBackButtonTitle
        
        title = navigationTitle
        
        navigationItem.title = navigationTitle
        if #available(iOS 11.0, *) {
            navigationItem.backButtonTitle = navigationBackButtonTitle
        }
    }
    
    public func addCloseButton(action: Selector?) {
        let image = Ocean.icon.xOutline?.tinted(with: navigationTintColor)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self, action: action)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

