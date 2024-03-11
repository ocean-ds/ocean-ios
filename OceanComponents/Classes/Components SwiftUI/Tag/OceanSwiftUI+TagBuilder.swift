//
//  OceanSwiftUI+TagBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 24/11/23.
//

import OceanTokens

extension OceanSwiftUI.Tag {
    public static func positiveMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .positive
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func positiveSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .positive
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func warningMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .warning
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func warningSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .warning
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func negativeMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .negative
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func negativeSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .negative
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func complementaryMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .complementary
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func complementarySM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .complementary
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func neutralInterfaceMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralInterface
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func neutralInterfaceSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralInterface
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func neutralPrimaryMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralPrimary
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func neutralPrimarySM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralPrimary
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func highlightImportantMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .highlightImportant
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func highlightImportantSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .highlightImportant
            tag.parameters.size = .small
            builder?(tag)
        }
    }

    public static func highlightNeutralMD(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .highlightNeutral
            tag.parameters.size = .medium
            builder?(tag)
        }
    }

    public static func highlightNeutralSM(builder: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .highlightNeutral
            tag.parameters.size = .small
            builder?(tag)
        }
    }
}
