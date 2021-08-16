//
//  Ocean+BottomNavigationBar.swift
//  OceanComponents
//
//  Created by Vini on 16/08/21.
//

import OceanTokens
import UIKit

public protocol OceanBottomNavigationBar: UITabBarController {
    var bottomNavigationBackgroundColor: UIColor { get }
    var bottomNavigationSelectedColor: UIColor { get }
    var bottomNavigationUnselectedColor: UIColor { get }
}

public extension OceanBottomNavigationBar {
    var bottomNavigationBackgroundColor: UIColor {
        return Ocean.color.colorBrandPrimaryPure
    }
    
    var bottomNavigationSelectedColor: UIColor {
        return Ocean.color.colorInterfaceLightPure
    }
    
    var bottomNavigationUnselectedColor: UIColor {
        return Ocean.color.colorBrandPrimaryUp
    }
    
    func setupBottomNavigation() {
        if #available(iOS 13.0, *) {
            setupNew()
        } else {
            setupOld()
        }
    }
    
    private func setupOld() {
        UITabBar.appearance().backgroundColor = bottomNavigationBackgroundColor
        UITabBar.appearance().isTranslucent = false
        
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = bottomNavigationSelectedColor
        tabBar.unselectedItemTintColor = bottomNavigationUnselectedColor
    }
    
    @available(iOS 13.0, *)
    private func setupNew() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = bottomNavigationBackgroundColor
        
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.inlineLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
        
        tabBar.standardAppearance = appearance
    }
    
    @available(iOS 13.0, *)
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = bottomNavigationUnselectedColor
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationUnselectedColor
        ]
        
        itemAppearance.focused.iconColor = bottomNavigationSelectedColor
        itemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationSelectedColor
        ]
        
        itemAppearance.selected.iconColor = bottomNavigationSelectedColor
        itemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationSelectedColor
        ]
    }
}
