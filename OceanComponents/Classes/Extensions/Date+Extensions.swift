//
//  Date+Extensions.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/05/22.
//

import Foundation

extension Date {
    public var onlyDate: Date {
        let calender = Calendar.current
        var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = NSTimeZone.system
        return calender.date(from: dateComponents) ?? self
    }

    public func shortDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale.init(identifier: "pt-br")
        return formatter.string(from: self)
    }
}
