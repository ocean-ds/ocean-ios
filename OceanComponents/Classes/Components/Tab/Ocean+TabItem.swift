//
//  Ocean+TabItem.swift
//  FSCalendar
//
//  Created by Leticia Fernandes on 23/03/22.
//

import Foundation
import UIKit
import OceanTokens

public struct OceanTabItem {

    public let title: String
    public let badgeNumber: Int?

    public init(title: String,
                badgeNumber: Int? = nil) {
        self.title = title
        self.badgeNumber = badgeNumber
    }
}
