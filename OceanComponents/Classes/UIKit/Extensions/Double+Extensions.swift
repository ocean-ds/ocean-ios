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
}
