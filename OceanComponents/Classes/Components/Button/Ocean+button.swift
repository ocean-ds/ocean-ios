//
//  ButtonPrimary.swift
//  Blu
//
//  Created by Victor C Tavernari on 09/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

extension Ocean {
    public typealias ButtonPrimaryBuilder = (ButtonPrimary) -> Void
    public typealias ButtonSecondaryBuilder = (ButtonSecondary) -> Void
    public typealias ButtonTextBuilder = (ButtonText) -> Void
    public typealias ButtonPrimaryInverseBuilder = (ButtonPrimaryInverse) -> Void

    public struct Button {
        public static func primarySM(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .small
                builder( button )
            }
        }

        public static func primaryMD(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func primaryLG(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .large
                builder( button )
            }
        }

        public static func primaryBlockedSM(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryBlockedMD(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryBlockedLG(builder: ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .large
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryCriticalSM(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .small
                builder( button )
            }
        }

        public static func primaryCriticalMD(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func primaryCriticalLG(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .large
                builder( button )
            }
        }

        public static func primaryCriticalBlockedSM(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryCriticalBlockedMD(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryCriticalBlockedLG(builder: ButtonPrimaryBuilder) -> ButtonPrimaryCritical {
            return ButtonPrimaryCritical { button in
                button.size = .large
                button.isBlocked = true
                builder( button )
            }
        }

        public static func secondarySM(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .small
                builder( button )
            }
        }

        public static func secondaryMD(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func secondaryLG(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .large
                builder( button )
            }
        }

        public static func secondaryBlockedSM(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func secondaryBlockedMD(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func secondaryBlockedLG(builder: ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .large
                button.isBlocked = true
                builder( button )
            }
        }

        public static func textSM(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .small
                builder( button )
            }
        }

        public static func textMD(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func textLG(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .large
                builder( button )
            }
        }

        public static func textModifiedSM(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .small
                button.padding = 0
                builder( button )
            }
        }

        public static func textModifiedMD(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .medium
                button.padding = 0
                builder( button )
            }
        }

        public static func textModifiedLG(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .large
                button.padding = 0
                builder( button )
            }
        }

        public static func textBlockedSM(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func textBlockedMD(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func textBlockedLG(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .large
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryInverseSM(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .small
                builder( button )
            }
        }

        public static func primaryInverseMD(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func primaryInverseLG(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .large
                builder( button )
            }
        }

        public static func primaryInverseBlockedSM(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryInverseBlockedMD(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func primaryInverseBlockedLG(builder: ButtonPrimaryInverseBuilder) -> ButtonPrimaryInverse {
            return ButtonPrimaryInverse { button in
                button.size = .large
                button.isBlocked = true
                builder( button )
            }
        }
    }
}
