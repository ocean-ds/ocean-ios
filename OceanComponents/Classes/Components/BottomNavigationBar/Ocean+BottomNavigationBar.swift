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
        setup()

        object_setClass(self.tabBar, OceanTabBar.self)
    }

    private func setup() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = bottomNavigationBackgroundColor
        
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        setTabBarItemColors(appearance.inlineLayoutAppearance)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance)
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.titlePositionAdjustment = .init(horizontal: 0, vertical: -6)
        itemAppearance.normal.iconColor = bottomNavigationUnselectedColor
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationUnselectedColor
        ]
        
        itemAppearance.focused.titlePositionAdjustment = .init(horizontal: 0, vertical: -6)
        itemAppearance.focused.iconColor = bottomNavigationSelectedColor
        itemAppearance.focused.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationSelectedColor
        ]
        
        itemAppearance.selected.titlePositionAdjustment = .init(horizontal: 0, vertical: -6)
        itemAppearance.selected.iconColor = bottomNavigationSelectedColor
        itemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.highlightExtraBold(size: Ocean.font.fontSizeXxxs)!,
            NSAttributedString.Key.foregroundColor: bottomNavigationSelectedColor
        ]
    }
}

class OceanTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        let newHeight = sizeThatFits.height + 7
        sizeThatFits.height = newHeight
        return sizeThatFits
    }
}
