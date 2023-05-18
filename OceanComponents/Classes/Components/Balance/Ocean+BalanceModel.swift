//
//  Ocean+BalanceModel.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/05/23.
//

import OceanTokens

extension Ocean {
    public enum BalanceState {
        case expanded, collapsed, scroll
    }

    public struct BalanceModel {
        let title: String
        let value: Double?
        let item1Title: String
        let item1Value: Double
        let item2Title: String
        let item2Value: Double
        let description: String
        let actionCTA: String
        let action: (() -> Void)?

        public init(title: String,
                    value: Double?,
                    item1Title: String,
                    item1Value: Double,
                    item2Title: String,
                    item2Value: Double,
                    description: String,
                    actionCTA: String,
                    action: (() -> Void)?) {
            self.title = title
            self.value = value
            self.item1Title = item1Title
            self.item1Value = item1Value
            self.item2Title = item2Title
            self.item2Value = item2Value
            self.description = description
            self.actionCTA = actionCTA
            self.action = action
        }

        public init(title: String,
                    value: Double?,
                    description: String,
                    actionCTA: String,
                    action: (() -> Void)?) {
            self.init(title: title,
                      value: value,
                      item1Title: "",
                      item1Value: 0,
                      item2Title: "",
                      item2Value: 0,
                      description: description,
                      actionCTA: actionCTA,
                      action: action)
        }

        public static func empty() -> Self {
            return BalanceModel(title: "",
                                value: nil,
                                description: "",
                                actionCTA: "",
                                action: nil)
        }
    }
}
