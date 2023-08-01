//
//  ChipModel.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 08/12/21.
//

import OceanTokens

extension Ocean {
    public struct ChipModel {
        public let id: String?
        public let icon: UIImage?
        public let number: Int?
        public let title: String
        public var status: Ocean.ChipStatus
        public var isSelected: Bool?
        
        public init(id: String? = nil,
                    icon: UIImage? = nil,
                    number: Int? = nil,
                    title: String,
                    status: Ocean.ChipStatus = .normal,
                    isSelected: Bool? = false) {
            self.id = id
            self.icon = icon
            self.number = number
            self.title = title
            self.status = status
            self.isSelected = isSelected
        }

        public static func empty() -> Self {
            return ChipModel(title: "")
        }
    }
}
