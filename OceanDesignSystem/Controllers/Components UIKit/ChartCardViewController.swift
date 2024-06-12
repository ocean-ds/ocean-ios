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
    
    lazy var scrollView: UIScrollView = { return UIScrollView(frame: .zero) }()
    lazy var scrollableContentView: UIView = { UIView(frame: .zero) }()
    
    var chartCardFull: [Ocean.ChartCardItem] = [
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 1"
            item.value = 123.00
            item.color = Ocean.color.colorComplementaryPure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 2"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusWarningPure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 3"
            item.subtitle = "Subtitle 3"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusPositivePure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 4"
            item.subtitle = "Subtitle 4"
            item.value = 123.00
            item.color = Ocean.color.colorBrandPrimaryDown
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 5"
            item.subtitle = "Subtitle 5"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusNegativePure
            item.valueRepresentationType = .percent
            
            return item
        }()
    ]
    
    lazy var chartCardView: Ocean.ChartCard = {
        let chart = Ocean.ChartCard()
        chart.title = "Chart Card"
        chart.subtitle = "Full"
        chart.valueCenterDonut = "8.0000"
        chart.labelCenterDonut = "Label"
        chart.showLegend = true
        chart.onSelect = { model in
            self.showSnackBar(message: "Selected: \(model?.title ?? "")")
        }
        chart.bottomCTAText = "CTA Text"
        chart.bottomCTAAction =  {
            self.showSnackBar(message: "CTA action")
        }
        chart.items = chartCardFull
        return chart
    }()
    
    var chartCardEmptyState: [Ocean.ChartCardItem] = [
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 1"
            item.subtitle = "Subtitle 1"
            item.tooltipMessage = "message tooltip"
            item.value = 0
            item.color = Ocean.color.colorInterfaceLightDeep
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 2"
            item.subtitle = "Subtitle 2"
            item.tooltipMessage = "message tooltip"
            item.value = 0
            item.color = Ocean.color.colorInterfaceLightDeep
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 3"
            item.subtitle = "Subtitle 3"
            item.tooltipMessage = "message tooltip"
            item.value = 0
            item.color = Ocean.color.colorInterfaceLightDeep
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 4"
            item.subtitle = "Subtitle 4"
            item.tooltipMessage = "message tooltip"
            item.value = 0
            item.color = Ocean.color.colorInterfaceLightDeep
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 5"
            item.subtitle = "Subtitle 5"
            item.tooltipMessage = "message tooltip"
            item.value = 0
            item.color = Ocean.color.colorInterfaceLightDeep
            item.valueRepresentationType = .percent
            
            return item
        }()
    ]
    
    lazy var chartCardViewEmptyState: Ocean.ChartCard = {
        let chart = Ocean.ChartCard()
        chart.title = "Chart Card"
        chart.subtitle = "EmptyState"
        chart.valueCenterDonut = "0"
        chart.labelCenterDonut = "Label"
        chart.showLegend = true
        chart.onSelect = { model in
            self.showSnackBar(message: "Selected: \(model?.title ?? "")")
        }
        chart.bottomCTAText = "CTA Text"
        chart.bottomCTAAction =  {
            self.showSnackBar(message: "CTA action")
        }
        chart.items = chartCardEmptyState
        return chart
    }()
    
    var chartCardSkeleton: [Ocean.ChartCardItem] = [
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 1"
            item.subtitle = "Subtitle 1"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorComplementaryPure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 2"
            item.subtitle = "Subtitle 2"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusWarningPure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 3"
            item.subtitle = "Subtitle 3"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusPositivePure
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 4"
            item.subtitle = "Subtitle 4"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorBrandPrimaryDown
            item.valueRepresentationType = .percent
            
            return item
        }(),
        {
            let item = Ocean.ChartCardItem()
            item.title = "Title 5"
            item.subtitle = "Subtitle 5"
            item.tooltipMessage = "message tooltip"
            item.value = 123.00
            item.color = Ocean.color.colorStatusNegativePure
            item.valueRepresentationType = .percent
            
            return item
        }()
    ]
    
    lazy var chartCardViewSkeleton: Ocean.ChartCard = {
        let chart = Ocean.ChartCard()
        chart.title = "Chart Card"
        chart.subtitle = "Full"
        chart.valueCenterDonut = "8.0000"
        chart.labelCenterDonut = "Label"
        chart.showLegend = true
        chart.onSelect = { model in
            self.showSnackBar(message: "Selected: \(model?.title ?? "")")
        }
        chart.bottomCTAText = "CTA Text"
        chart.bottomCTAAction =  {
            self.showSnackBar(message: "CTA action")
        }
        chart.items = chartCardSkeleton
        return chart
    }()
    
    private lazy var contentStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Ocean.size.spacingStackXs
        
        stack.add([
            chartCardView,
            chartCardViewEmptyState,
            chartCardViewSkeleton
        ])
        
        stack.setMargins(allMargins: Ocean.size.spacingStackXs)
        
        return stack
    }()
    
    private func showSnackBar(message: String) {
        let snack = Ocean.Snackbar()
        snack.state = .created
        snack.snackbarText = message
        
        snack.show(in: view)
    }
    
    public override func viewDidLoad() {
        self.addScrollView()
        self.scrollableContentView.backgroundColor = .white
        self.scrollView.backgroundColor = .white
        
        scrollableContentView.addSubview(contentStack)
        
        contentStack.oceanConstraints
            .fill(to: scrollableContentView)
            .make()
        
        chartCardViewSkeleton.showAnimatedSkeleton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollableContentView)
        
        applyScrollViewDefaultContraints()
    }
    
    private func applyScrollViewDefaultContraints() {
        scrollView.oceanConstraints
            .fill(to: view)
            .make()
        
        scrollableContentView.oceanConstraints
            .fill(to: scrollView)
            .width(to: view)
            .make()
    }
}
