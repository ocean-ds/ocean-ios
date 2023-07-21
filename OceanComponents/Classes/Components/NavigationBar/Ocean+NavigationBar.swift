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
    var navigationTitle: String { get }
    var navigationTintColor: UIColor { get }
    var navigationBackButtonTitle: String { get }
    var navigationBackgroundColor: UIColor? { get }
    var navigationShadow: Bool { get }
    var navigationLargeTitle: Bool { get }
}

public extension OceanNavigationBar {
    var navigationBackImage: UIImage? {
        return Ocean.icon.arrowLeftOutline?.tinted(with: navigationTintColor)
    }
    
    var navigationTitle: String {
        return ""
    }
    
    var navigationTintColor: UIColor {
        return Ocean.color.colorBrandPrimaryPure
    }
    
    var navigationBackButtonTitle: String {
        return ""
    }
    
    var navigationBackgroundColor: UIColor? {
        return Ocean.color.colorInterfaceLightPure
    }
    
    var navigationShadow: Bool {
        return true
    }
    
    var navigationLargeTitle: Bool {
        return false
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.tintColor = navigationTintColor
        
        updateTitle(newTitle: navigationTitle)
        
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: navigationTintColor,
            NSAttributedString.Key.font: UIFont.init(name: Ocean.font.fontFamilyHighlightWeightExtraBold,
                                                     size: Ocean.font.fontSizeSm)!
        ]
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: navigationTintColor,
            NSAttributedString.Key.font: UIFont.init(name: Ocean.font.fontFamilyHighlightWeightExtraBold,
                                                     size: Ocean.font.fontSizeMd)!
        ]
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = titleAttr
        navBarAppearance.largeTitleTextAttributes = largeTitleAttr
        navBarAppearance.backgroundColor = navigationBackgroundColor
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = nil
        navBarAppearance.setBackIndicatorImage(navigationBackImage, transitionMaskImage: navigationBackImage)

        if navigationShadow {
            navigationController?.navigationBar.ocean.shadow.applyLevel1()
            navigationController?.navigationBar.layer.shadowOpacity = 0
        }
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = navigationLargeTitle
        navigationItem.backButtonTitle = navigationBackButtonTitle
        self.navigationController?.navigationBar.topItem?.backButtonTitle = navigationBackButtonTitle
        
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.setNeedsDisplay()
    }
    
    func updateTitle(newTitle: String) {
        navigationController?.title = newTitle
        title = newTitle
        navigationItem.title = newTitle
    }
    
    func showNavigation(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideNavigation(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func showNavigationShadow() {
        navigationController?.navigationBar.layer.shadowOpacity = navigationShadow ? 1 : 0
    }

    func hideNavigationShadow() {
        navigationController?.navigationBar.layer.shadowOpacity = 0
    }
    
    func showBackButton(animated: Bool = true) {
        navigationItem.leftBarButtonItem = nil
        navigationItem.setHidesBackButton(false, animated: animated)
    }
    
    func hideBackButton(animated: Bool = true) {
        navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    func addCloseButton(action: Selector?) {
        let image = Ocean.icon.xOutline?.tinted(with: navigationTintColor)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self, action: action)
    }

    func addRightBarButtonItem(icon: UIImage? = Ocean.icon.dotsVerticalOutline,
                               icontTintColor: UIColor = Ocean.color.colorBrandPrimaryPure,
                               onTouch: Selector) {
        let image = icon?.tinted(with: icontTintColor)
        let barButtonItem = OceanBarButtonItem(image: image,
                                               style: .plain,
                                               target: self, action: nil)
        barButtonItem.action = onTouch
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func addOptionsButton(options: [OceanNavigationBarOption]) {
        let image = Ocean.icon.dotsVerticalOutline?.tinted(with: navigationTintColor)
        let barButtonItem = OceanBarButtonItem(image: image,
                                            style: .plain,
                                            target: self, action: nil)
        
        if #available(iOS 14.0, *) {
            var children: [UIAction] = []
            for item in options {
                let action = UIAction(title: item.title, image: item.isDestructive ? item.image?.tinted(with: .systemRed) : item.image, attributes: item.isDestructive ? [.destructive] : [], handler: { _ in
                    item.action()
                })
                children.append(action)
            }
            barButtonItem.menu = UIMenu(title: "", children: children)
        } else {
            barButtonItem.options = options
            barButtonItem.action = #selector(optionsClick(_:))
        }
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func removeOptionsButton() {
        navigationItem.rightBarButtonItem = nil
    }
}

fileprivate extension UIViewController {
    @objc func optionsClick(_ sender: Any) {
        if let options = (sender as? OceanBarButtonItem)?.options {
            let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for item in options {
                menu.addAction(UIAlertAction(title: item.title, style: item.isDestructive ? .destructive : .default, handler: { _ in
                    item.action()
                }))
            }
            menu.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            self.present(menu, animated: true, completion: nil)
        }
    }
}
