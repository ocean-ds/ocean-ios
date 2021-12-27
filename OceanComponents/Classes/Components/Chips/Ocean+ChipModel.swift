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
        public let type: Ocean.ChipType
        public var status: Ocean.ChipStatus
        
        public init(id: String? = nil,
                    icon: UIImage? = nil,
                    number: Int? = nil,
                    title: String,
                    type: Ocean.ChipType = .choice,
                    status: Ocean.ChipStatus = .normal) {
            self.id = id
            self.icon = icon
            self.number = number
            self.title = title
            self.type = type
            self.status = status
        }
    }
}
