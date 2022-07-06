//
//  Ocean+ShortcutModel.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public struct ShortcutModel {
        let image: UIImage?
        let badgeNumber: Int?
        let badgeStatus: BadgeNumber.Status
        let title: String
        let isHighlight: Bool

        public init(image: UIImage? = nil,
                    badgeNumber: Int? = nil,
                    badgeStatus: BadgeNumber.Status = .alert,
                    title: String,
                    isHighlight: Bool = false) {
            self.image = image
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
            self.title = title
            self.isHighlight = isHighlight
        }
    }
}
