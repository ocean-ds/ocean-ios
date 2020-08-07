//
//  Ocean+textarea.swift
//  OceanComponents
//
//  Created by Alex Gomes on 06/08/20.
//

import Foundation
import OceanTokens

extension Ocean {

    public struct Input {
        public static func textarea(builder:ButtonPrimaryBuilder) -> ButtonPrimary {
            return ButtonPrimary { button in
                button.size = .small
                builder( button )
            }
        }
    }

}
