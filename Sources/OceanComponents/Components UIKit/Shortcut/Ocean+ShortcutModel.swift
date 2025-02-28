//
//  Ocean+ShortcutModel.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public struct ShortcutModel: Equatable {
        public let image: UIImage?
        public let tagLabel: String?
        public let badgeNumber: Int?
        public let badgeStatus: BadgeNumber.Status
        public let title: String
        public let subtitle: String
        public let blocked: Bool

        public init(image: UIImage? = nil,
                    tagLabel: String? = nil,
                    badgeNumber: Int? = nil,
                    badgeStatus: BadgeNumber.Status = .alert,
                    title: String,
                    subtitle: String = "",
                    blocked: Bool = false) {
            self.image = image
            self.tagLabel = tagLabel
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
            self.title = title
            self.subtitle = subtitle
            self.blocked = blocked
        }
    }
}
