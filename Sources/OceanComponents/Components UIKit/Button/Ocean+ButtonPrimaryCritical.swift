//
//  Ocean+ButtonPrimaryCritical.swift
//  OceanComponents
//
//  Created by Vini on 21/07/21.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ButtonPrimaryCritical: ButtonPrimary {
        override func configType() {
            activeBackgroundColor = Ocean.color.colorStatusNegativePure
            activeLabelColor = Ocean.color.colorInterfaceLightPure
            hoverBackgroundColor = Ocean.color.colorStatusNegativeDown
            hoverLabelColor = Ocean.color.colorInterfaceLightPure
            pressedBackgroundColor = Ocean.color.colorStatusNegativeDeep
            pressedLabelColor = Ocean.color.colorInterfaceLightPure
            focusedBackgroundColor = Ocean.color.colorStatusNegativeDown
            focusedLabelColor = Ocean.color.colorInterfaceLightPure
            disabledBackgroundColor = Ocean.color.colorInterfaceLightDown
            disabledLabelColor = Ocean.color.colorInterfaceDarkUp
        }
    }
}
