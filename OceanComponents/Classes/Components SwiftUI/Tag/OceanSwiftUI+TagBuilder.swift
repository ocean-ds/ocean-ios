//
//  OceanSwiftUI+TagBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 24/11/23.
//

import OceanTokens

extension OceanSwiftUI.Tag {
    public static func positiveMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .positive
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func positiveSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .positive
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func warningMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .warning
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func warningSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .warning
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func negativeMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .negative
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func negativeSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .negative
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func complementaryMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .complementary
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func complementarySM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .complementary
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func neutralInterfaceMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralInterface
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func neutralInterfaceSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralInterface
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func neutralPrimaryMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralPrimary
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func neutralPrimarySM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutralPrimary
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func importantMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .important
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func importantSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .important
            tag.parameters.size = .small
            buider?(tag)
        }
    }

    public static func neutralMD(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutral
            tag.parameters.size = .medium
            buider?(tag)
        }
    }

    public static func neutralSM(buider: OceanSwiftUI.Tag.Builder? = nil) -> OceanSwiftUI.Tag {
        return OceanSwiftUI.Tag { tag in
            tag.parameters.status = .neutral
            tag.parameters.size = .small
            buider?(tag)
        }
    }
}
