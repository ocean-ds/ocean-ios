//
//  Ocean+BottomNavigationBar.swift
//  OceanComponents
//
//  Created by Vini on 16/08/21.
//

import OceanTokens
import UIKit

open class OceanBottomNavigationBar: UITabBarController {
    var bottomNavigationBackgroundColor: UIColor {
        return Ocean.color.colorBrandPrimaryPure
    }

    var bottomNavigationSelectedColor: UIColor {
        return Ocean.color.colorInterfaceLightPure
    }

    var bottomNavigationUnselectedColor: UIColor {
        return Ocean.color.colorBrandPrimaryUp
    }

    private lazy var movingBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)
        view.ocean.radius.applyMd()
        return view
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavigation()
    }

    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item) {
            let controlViews = self.tabBar.subviews.compactMap { $0 as? UIControl }
            if index < controlViews.count {
                let itemView = controlViews[controlViews.index(controlViews.startIndex, offsetBy: index)]
                moveBackgroundView(to: itemView)
            }
        }
    }

    public func moveAnimationFirstItem() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let controlViews = self.tabBar.subviews.compactMap { $0 as? UIControl }
            if let firstItemView = controlViews.first {
                self.moveBackgroundView(to: firstItemView, animated: false)
            }
        }
    }

    private func setupBottomNavigation() {
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

        tabBar.insertSubview(movingBackgroundView, at: 0)
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

    private func moveBackgroundView(to view: UIView, animated: Bool = true) {
        if !animated {
            self.moveBackgroundFrame(to: view)
            return
        }

        UIView.animate(withDuration: 0.3) {
            self.moveBackgroundFrame(to: view)
        }
    }

    private func moveBackgroundFrame(to view: UIView) {
        self.movingBackgroundView.frame = view.frame.insetBy(dx: 1, dy: 1)
    }
}

public class OceanTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        let newHeight = sizeThatFits.height + 15
        sizeThatFits.height = newHeight
        return sizeThatFits
    }
}
