//
//  AppDelegate.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import UIKit
//import OceanTokens
import OceanComponents


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: Ocean.font.fontSizeLg)
                    // "Avenir" + "-light"
//        let font = UIFont(name: Ocean.font.fontFamilyBaseWeightLight, size: Ocean.font.fontSizeLg)
//        font = Ocean.font.font
//
        
        Ocean.installFonts()
        //UIFont.listAllFonts()
        
        //Ocean().displayTokens()
        //UIFont(name:Ocean.typography., size: 1.0)
        //let colortest = color.articleBody;
        //let literalColor = OceanColors.color.ColorName.private
        //let colorTest = Ocean.color.articleBody
        //let fontTest = Ocean.font.articleBody
        //let sizeTest = Ocean.size.articleBody
        //let bundleTest = Bundle(identifier: "br.com.blu.OceanComponents")
        
//        let resourceBundleName2 = "OceanComponents.bundle"
//        Bundle.bundleOceanComponents.path(forResource: <#T##String?#>, ofType: <#T##String?#>)
        //let bundleImagePath = bundle2.path(forResource: "ocean_icon_accessibility_human.png", ofType: nil)!
        //let test5 =  UIImage(named: "OceanComponents.bundle/ocean_icon_accessibility_human.png", in: bundle2, compatibleWith: .none)
//        let bundlePath = Bundle.main.path(forResource: "ocean_icon_accessibility_human.png", ofType: nil)
//        let image = UIImage(contentsOfFile: bundlePath!)
//        print(Ocean.bundleComponents)
//        let bundlePath2 = Ocean.bundleComponents.path(forResource: "ocean_icon_accessibility_human.png", ofType: nil)
//        let image2 = UIImage(contentsOfFile: bundlePath2!)
        
//        guard let pathForResourceString = Ocean.bundleComponents.path(forResource: "ocean_icon_accessibility.png", ofType: nil) else {
//            print("UIFont+:  Failed to register font - path for resource not found." )
//            return false
//        }
//        let image = UIImage(contentsOfFile: pathForResourceString)
//        guard let pathForResourceString2 = Ocean.bundleComponents.path(forResource: "ocean_icon_align_left@3x.png", ofType:nil) else {
//            print("UIFont+:  Failed to register font - path for resource not found." )
//            return false
//        }
//        let image2 = UIImage(contentsOfFile: pathForResourceString2)
//        //NSDataAsset(name: <#T##NSDataAssetName#>, bundle: <#T##Bundle#>)
//        let oceanIconAccessibility = UIImage(named: "OceanComponents.bundle/ocean_icon_accessibility", in: .bundleOceanComponents, compatibleWith: .none)
        let imageTest = Ocean.icon.accessibilityHumanLg
        print(imageTest)
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }




    
}

//extension Bundle {
//    static public let bundleOceanComponents = Bundle(identifier: "br.com.blu.OceanComponents")!
//
//
//}
