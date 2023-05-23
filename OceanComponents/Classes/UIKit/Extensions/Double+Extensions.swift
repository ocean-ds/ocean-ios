//
//  Double+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 30/08/21.
//

import Foundation

extension Double {
    func toCurrency(symbolSpace: Bool = false) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.numberStyle = .currency
        if symbolSpace {
            formatter.currencySymbol = " R$"
        }
        return formatter.string(from: self as NSNumber)
    }
    
    public func toPercent(withDecimalCase: Int = 1) -> String {
        let valueTruncate = self.rounded()
        if self != valueTruncate {
            let format = "%.\(withDecimalCase.description)f"
            return NSString(format: format as NSString, locale: Locale(identifier: "pt-br"), self).description
        }

        return NSString(format: "%.0f", locale: Locale(identifier: "pt-br"), self).description
    }

    public func toDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
}
