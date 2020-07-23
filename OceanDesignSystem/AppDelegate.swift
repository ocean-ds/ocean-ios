//
//  AppDelegate.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens
import OceanComponents


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Ocean.installFonts()
        
        let imageTest = Ocean.icon.accessibilityHumanLg
        print(imageTest)
        return true
    }
}
