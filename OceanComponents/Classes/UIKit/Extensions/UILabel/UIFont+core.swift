//
//  UIFont+core.swift
//  Blu
//
//  Created by Victor C Tavernari on 15/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import OceanTokens

extension UIFont {
    static func highlightExtraBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyHighlightWeightExtraBold, size: size)
    }
    
    static func highlightBold(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyHighlightWeightBold, size: size)
    }

    static func baseRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: size)
    }
}
