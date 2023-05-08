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

        public static func secondaryCriticalSM(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
                button.size = .small
                builder( button )
            }
        }

        public static func secondaryCriticalMD(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func secondaryCriticalLG(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
                button.size = .large
                builder( button )
            }
        }

        public static func secondaryCriticalBlockedSM(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func secondaryCriticalBlockedMD(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func secondaryCriticalBlockedLG(builder: ButtonSecondaryBuilder) -> ButtonSecondaryCritical {
            return ButtonSecondaryCritical { button in
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
                button.paddingLeft = 0
                button.paddingRight = 0
                builder( button )
            }
        }

        public static func textModifiedMD(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .medium
                button.paddingLeft = 0
                button.paddingRight = 0
                builder( button )
            }
        }

        public static func textModifiedLG(builder: ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .large
                button.paddingLeft = 0
                button.paddingRight = 0
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

        public static func textCriticalSM(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .small
                builder( button )
            }
        }

        public static func textCriticalMD(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .medium
                builder( button )
            }
        }

        public static func textCriticalLG(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .large
                builder( button )
            }
        }

        public static func textCriticalModifiedSM(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .small
                button.paddingLeft = 0
                button.paddingRight = 0
                builder( button )
            }
        }

        public static func textCriticalModifiedMD(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .medium
                button.paddingLeft = 0
                button.paddingRight = 0
                builder( button )
            }
        }

        public static func textCriticalModifiedLG(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .large
                button.paddingLeft = 0
                button.paddingRight = 0
                builder( button )
            }
        }

        public static func textCriticalBlockedSM(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .small
                button.isBlocked = true
                builder( button )
            }
        }

        public static func textCriticalBlockedMD(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
                button.size = .medium
                button.isBlocked = true
                builder( button )
            }
        }

        public static func textCriticalBlockedLG(builder: ButtonTextBuilder) -> ButtonTextCritical {
            return ButtonTextCritical { button in
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
