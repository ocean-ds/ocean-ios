//
//  BarChartModel.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 06/03/24.
//

public struct BarChartModel {
    public var date: Date
    public var consultationCount: Int

    public init(date: Date, consultationCount: Int) {
        self.date = date
        self.consultationCount = consultationCount
    }
}
