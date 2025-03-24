//
//  OceanSwiftUI+BadgeBuilder.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 13/12/23.
//

import OceanTokens

extension OceanSwiftUI.Badge {
    public static func primaryMd(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .primary
            badge.parameters.size = .medium
            builder?(badge)
        }
    }

    public static func primarySm(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .primary
            badge.parameters.size = .small
            builder?(badge)
        }
    }

    public static func primaryInvertedMd(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .primaryInverted
            badge.parameters.size = .medium
            builder?(badge)
        }
    }

    public static func primaryInvertedSm(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .primaryInverted
            badge.parameters.size = .small
            builder?(badge)
        }
    }

    public static func warningMd(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .warning
            badge.parameters.size = .medium
            builder?(badge)
        }
    }

    public static func warningSm(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .warning
            badge.parameters.size = .small
            builder?(badge)
        }
    }

    public static func highlightMd(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .highlight
            badge.parameters.size = .medium
            builder?(badge)
        }
    }

    public static func highlightSm(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .highlight
            badge.parameters.size = .small
            builder?(badge)
        }
    }

    public static func disabledMd(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .disabled
            badge.parameters.size = .medium
            builder?(badge)
        }
    }

    public static func disabledSm(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.status = .disabled
            badge.parameters.size = .small
            builder?(badge)
        }
    }

    public static func dot(builder: OceanSwiftUI.Badge.Builder? = nil) -> OceanSwiftUI.Badge {
        return OceanSwiftUI.Badge { badge in
            badge.parameters.style = .dot
            builder?(badge)
        }
    }
}
