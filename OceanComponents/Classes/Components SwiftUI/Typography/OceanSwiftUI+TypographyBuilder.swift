//
//  OceanSwiftUI+TypographyBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/08/23.
//

import OceanTokens

extension OceanSwiftUI.Typography {
    public static func heading1(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .highlightExtraBold(size: Ocean.font.fontSizeLg)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func heading2(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .highlightExtraBold(size: Ocean.font.fontSizeMd)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func heading3(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .highlightExtraBold(size: Ocean.font.fontSizeSm)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func heading4(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .highlightBold(size: Ocean.font.fontSizeXs)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func heading5(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .highlightBold(size: Ocean.font.fontSizeXxs)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func heading1Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.heading1 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
        }
    }

    public static func heading2Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.heading2 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
        }
    }

    public static func heading3Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.heading3 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
        }
    }

    public static func heading4Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.heading4 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
        }
    }

    public static func heading5Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.heading5 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
        }
    }

    public static func subTitle1(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeMd)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func subTitle2(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeSm)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
            builder?(label)
        }
    }

    public static func subTitle1Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.subTitle1 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightDown
        }
    }

    public static func subTitle2Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.subTitle2 { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightDown
        }
    }

    public static func paragraph(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXs)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            builder?(label)
        }
    }

    public static func paragraphInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.paragraph { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightDown
        }
    }

    public static func lead(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseBold(size: Ocean.font.fontSizeSm)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            builder?(label)
        }
    }

    public static func leadInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.lead { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorInterfaceLightDown
        }
    }

    public static func description(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxs)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            builder?(label)
        }
    }

    public static func descriptionInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.description { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
        }
    }

    public static func caption(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.font = .baseRegular(size: Ocean.font.fontSizeXxxs)
            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
//            label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
            builder?(label)
        }
    }

    public static func captionInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography.caption { label in
            builder?(label)
            label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
        }
    }
}
