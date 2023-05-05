//
//  Ocean+ButtonTextCritical.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 05/05/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ButtonTextCritical: ButtonText {
        override func configType() {
            activeBackgroundColor = UIColor.clear
            activeLabelColor = Ocean.color.colorStatusNegativePure
            hoverBackgroundColor = Ocean.color.colorInterfaceLightDown
            hoverLabelColor = Ocean.color.colorStatusNegativePure
            pressedBackgroundColor = Ocean.color.colorInterfaceLightDeep
            pressedLabelColor = Ocean.color.colorStatusNegativePure
            focusedBackgroundColor = Ocean.color.colorInterfaceLightDown
            focusedLabelColor = Ocean.color.colorStatusNegativePure
            disabledBackgroundColor = UIColor.clear
            disabledLabelColor = Ocean.color.colorInterfaceDarkUp
            progressIndicatorStyle = .primary
        }
    }
}
