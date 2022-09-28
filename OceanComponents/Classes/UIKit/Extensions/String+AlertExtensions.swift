//
//  String+AlertExtensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 28/09/22.
//

import Foundation
import OceanTokens

public extension String {
    func toOceanAlertStatus() -> Ocean.AlertBox.Status? {
        switch self.lowercased() {
        case "info": return Ocean.AlertBox.Status.info
        case "error": return Ocean.AlertBox.Status.error
        case "warning": return Ocean.AlertBox.Status.warning
        case "success": return Ocean.AlertBox.Status.success
        default: return nil
        }
    }
}
