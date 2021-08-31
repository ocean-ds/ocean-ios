//
//  Double+Extensions.swift
//  OceanComponents
//
//  Created by Vini on 30/08/21.
//

import Foundation

extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}
