//
//  Ocean+badge.swift
//  OceanComponents
//
//  Created by Vini on 03/09/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public typealias BadgeTinyBuilder = (BadgeTiny) -> Void
    public typealias BadgeNumberBuilder = (BadgeNumber) -> Void
    
    public struct Badge {
        public static func tiny(builder: BadgeTinyBuilder? = nil) -> BadgeTiny {
            return BadgeTiny { view in
                builder?(view)
            }
        }
        
        public static func number(builder: BadgeNumberBuilder? = nil) -> BadgeNumber {
            return BadgeNumber { view in
                builder?(view)
            }
        }
    }
}
