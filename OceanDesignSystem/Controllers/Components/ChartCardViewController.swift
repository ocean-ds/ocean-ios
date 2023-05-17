//
//  ChartCardViewController.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 15/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import Charts
import OceanTokens

class ChartCardViewController: UIViewController {
    
    lazy var listOfOceanItems = [
        Ocean.ChartCardItemModel(
            title: "Title 1",
            subtitle: "Subtitle 1",
            toltipMessage: "Tooltipe Message 1",
            value: 12.0,
            color: Ocean.color.colorComplementaryPure
        ),
        Ocean.ChartCardItemModel(
            title: "Title 2",
            subtitle: "Subtitle 2",
            toltipMessage: "Tooltipe Message 2",
            value: 18.0,
            color: Ocean.color.colorStatusNeutralPure
        ),
        Ocean.ChartCardItemModel(
            title: "Title 3",
            subtitle: "Subtitle 3",
            toltipMessage: "Tooltipe Message 3",
            value: 10.0,
            color: Ocean.color.colorStatusPositivePure
        ),
        Ocean.ChartCardItemModel(
            title: "Title 4",
            subtitle: "Subtitle 4",
            toltipMessage: "Tooltipe Message 4",
            value: 35.0,
            color: Ocean.color.colorBrandPrimaryDown
        ),
        Ocean.ChartCardItemModel(
            title: "Title 5",
            subtitle: "Subtitle 5",
            toltipMessage: "Tooltipe Message 5",
            value: 25.0,
            color: Ocean.color.colorStatusNegativePure
        )
    ]
    
    lazy var chartCardModel: Ocean.ChartCardModel = {
        let chart = Ocean.ChartCardModel(
            title: "100",
            label: "Label",
            items: listOfOceanItems
        )
        
        return chart
    }()
    
    lazy var chartCardView: Ocean.ChartCard = {
        let chart = Ocean.ChartCard()
        chart.backgroundColor = .red
        chart.title = "Title"
        chart.subtitle = "Subtitle"
        chart.chartCardModel = chartCardModel
        return chart
    }()
}
