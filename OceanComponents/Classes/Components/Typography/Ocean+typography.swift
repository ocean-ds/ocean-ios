//
//  UILabel+core.swift
//  Blu
//
//  Created by Victor C Tavernari on 15/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import OceanTokens
import UIKit

extension Ocean {
    public struct Typography {
        
        public static func heading1(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .highlightExtraBold(size: Ocean.font.fontSizeLg)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func heading2(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .highlightExtraBold(size: Ocean.font.fontSizeMd)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func heading3(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .highlightExtraBold(size: Ocean.font.fontSizeSm)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func heading4(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                
                label.font = .highlightBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func heading1Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.heading1 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }
        
        public static func heading2Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.heading2 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }
        
        public static func heading3Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.heading3 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }
        
        public static func heading4Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.heading4 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
            
        }
        
        public static func subTitle1(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeMd)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func subTitle2(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeSm)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
                builder?( label )
            }
        }
        
        public static func subTitle1Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.subTitle1 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightDown
            }
        }
        
        public static func subTitle2Inverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.subTitle2 { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightDown
            }
        }

        public static func paragraph(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
                builder?( label )
            }
        }
        
        public static func paragraphInverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.paragraph { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightDown
            }
            
        }
        
        public static func highlightedParagraph(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeSm)
                label.textColor = Ocean.color.colorInterfaceDarkPure
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
                builder?( label )
            }
        }

        public static func description(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
                builder?( label )
            }
        }
        
        public static func descriptionInverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.description { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightDown
            }
            
        }
        
        
        public static func caption(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
                builder?( label )
            }
        }
        
        public static func captionInverse(builder: ((UILabel) -> Void)? = nil) -> UILabel {
            return Ocean.Typography.caption { label in
                builder?(label)
                label.textColor = Ocean.color.colorInterfaceLightDown
            }
        }
    }
}
