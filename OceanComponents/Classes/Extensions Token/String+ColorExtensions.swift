//
//  String+ColorExtensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/08/22.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanColor(altColor: UIColor = Ocean.color.colorInterfaceDarkDown) -> UIColor {
        switch self.lowercased() {
        case "colorbrandprimarydeep": return Ocean.color.colorBrandPrimaryDeep
        case "colorbrandprimarydown": return Ocean.color.colorBrandPrimaryDown
        case "colorbrandprimarypure": return Ocean.color.colorBrandPrimaryPure
        case "colorbrandprimaryup": return Ocean.color.colorBrandPrimaryUp
        case "colorcomplementarydeep": return Ocean.color.colorComplementaryDeep
        case "colorcomplementarydown": return Ocean.color.colorComplementaryDown
        case "colorcomplementarypure": return Ocean.color.colorComplementaryPure
        case "colorcomplementaryup": return Ocean.color.colorComplementaryUp
        case "colorhighlightdeep": return Ocean.color.colorHighlightDeep
        case "colorhighlightdown": return Ocean.color.colorHighlightDown
        case "colorhighlightpure": return Ocean.color.colorHighlightPure
        case "colorhighlightup": return Ocean.color.colorHighlightUp
        case "colorinterfacedarkdeep": return Ocean.color.colorInterfaceDarkDeep
        case "colorinterfacedarkdown": return Ocean.color.colorInterfaceDarkDown
        case "colorinterfacedarkpure": return Ocean.color.colorInterfaceDarkPure
        case "colorinterfacedarkup": return Ocean.color.colorInterfaceDarkUp
        case "colorinterfacelightdeep": return Ocean.color.colorInterfaceLightDeep
        case "colorinterfacelightdown": return Ocean.color.colorInterfaceLightDown
        case "colorinterfacelightpure": return Ocean.color.colorInterfaceLightPure
        case "colorinterfacelightup": return Ocean.color.colorInterfaceLightUp
        case "colorstatusnegativedeep": return Ocean.color.colorStatusNegativeDeep
        case "colorstatusnegativedown": return Ocean.color.colorStatusNegativeDown
        case "colorstatusnegativepure": return Ocean.color.colorStatusNegativePure
        case "colorstatusnegativeup": return Ocean.color.colorStatusNegativeUp
        case "colorstatusneutraldeep", "colorstatuswarningdeep": return Ocean.color.colorStatusWarningDeep
        case "colorstatusneutraldown", "colorstatuswarningdown": return Ocean.color.colorStatusWarningDown
        case "colorstatusneutralpure", "colorstatuswarningpure": return Ocean.color.colorStatusWarningPure
        case "colorstatusneutralup", "colorstatuswarningup": return Ocean.color.colorStatusWarningUp
        case "colorstatuspositivedeep": return Ocean.color.colorStatusPositiveDeep
        case "colorstatuspositivedown": return Ocean.color.colorStatusPositiveDown
        case "colorstatuspositivepure": return Ocean.color.colorStatusPositivePure
        case "colorstatuspositiveup": return Ocean.color.colorStatusPositiveUp
        default: return altColor
        }
    }
}
