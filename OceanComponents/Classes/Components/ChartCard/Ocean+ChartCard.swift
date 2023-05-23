//
//  Ocean+ChartCard.swift
//  Charts
//
//  Created by Acassio Mendonça on 16/05/23.
//

import Foundation
import OceanTokens
import Charts

extension Ocean {
    
    struct ConstantsChartCard {
        static let skeletonViewBorderRadius = 140.0
        static let skeletonViewHeight = 280.0
        static let skeletonViewWidth = 280.0
        static let chartViewHeight = 300.0
    }
    
    public class ChartCard: UIView, ChartViewDelegate {
        
        // MARK: - Properties
        
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
        
        public var valueCenterDonut: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var labelCenterDonut: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var items: [ChartCardItem] = [] {
            didSet {
                updateUI()
            }
        }
        
        public var showLegend: Bool = true {
            didSet {
                updateUI()
            }
        }
        
        public var onSelect: ((ChartCardItem?) -> Void)? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var bottomCTAText: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var bottomCTAAction: (() -> Void)? = nil {
            didSet {
                updateUI()
            }
        }
        
        // MARK: - Properties private
        
        private var chartView: PieChartView = {
            let chartView = PieChartView()
            
            return chartView
        }()
        
        private var selectedItem: ChartCardItem? = nil
        
        private lazy var titleLabel: UILabel = {
            let label = Ocean.Typography.heading4()
            label.isSkeletonable = true
            
            return label
        }()
        
        private lazy var subtitleLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.isSkeletonable = true
            
            return label
        }()
        
        private lazy var headerStack: StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .leading
            stack.isSkeletonable = true
            
            stack.add([
                titleLabel,
                subtitleLabel
            ])
            
            stack.setMargins(top: Ocean.size.spacingStackSm,
                             left: Ocean.size.spacingStackSm,
                             right: Ocean.size.spacingInsetSm)
            
