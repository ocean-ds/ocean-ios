//
//  Models.swift
//  OceanDesignSystem
//
//  Created by Alex Gomes on 23/07/20.
//  Copyright © 2020 Blu Pagamentos. All rights reserved.
//

import Foundation
import OceanTokens
import UIKit

struct Categories {
    var name : String
    
    static func loadCategories() -> [String] {
        return ["Colors", "Shadows", "Sizes", "Typographies"]
    }
}

struct Typographies {
    
    static let subCategories = [
        "FontFamiliesWithWeights",
        "Sizes",
        "LineHeights"
    ]
    
    static let fontFamilies = [
        
        "fontFamilyBaseWeightBold": Ocean.font.fontFamilyBaseWeightBold,
        "fontFamilyBaseWeightExtraBold": Ocean.font.fontFamilyBaseWeightExtraBold,
        "fontFamilyBaseWeightLight": Ocean.font.fontFamilyBaseWeightLight,
        "fontFamilyBaseWeightMedium": Ocean.font.fontFamilyBaseWeightMedium,
        "fontFamilyBaseWeightRegular": Ocean.font.fontFamilyBaseWeightRegular,
        "fontFamilyHighlightWeightBold": Ocean.font.fontFamilyHighlightWeightBold,
        "fontFamilyHighlightWeightExtraBold": Ocean.font.fontFamilyHighlightWeightExtraBold,
        "fontFamilyHighlightWeightLight": Ocean.font.fontFamilyHighlightWeightLight,
        "fontFamilyHighlightWeightMedium": Ocean.font.fontFamilyHighlightWeightMedium,
        "fontFamilyHighlightWeightRegular": Ocean.font.fontFamilyHighlightWeightRegular
    ]
    
    static let fontSizes = [
        "fontSizeDisplay": Ocean.font.fontSizeDisplay,
        "fontSizeGiant": Ocean.font.fontSizeGiant,
        "fontSizeLg": Ocean.font.fontSizeLg,
        "fontSizeMd": Ocean.font.fontSizeMd,
        "fontSizeSm":  Ocean.font.fontSizeSm,
        "fontSizeXl": Ocean.font.fontSizeXl,
        "fontSizeXs": Ocean.font.fontSizeXs,
        "fontSizeXxl": Ocean.font.fontSizeXxl,
        "fontSizeXxs": Ocean.font.fontSizeXxs,
        "fontSizeXxxl": Ocean.font.fontSizeXxxl,
        "fontSizeXxxs": Ocean.font.fontSizeXxxs
    ]
    
    static let lineHeights = [
        
        "lineHeightComfy": Ocean.font.lineHeightComfy,
        "lineHeightMedium":  Ocean.font.lineHeightMedium,
        "lineHeightTight": Ocean.font.lineHeightTight
    ]
    
    static func fontFamiliesKeys() -> [String] {
        return Array((fontFamilies.keys).sorted(by: <))
    }
    
    static func fontLineHeightsKeys() -> [String] {
        return Array((lineHeights.keys).sorted(by: <))
    }
    
    static func fontSizesKeys() -> [String] {
        return Array((fontSizes.keys).sorted(by: <))
    }
    
    static func keys() -> [String] {
        return Array((list().keys).sorted(by: <))
    }
    
    static func list() -> [String: Any] {
        
        var fonts : [String: Any] = [:]
        
        for (key,value) in fontFamilies {
            //print(key, value)
            for (keySize, valueSize) in fontSizes {
                let font = UIFont(name: value, size: CGFloat(valueSize))
                fonts["\(key)\(keySize)"] = font
            }
        }
        
        return fonts
    }
}

struct Shadows {
    static func keys() -> [String] {
        return Array((list().keys).sorted(by: <))
    }
    static func list() -> [String: Ocean.shadow.ShadowParameters] {
        return [
            "shadowLevel1" : Ocean.shadow.shadowLevel1,
            "shadowLevel2" : Ocean.shadow.shadowLevel2,
            "shadowLevel3" : Ocean.shadow.shadowLevel3,
            "shadowLevel4" : Ocean.shadow.shadowLevel4
        ]
    }
}

