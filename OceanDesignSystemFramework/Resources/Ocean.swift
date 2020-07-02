//
//  Ocean.swift
//  OceanDesignSystem
//
//  Created by Alexandro Gomes on 26/06/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit

public struct Ocean {
 
    static public func registerFonts(bundle: Bundle) {
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyBaseWeightBold, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyBaseWeightExtraBold, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyBaseWeightLight, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyBaseWeightMedium, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyBaseWeightRegular, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyHighlightWeightBold, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyHighlightWeightExtraBold, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyHighlightWeightLight, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyHighlightWeightMedium, bundle: bundle);
        UIFont.registerFont(withFilenameString: Ocean.font.fontFamilyHighlightWeightRegular, bundle: bundle);
        
    }
    
    
    
}



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

public protocol PropertyLoopable
{
    func allProperties() throws -> [String: Any]
}

extension PropertyLoopable
{
    public func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            //throw some error
            throw NSError(domain: "hris.to", code: 777, userInfo: nil)
        }

        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }

            result[label] = valueMaybe
        }

        return result
    }
}
