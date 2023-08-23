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
    public typealias BasicChipBuilder = (BasicChip) -> Void
    public typealias ChipChoiceWithIconBuilder = (ChipChoiceWithIcon) -> Void
    public typealias ChipChoiceWithBadgeBuilder = (ChipChoiceWithBagde) ->  Void
    public typealias ChipFilterBuilder = (ChipFilter) -> Void
    public typealias ChipsBuilder = (Chips) -> Void
    
    public static func chips(builder: ChipsBuilder? = nil) -> Chips {
        return Chips { view in
            builder?(view)
        }
    }
    
    public enum ChipStatus {
        case normal, selected, disabled, inactive
    }
    
    public enum ChipType {
        case choice, choiceWithIcon, choiceWithBadge, filter, basicChip
    }
    
}
