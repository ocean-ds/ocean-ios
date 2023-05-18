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
            
            stack.add([
                titleLabel,
                subtitleLabel
            ])
            
            return stack
        }()
        
        private lazy var legendItemListStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            
            return stack
        }()
        
        private lazy var ctaBottom: Ocean.GroupCTA = {
            let view = Ocean.GroupCTA()
            view.text = "Call To Action"
            view.onTouch = {
                view.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    view.isLoading = false
                }
            }
            return view
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            
            stack.add([
                titleAndSubtitleStack,
                chartView,
                legendItemListStack,
                Spacer(space: Ocean.size.spacingStackSm)
            ])
            
            return stack
        }()
        
        private lazy var ctaStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            
            stack.add([
                Divider(widthConstraint: self.widthAnchor),
                ctaBottom
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
            self.addSubviews(ctaStack)
            
//            self.ocean.radius.applyMd()
//            self.ocean.borderWidth.applyHairline()
            
            self.layer.borderWidth = 10
            self.layer.borderColor = UIColor.red.cgColor
            
//            self.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
            
            contentStack.oceanConstraints
//                .fill(to: self)
                .topToBottom(to: self)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .make()
            
            legendItemListStack.oceanConstraints
                .leadingToLeading(to: self, constant: 24)
                .trailingToTrailing(to: self, constant: -24)
                .make()
            
            titleAndSubtitleStack.oceanConstraints
                .topToTop(to: self, constant: 24)
                .leadingToLeading(to: self, constant: 24)
                .trailingToTrailing(to: self, constant: -24)
                .make()
            
            chartView.oceanConstraints
                .height(constant: 300)
                .make()
            
            ctaStack.oceanConstraints
                .topToBottom(to: contentStack)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .make()
        }
        
        private func updateUI() {
            setupPieChart()
            
            setupListItems()
            
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        
        private func setupListItems() {
            guard let model = chartCardModel else { return }

            model.items.enumerated().forEach { (index, item) in
                let chartCardItem = ChartCardItem()
                chartCardItem.chartCardItemModel = item
                legendItemListStack.add([chartCardItem])
                
                if index < model.items.count - 1 {
                    legendItemListStack.add([Divider()])
                }
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
                string: "\(oceanDonutModel.title)\n",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 22),
                    .paragraphStyle: paragraphStyle
                ])
            attributedString.append(
                NSAttributedString(
                    string: oceanDonutModel.label,
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

