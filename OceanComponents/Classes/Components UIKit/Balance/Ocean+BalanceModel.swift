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
    
    public enum BalanceCellType {
        case withValue, withoutValue
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
        let actionCTACollapsed: String
        let action: (() -> Void)?
        let cellType: BalanceCellType

        public init(title: String,
                    value: Double?,
                    item1Title: String,
                    item1Value: Double,
                    item2Title: String,
                    item2Value: Double,
                    description: String,
                    actionCTA: String,
                    actionCTACollapsed: String  = "",
                    action: (() -> Void)?,
                    cellType: BalanceCellType = .withValue) {
            self.title = title
            self.value = value
            self.item1Title = item1Title
            self.item1Value = item1Value
            self.item2Title = item2Title
            self.item2Value = item2Value
            self.description = description
            self.actionCTA = actionCTA
            self.actionCTACollapsed = actionCTACollapsed
            self.action = action
            self.cellType = cellType
        }

        public init(title: String,
                    value: Double?,
                    description: String,
                    actionCTA: String,
                    actionCTACollapsed: String,
                    action: (() -> Void)?,
                    cellType: BalanceCellType = .withoutValue) {
            self.init(title: title,
                      value: value,
                      item1Title: "",
                      item1Value: 0,
                      item2Title: "",
                      item2Value: 0,
                      description: description,
                      actionCTA: actionCTA,
                      actionCTACollapsed: actionCTACollapsed,
                      action: action,
                      cellType: cellType)
        }

        public static func empty() -> Self {
            return BalanceModel(title: "",
                                value: nil,
                                description: "",
                                actionCTA: "",
                                actionCTACollapsed: "",
                                action: nil)
        }
    }
}
