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
    
    
    public struct Button {
        
        public static func primarySM(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .small
                builder( button )
            }
        }
        
        public static func primaryMD(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .medium
                
                builder( button )
            }
        }
        
        public static func primaryLG(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .large
                builder( button )
            }
        }
        
        public static func secondarySM(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .small
                builder( button )
            }
        }
        
        public static func secondaryMD(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .medium
                
                builder( button )
            }
        }
        
        public static func secondaryLG(builder:ButtonSecondaryBuilder) -> ButtonSecondary {
            return ButtonSecondary { button in
                button.size = .large
                builder( button )
            }
        }
        
        public static func textSM(builder:ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .small
                builder( button )
            }
        }
        
        public static func textMD(builder:ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .medium
                builder( button )
            }
        }
        
        public static func textLG(builder:ButtonTextBuilder) -> ButtonText {
            return ButtonText { button in
                button.size = .large
                builder( button )
            }
        }
    }
}