            return stack
        }()
        
        private lazy var legendItemsListStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.isSkeletonable = true
            
            stack.setMargins(bottom: Ocean.size.spacingStackSm)
            
            return stack
        }()
        
        private lazy var bottomCallToAction: Ocean.GroupCTA = {
            let view = Ocean.GroupCTA()
            return view
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.isSkeletonable = true
            
            stack.add([
                headerStack,
                chartView,
                legendItemsListStack
            ])
            
            return stack
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.isSkeletonable = true
            
            stack.add([
                contentStack,
                Divider(widthConstraint: self.widthAnchor),
                bottomCallToAction
            ])
            
            return stack
        }()
        
        private lazy var viewForSkeletonView: UIView = {
            let view = UIView()
            
            view.applyRadius(radius: ConstantsChartCard.skeletonViewBorderRadius)
            
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            view.layer.borderWidth = 0
            
            view.isSkeletonable = true
            view.skeletonCornerRadius = Float(ConstantsChartCard.skeletonViewBorderRadius)
            
            return view
        }()
        
        // MARK: - Constructors
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Functions private
        
        private func setupUI() {
            self.addSubviews(mainStack)
            self.addSubviews(viewForSkeletonView)
            
            configureChartCardView()
            setupPieChart()
            setupConstraints()
            
            chartView.delegate = self
        }
        
        private func configureChartCardView() {
            self.isSkeletonable = true
            self.ocean.radius.applyMd()
            self.ocean.borderWidth.applyHairline()
            self.layer.borderColor = Ocean.color.colorInterfaceLightDown.cgColor
        }
        
        private func setupPieChart() {
            configureChartLabels()
            let entries = buildChartEntries()
            let colors = buildChartColors()
            configureChartAppearance()
            createAndSetPieChartData(entries: entries, colors: colors)
            animateChartView()
        }
        
        private func configureChartLabels() {
            titleLabel.text = title
            subtitleLabel.text = subtitle
        }
        
        private func buildChartEntries() -> [PieChartDataEntry] {
            return items.map { PieChartDataEntry(value: $0.value, data: $0.value.toCurrency(symbolSpace: true)) }
        }
        
        private func buildChartColors() -> [UIColor] {
            return items.map { $0.color }
        }
        
        private func configureChartAppearance() {
            let attributedString = buildAttributedString()
            chartView.centerAttributedText = attributedString
            chartView.configurePieChartViewAparence()
        }
        
        private func buildAttributedString() -> NSMutableAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributedString = NSMutableAttributedString(
                string: "\(valueCenterDonut)\n",
                attributes: [
                    .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeSm) as Any,
                    .foregroundColor: Ocean.color.colorInterfaceDarkDeep,
                    .paragraphStyle: paragraphStyle
                ])
            
            attributedString.append(
                NSAttributedString(
                    string: "\(title)",
                    attributes: [
                        .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXxxs) as Any,
                        .foregroundColor: Ocean.color.colorInterfaceDarkDown,
                        .paragraphStyle: paragraphStyle
                    ]))
            
            return attributedString
        }
        
        private func createAndSetPieChartData(entries: [PieChartDataEntry], colors: [UIColor]) {
            let dataSet = PieChartDataSet(entries: entries)
            dataSet.configureDataSetAppearance()
            dataSet.colors = colors
            
            let data = PieChartData(dataSet: dataSet)
            chartView.data = data
        }
        
        private func animateChartView() {
            chartView.animate(xAxisDuration: 1, yAxisDuration: 1.5, easingOption: .easeInOutSine)
        }
        
        private func setupConstraints() {
            viewForSkeletonView.oceanConstraints
                .height(constant: ConstantsChartCard.skeletonViewHeight)
                .width(constant: ConstantsChartCard.skeletonViewWidth)
                .centerY(to: chartView)
                .centerX(to: chartView)
                .make()
            
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
            
            chartView.oceanConstraints
                .height(constant: ConstantsChartCard.chartViewHeight)
                .make()
        }
        
        private func updateUI() {
            setupPieChart()
            setupListItems()
            updateBottomCallToAction()
        }
        
        private func setupListItems() {
            guard showLegend else { return }
            
            for (index, item) in items.enumerated() {
                setupItem(item: item, index: index)
            }
        }
        
        private func updateBottomCallToAction() {
            bottomCallToAction.text = bottomCTAText
            bottomCallToAction.onTouch = bottomCTAAction
            bottomCallToAction.isHidden = bottomCTAText.isEmpty == true
        }
        
        private func setupItem(item: ChartCardItem, index: Int) {
            item.onSelect = { [weak self] _ in self?.handleItemSelected(item, at: index) }
            item.onDeselect = { [weak self] _ in self?.handleItemDeselected(item) }
            
            addLegendItemToStack(item: item, at: index)
        }
        
        private func handleItemSelected(_ item: ChartCardItem, at index: Int) {
            onSelect?(item)
            legendTapped(item)
            chartView.highlightValue(x: Double(index), dataSetIndex: 0, callDelegate: false)
        }
        
        private func handleItemDeselected(_ item: ChartCardItem) {
            legendTapped(item)
            chartView.highlightValue(nil, callDelegate: false)
        }
        
        private func addLegendItemToStack(item: ChartCardItem, at index: Int) {
            legendItemsListStack.add([item])
            if index < items.count - 1 {
                legendItemsListStack.add([Divider().addMargins(horizontal: Ocean.size.spacingStackXs)])
            }
        }
        
        private func legendTapped(_ tappedItem: ChartCardItem) {
            toggleSelectionForItems(except: tappedItem)
            onSelect?(tappedItem)
            changeOpacityOfUnselectedItems(except: tappedItem)
        }
        
        private func toggleSelectionForItems(except selectedItem: ChartCardItem) {
            self.selectedItem?.unhighlight()
            
            if selectedItem != self.selectedItem {
                selectedItem.highlight()
                self.selectedItem = selectedItem
            } else {
                self.selectedItem = nil
            }
        }
        
        private func changeOpacityOfUnselectedItems(except selectedItem: ChartCardItem) {
            items.enumerated().forEach { index, item in
                let newColor: UIColor
                if item !== selectedItem {
                    item.setOpacity(opacity: Ocean.size.opacityLevelMedium)
                    newColor = item.color.withAlphaComponent(Ocean.size.opacityLevelLight)
                } else {
                    item.setOpacity(opacity: 1.0)
                    newColor = item.color.withAlphaComponent(1.0)
                }
                if let dataSet = chartView.data?.dataSets[0] as? PieChartDataSet {
                    dataSet.colors[index] = newColor
                }
            }
        }
        
        // MARK: ChartViewDelegate
        
        public func chartValueSelected(_ chartView: ChartViewBase,
                                       entry: ChartDataEntry,
                                       highlight: Highlight) {
            let chartItem = items[Int(highlight.x)]
            
            self.legendTapped(chartItem)
        }
        
        public func chartValueNothingSelected(_ chartView: ChartViewBase) {
            self.selectedItem?.unhighlight()
            self.selectedItem = nil
            
            items.enumerated().forEach { index, item in
                item.setOpacity(opacity: 1.0)
                if let dataSet = chartView.data?.dataSets[0] as? PieChartDataSet {
                    dataSet.colors[index] = item.color.withAlphaComponent(1.0)
                }
            }
        }
    }
}

// MARK: PieChartDataSet

extension PieChartDataSet {
    func configureDataSetAppearance() {
        drawValuesEnabled = false
        drawIconsEnabled = false
        selectionShift = 0.0
    }
}

// MARK: PieChartView

extension PieChartView {
    func configurePieChartViewAparence() {
        holeRadiusPercent = 0.65
        transparentCircleRadiusPercent = 0.5
        chartDescription.enabled = false
        setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        drawHoleEnabled = true
        rotationAngle = 0
        rotationEnabled = false
        highlightPerTapEnabled = true
        drawEntryLabelsEnabled = false
        drawCenterTextEnabled = true
        legend.enabled = false
    }
}
