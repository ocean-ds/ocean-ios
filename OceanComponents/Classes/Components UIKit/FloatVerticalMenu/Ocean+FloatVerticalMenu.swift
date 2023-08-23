//
//  Ocean.swift
//  FSCalendar
//
//  Created by Leticia Fernandes on 17/03/22.
//

import OceanTokens
import UIKit

extension Ocean {
    public typealias FloatVerticalMenuListBuilder = ((FloatVerticalMenuList) -> Void)?

    public struct FloatVerticalMenu {
        public static func list(builder: FloatVerticalMenuListBuilder = nil) -> FloatVerticalMenuList {
            return FloatVerticalMenuList(builder: builder)
        }
    }
}