struct Colors {
    static func keys() -> [String] {
        return Array((list.keys).sorted(by: <))
    }
    
    static let list = [
        "colorBrandPrimaryDeep" : #colorLiteral(red: 0.05490196, green: 0.14117648, blue: 0.56078434, alpha: 1.0),
        "colorBrandPrimaryDown" : #colorLiteral(red: 0.34509805, green: 0.44705883, blue: 0.9607843, alpha: 1.0),
        "colorBrandPrimaryPure" : #colorLiteral(red: 0.0, green: 0.14509805, blue: 0.8784314, alpha: 1.0),
        "colorBrandPrimaryUp" : #colorLiteral(red: 0.72156864, green: 0.7647059, blue: 1.0, alpha: 1.0),
        "colorComplementaryDeep" : #colorLiteral(red: 0.10980392, green: 0.6, blue: 0.6, alpha: 1.0),
        "colorComplementaryDown" : #colorLiteral(red: 0.41568628, green: 0.8980392, blue: 0.8980392, alpha: 1.0),
        "colorComplementaryPure" : #colorLiteral(red: 0.07450981, green: 0.7411765, blue: 0.7411765, alpha: 1.0),
        "colorComplementaryUp" : #colorLiteral(red: 0.6901961, green: 0.9607843, blue: 0.9607843, alpha: 1.0),
        "colorHighlightDeep" : #colorLiteral(red: 0.8980392, green: 0.24313726, blue: 0.19607843, alpha: 1.0),
        "colorHighlightDown" : #colorLiteral(red: 0.9411765, green: 0.34509805, blue: 0.3019608, alpha: 1.0),
        "colorHighlightPure" : #colorLiteral(red: 1.0, green: 0.44705883, blue: 0.43137255, alpha: 1.0),
        "colorHighlightUp" : #colorLiteral(red: 1.0, green: 0.72156864, blue: 0.69803923, alpha: 1.0),
        "colorInterfaceDarkDeep" : #colorLiteral(red: 0.22352941, green: 0.23137255, blue: 0.2784314, alpha: 1.0),
        "colorInterfaceDarkDown" : #colorLiteral(red: 0.40392157, green: 0.4117647, blue: 0.47843137, alpha: 1.0),
        "colorInterfaceDarkPure" : #colorLiteral(red: 0.047058824, green: 0.050980393, blue: 0.078431375, alpha: 1.0),
        "colorInterfaceDarkUp" : #colorLiteral(red: 0.7137255, green: 0.7254902, blue: 0.8, alpha: 1.0),
        "colorInterfaceLightDeep" : #colorLiteral(red: 0.84705883, green: 0.85490197, blue: 0.9098039, alpha: 1.0),
        "colorInterfaceLightDown" : #colorLiteral(red: 0.92156863, green: 0.9254902, blue: 0.9607843, alpha: 1.0),
        "colorInterfaceLightPure" : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        "colorInterfaceLightUp" : #colorLiteral(red: 0.96862745, green: 0.9764706, blue: 1.0, alpha: 1.0),
        "colorStatusNegativeDown" : #colorLiteral(red: 0.8784314, green: 0.050980393, blue: 0.24705882, alpha: 1.0),
        "colorStatusNegativePure" : #colorLiteral(red: 0.9607843, green: 0.27058825, blue: 0.43137255, alpha: 1.0),
        "colorStatusNegativeUp" : #colorLiteral(red: 1.0, green: 0.92941177, blue: 0.94509804, alpha: 1.0),
        "colorStatusNeutralDown" : #colorLiteral(red: 0.98039216, green: 0.5294118, blue: 0.078431375, alpha: 1.0),
        "colorStatusNeutralPure" : #colorLiteral(red: 1.0, green: 0.6392157, blue: 0.2784314, alpha: 1.0),
        "colorStatusNeutralUp" : #colorLiteral(red: 1.0, green: 0.9098039, blue: 0.81960785, alpha: 1.0),
        "colorStatusPositiveDown" : #colorLiteral(red: 0.10980392, green: 0.61960787, blue: 0.24705882, alpha: 1.0),
        "colorStatusPositivePure" : #colorLiteral(red: 0.23921569, green: 0.8, blue: 0.39215687, alpha: 1.0),
        "colorStatusPositiveUp" : #colorLiteral(red: 0.84313726, green: 0.98039216, blue: 0.8784314, alpha: 1.0)
        ]
    
}

