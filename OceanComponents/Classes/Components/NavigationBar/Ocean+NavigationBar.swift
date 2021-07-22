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
    var navigationBackImage: UIImage? {
        return self.navigationController?.navigationBar.backIndicatorImage
    }
    
    var navigationTitle: String? {
        return self.navigationController?.navigationItem.title
    }
    
    var navigationTintColor: UIColor {
        return Ocean.color.colorBrandPrimaryPure
    }
    
    var navigationBackButtonTitle: String {
        return ""
    }
    
    var navigationBackgroundColor: UIColor? {
        return nil
    }
    
    var navigationShadow: Bool {
        return false
    }
    
    func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = navigationTintColor
        navigationController?.navigationBar.shadowImage = navigationShadow ? Ocean.color.colorInterfaceLightDeep.as1ptImage() : UIImage()

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
    
    func addCloseButton(action: Selector?) {
        let image = Ocean.icon.xOutline?.tinted(with: navigationTintColor)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self, action: action)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
