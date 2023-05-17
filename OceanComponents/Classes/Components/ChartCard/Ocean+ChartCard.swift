//
//  Ocean+ChartCard.swift
//  Charts
//
//  Created by Acassio Mendonça on 16/05/23.
//

import Foundation
import OceanTokens
import Charts

// fazer o componente em uma scrollView

extension Ocean {
    
    public struct ChartCardModel {
        public var title: String
        public var label: String
        public var items: [ChartCardItemModel]
        public var onItemSelected: ((ChartCardItemModel) -> Void)? = nil
        public var onNothingSelected: (() -> Void)? = nil
        
        public init(title: String,
                    label: String,
                    items: [ChartCardItemModel],
                    onItemSelected: ((ChartCardItemModel) -> Void)? = nil,
                    onNothingSelected: (() -> Void)? = nil) {
            self.title = title
            self.label = label
            self.items = items
            self.onItemSelected = onItemSelected
            self.onNothingSelected = onNothingSelected
        }
    }

    
    public class ChartCard: UIView {
        
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var chartCardModel: ChartCardModel? = nil {
            didSet {
                updateUI()
            }
        }
        
        private var chartView: PieChartView = {
            let chartView = PieChartView()
            
            return chartView
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = Ocean.Typography.heading4()
            
            return label
        }()
        
        private lazy var subtitleLabel: UILabel = {
            let label = Ocean.Typography.description()
            
            return label
        }()
        
        private lazy var titleAndSubtitleStack: StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .leading
            stack.backgroundColor = .blue
            
            stack.add([
                titleLabel,
                subtitleLabel
            ])
            
            return stack
        }()
        
        private lazy var legendItemListStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.backgroundColor = .magenta
            
            return stack
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.backgroundColor = .yellow
            
            let view = UIView()
            view.backgroundColor = .gray
            
            view.oceanConstraints
//                .fill(to: stack)
//                .height(constant: 100)
                .make()
            
            stack.add([
                titleAndSubtitleStack,
//                Spacer(space: Ocean.size.spacingStackXs),
                
                chartView, //.addMargins(horizontal: 84),
                legendItemListStack,
//                Spacer(space: Ocean.size.spacingStackXs),
//                listCaptionStack,
//                view
            ])
            
            return stack
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.addSubviews(contentStack)
            
            contentStack.oceanConstraints
                .fill(to: self)
                .make()
            
            chartView.oceanConstraints
                .height(constant: 280)
                .make()
        }
        
        private func updateUI() {
            setupPieChart()
            
            setupListItems()
            
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        
        private func setupListItems() {
            guard let oceanDonutModel = chartCardModel else { return }
            
            oceanDonutModel.items.forEach { item in
    
                let chartCardItem = ChartCardItem()
                chartCardItem.chartCardItemModel = item
                legendItemListStack.add([chartCardItem])
            }
        }
        
        private func setupPieChart() {
            
            guard let oceanDonutModel = chartCardModel else { return }
            
            var entries: [PieChartDataEntry] = []
            var colors: [UIColor] = []
            oceanDonutModel.items.forEach { item in
                entries.append(PieChartDataEntry(value: item.value,
                                                 data: item.value.toCurrency(symbolSpace: true)))
                colors.append(item.color)
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributedString = NSMutableAttributedString(
                string: "\(oceanDonutModel.title)\n", //"Big Text\n",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 22),
                    .paragraphStyle: paragraphStyle
                ])
            attributedString.append(
                NSAttributedString(
                    string: oceanDonutModel.label, //"Small Text",
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 18),
                        .paragraphStyle: paragraphStyle
                    ]))
            
            chartView.centerAttributedText = attributedString
            
            chartView.holeRadiusPercent = 0.6
            chartView.transparentCircleRadiusPercent = 0.5
            chartView.chartDescription.enabled = false
            chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
            chartView.drawHoleEnabled = true
            chartView.rotationAngle = 0
            chartView.rotationEnabled = false
            chartView.highlightPerTapEnabled = false
            
            // hide/show label no grafico (ainda nao funciona)
            chartView.drawEntryLabelsEnabled = false
            
            // hide/show texto no centro do donut
            chartView.drawCenterTextEnabled = true
            
            chartView.legend.enabled = false
            
            let dataSet = PieChartDataSet(entries: entries)
            
            // hide/show valores no grafico
            dataSet.drawValuesEnabled = false
            dataSet.drawIconsEnabled = false
            
            dataSet.colors = colors
            
            let data = PieChartData(dataSet: dataSet)
            chartView.data = data
            chartView.noDataText = "No data available"
            
            //        chartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .easeInCirc)
        }
    }
}