struct Sizes {
    
    static let subCategories = [
        "Borders",
        "Opacities",
        "SpacesInline"
    ]
}

struct Borders {
    
    static func keys() -> [String] {
        return Array((list.keys).sorted(by: <))
    }
    
    static let list = [
        "borderRadiusCircular": Ocean.size.borderRadiusCircular,
        "borderRadiusLg": Ocean.size.borderRadiusLg,
        "borderRadiusMd": Ocean.size.borderRadiusMd,
        "borderRadiusNone": Ocean.size.borderRadiusNone,
        "borderRadiusPill": Ocean.size.borderRadiusPill,
        "borderRadiusSm": Ocean.size.borderRadiusSm,
        "borderWidthHairline": Ocean.size.borderWidthHairline,
        "borderWidthHeavy": Ocean.size.borderWidthHeavy,
        "borderWidthNone": Ocean.size.borderWidthNone,
        "borderWidthThick": Ocean.size.borderWidthThick,
        "borderWidthThin": Ocean.size.borderWidthThin
    ]
}

struct Opacities {
    
    static func keys() -> [String] {
        return Array((list.keys).sorted(by: <))
    }
    
    static let list = [
        "opacityLevelIntense" : Ocean.size.opacityLevelIntense,
        "opacityLevelLight" : Ocean.size.opacityLevelLight,
        "opacityLevelMedium" : Ocean.size.opacityLevelMedium,
        "opacityLevelSemiopaque": Ocean.size.opacityLevelSemiopaque,
        "opacityLevelSemitransparent" : Ocean.size.opacityLevelSemitransparent
    ]
}

struct Spaces {
    
    static func keys() -> [String] {
        return Array((list.keys).sorted(by: <))
    }
    
    static let list = [
        "spacingInlineLg": Ocean.size.spacingInlineLg,
        "spacingInlineMd": Ocean.size.spacingInlineMd,
        "spacingInlineSm": Ocean.size.spacingInlineSm,
        "spacingInlineXl": Ocean.size.spacingInlineXl,
        "spacingInlineXs": Ocean.size.spacingInlineXs,
        "spacingInlineXxl": Ocean.size.spacingInlineXxl,
        "spacingInlineXxs": Ocean.size.spacingInlineXxs,
        "spacingInlineXxxl": Ocean.size.spacingInlineXxxl,
        "spacingInlineXxxs": Ocean.size.spacingInlineXxxs,
        "spacingInsetLg": Ocean.size.spacingInsetLg,
        "spacingInsetMd": Ocean.size.spacingInsetMd,
        "spacingInsetSm": Ocean.size.spacingInsetSm,
        "spacingInsetXl": Ocean.size.spacingInsetXl,
        "spacingInsetXs": Ocean.size.spacingInsetXs,
        "spacingInsetXxs": Ocean.size.spacingInsetXxs,
        "spacingStackLg": Ocean.size.spacingStackLg,
        "spacingStackMd": Ocean.size.spacingStackMd,
        "spacingStackSm": Ocean.size.spacingStackSm,
        "spacingStackXl": Ocean.size.spacingStackXl,
        "spacingStackXs": Ocean.size.spacingStackXs,
        "spacingStackXxl": Ocean.size.spacingStackXxl,
        "spacingStackXxs": Ocean.size.spacingStackXxs,
        "spacingStackXxxl": Ocean.size.spacingStackXxxl,
        "spacingStackXxxs": Ocean.size.spacingStackXxxs
    ]
}

