//
//  Ocean+TransactionFooterItemModel.swift
//  OceanComponents
//
//  Created by Acassio Vilas Boas on 29/07/22.
//

import OceanTokens

extension Ocean {
    public struct TransactionItemModel {
        public var title: String?
        public var subtitleTextLabel: TextLabelModel?
        public var tooltipMessage: String?

        public init(title: String? = "",
             subTitleTextLabel: TextLabelModel? = nil,
             tooltipMessage: String? = "") {
            self.title = title
            self.subtitleTextLabel = subTitleTextLabel
            self.tooltipMessage = tooltipMessage
        }
    }
}
