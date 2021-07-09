//
//  UIFont+core.swift
//  Blu
//
//  Created by Victor C Tavernari on 15/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import OceanTokens

extension UIFont {
    public static func highlightExtraBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyHighlightWeightExtraBold, size: size)
    }
    
    public static func highlightBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyHighlightWeightBold, size: size)
    }

    public static func baseRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: size)
    }
    
    public static func baseSemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyBaseWeightMedium, size: size)
    }
    
    public static func baseBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: size)
    }
}
