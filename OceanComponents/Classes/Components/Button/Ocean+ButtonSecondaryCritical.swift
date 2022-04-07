//
//  Ocean+ButtonSecondaryCritical.swift
//  OceanComponents
//
//  Created by Leticia Fernandes on 07/04/22.
//

import Foundation
import OceanTokens

extension Ocean {
    public class ButtonSecondaryCritical: ButtonSecondary {
        override func configType() {
            activeBackgroundColor = Ocean.color.colorStatusNegativeUp
            activeLabelColor = Ocean.color.colorStatusNegativePure
            hoverBackgroundColor = Ocean.color.colorInterfaceLightDown
            hoverLabelColor = Ocean.color.colorStatusNegativePure
            pressedBackgroundColor = Ocean.color.colorInterfaceLightDeep
            pressedLabelColor = Ocean.color.colorStatusNegativePure
            focusedBackgroundColor = Ocean.color.colorInterfaceLightDown
            focusedLabelColor = Ocean.color.colorStatusNegativePure
            disabledBackgroundColor = Ocean.color.colorInterfaceLightDown
            disabledLabelColor = Ocean.color.colorInterfaceDarkUp
        }
    }
}
