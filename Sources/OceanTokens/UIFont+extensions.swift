//
//  UIView+superviewConstraints.swift
//  Blu
//
//  Created by Victor C Tavernari on 29/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import Foundation
import UIKit


public extension UIFont {

    static func registerFont(withFilenameString filenameString: String, bundle: Bundle) {
        print("registering font: \(filenameString).ttf…")
        
        guard let pathForResourceString = bundle.path(forResource: filenameString + ".ttf", ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found." )
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
            errorRef?.release()
        }
    }
    
    static func listAllFonts() {
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("  name: \(name as String)")
            }
        }
    }

}

