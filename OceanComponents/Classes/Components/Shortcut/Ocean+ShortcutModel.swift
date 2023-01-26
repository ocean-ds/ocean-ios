//
//  Ocean+ShortcutModel.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public struct ShortcutModel {
        public let image: UIImage?
        public let badgeNumber: Int?
        public let badgeStatus: BadgeNumber.Status
        public let title: String
        public let subtitle: String

        public init(image: UIImage? = nil,
                    badgeNumber: Int? = nil,
                    badgeStatus: BadgeNumber.Status = .alert,
                    title: String,
                    subtitle: String = "") {
            self.image = image
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
            self.title = title
            self.subtitle = subtitle
        }
    }
}
