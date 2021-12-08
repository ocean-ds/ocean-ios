//
//  Ocean+Chip.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 06/12/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public typealias ChipChoiceBuilder = (ChipChoice) -> Void
    public typealias ChipChoiceWithIconBuilder = (ChipChoiceWithIcon) -> Void
    public typealias ChipChoiceWithBadgeBuilder = (ChipChoiceWithBagde) ->  Void
    public typealias ChipFilterBuilder = (ChipFilter) -> Void
    
    public struct Chip {
        public static func choice(builder: ChipChoiceBuilder? = nil) -> ChipChoice {
            return ChipChoice { view in
                builder?(view)
            }
        }
        
        public static func choiceWithIcon(builder: ChipChoiceWithIconBuilder? = nil) -> ChipChoiceWithIcon {
            return ChipChoiceWithIcon { view in
                builder?(view)
            }
        }
        
        public static func choiceWithBadge(builder: ChipChoiceWithBadgeBuilder? = nil) -> ChipChoiceWithBagde {
            return ChipChoiceWithBagde { view in
                builder?(view)
            }
        }
        
        public static func filter(builder: ChipFilterBuilder? = nil) -> ChipFilter {
            return ChipFilter { view in
                builder?(view)
            }
        }
    }
    
    public enum ChipStatus {
        case normal, selected, disabled, error
    }
    
}
