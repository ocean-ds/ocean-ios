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
            label.parameters.style = .heading1
            builder?(label)
        }
    }

    public static func heading2(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading2
            builder?(label)
        }
    }

    public static func heading3(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading3
            builder?(label)
        }
    }

    public static func heading4(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading4
            builder?(label)
        }
    }

    public static func heading5(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading5
            builder?(label)
        }
    }

    public static func heading1Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading1Inverse
            builder?(label)
        }
    }

    public static func heading2Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading2Inverse
            builder?(label)
        }
    }

    public static func heading3Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading3Inverse
            builder?(label)
        }
    }

    public static func heading4Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading4Inverse
            builder?(label)
        }
    }

    public static func heading5Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .heading5Inverse
            builder?(label)
        }
    }

    public static func subTitle1(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .subTitle1
            builder?(label)
        }
    }

    public static func subTitle2(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .subTitle2
            builder?(label)
        }
    }

    public static func subTitle1Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .subTitle1Inverse
            builder?(label)
        }
    }

    public static func subTitle2Inverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .subTitle2Inverse
            builder?(label)
        }
    }

    public static func paragraph(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .paragraph
            builder?(label)
        }
    }

    public static func paragraphInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .paragraphInverse
            builder?(label)
        }
    }

    public static func lead(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .lead
            builder?(label)
        }
    }

    public static func leadInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .leadInverse
            builder?(label)
        }
    }

    public static func description(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .description
            builder?(label)
        }
    }

    public static func descriptionInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .descriptionInverse
            builder?(label)
        }
    }

    public static func caption(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .caption
            builder?(label)
        }
    }

    public static func captionBold(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .captionBold
            builder?(label)
        }
    }

    public static func captionInverse(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .captionInverse
            builder?(label)
        }
    }

    public static func eyebrow(builder: OceanSwiftUI.Typography.Builder? = nil) -> OceanSwiftUI.Typography {
        return OceanSwiftUI.Typography { label in
            label.parameters.style = .eyebrow
            builder?(label)
        }
    }
}
