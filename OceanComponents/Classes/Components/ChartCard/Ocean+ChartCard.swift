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
    
    public class ChartCard: UIView, ChartViewDelegate {
        
        struct Constants {
            static let skeletonViewBorderRadius = 140.0
            static let chartContainerViewHeight = 300.0
            static let chartContainerViewWidth = 300.0
            static let dummySkeletonChartViewHeight = 280.0
            static let dummySkeletonChartViewWidth = 280.0
            static let chartViewHeight = 300.0
        }
        
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
               
        private lazy var chartView: PieChartView = {
            let chartView = PieChartView()
            chartView.isSkeletonable = true
            chartView.isHiddenWhenSkeletonIsActive = true
            
            return chartView
        }()
        
        private lazy var dummySkeletonChartView: UIView = {
            let view = UIView()
            
            view.applyRadius(radius: Constants.skeletonViewBorderRadius)
            
            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            view.layer.borderWidth = 0
            
            view.isSkeletonable = true
            view.isUserInteractionDisabledWhenSkeletonIsActive = true
            view.skeletonCornerRadius = Float(Constants.skeletonViewBorderRadius)
            
            return view
        }()
        
        private lazy var chartContainerView: UIView = {
            let view = UIView()
            view.isSkeletonable = true
            view.addSubview(self.chartView)
            view.addSubview(self.dummySkeletonChartView)
            
            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = Ocean.Typography.heading4()
            label.isSkeletonable = true
            label.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            return label
        }()
        
        private lazy var subtitleLabel: UILabel = {
            let label = Ocean.Typography.description()
            label.isSkeletonable = true
            label.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            return label
        }()
        
        private lazy var headerStack: StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .leading
            stack.isSkeletonable = true
            stack.isUserInteractionDisabledWhenSkeletonIsActive = true
            
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
            stack.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            stack.setMargins(bottom: Ocean.size.spacingStackSm)
            
            return stack
        }()
        
        private lazy var bottomCallToAction: Ocean.GroupCTA = {
            let view = Ocean.GroupCTA()
            view.isSkeletonable = true
            view.isHiddenWhenSkeletonIsActive = true
            
            return view
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.isSkeletonable = true
            stack.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            stack.add([
                headerStack,
                chartContainerView,
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
            stack.isUserInteractionDisabledWhenSkeletonIsActive = true
            
            stack.add([
                contentStack,
                Divider(widthConstraint: self.widthAnchor),
                bottomCallToAction
            ])
            
            return stack
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
            
            configureChartCardView()
            setupPieChart()
            setupConstraints()
            
            chartView.delegate = self
            
            let tapRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(handleTapOnHeaderStack(_:))
            )
            
            headerStack.addGestureRecognizer(tapRecognizer)
        }
        
        private func configureChartCardView() {
            self.isSkeletonable = true
            self.isUserInteractionDisabledWhenSkeletonIsActive = true
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
            if items.allSatisfy({ $0.value == 0 }) {
                isSelectable(false)
                return [PieChartDataEntry(value: 1, data: 0)]
            }
            isSelectable(true)
            return items.map { PieChartDataEntry(value: $0.value, data: $0.value) }
        }
        
        private func isSelectable(_ isSelectable: Bool) {
            chartView.isUserInteractionEnabled = isSelectable
            legendItemsListStack.isUserInteractionEnabled = isSelectable
            headerStack.isUserInteractionEnabled = isSelectable
        }
        
        private func buildChartColors() -> [UIColor] {
            if items.allSatisfy({ $0.value == 0 }) {
                return [Ocean.color.colorInterfaceLightDeep]
            }
            
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
                    .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                  size: Ocean.font.fontSizeSm) as Any,
                    .foregroundColor: Ocean.color.colorInterfaceDarkDeep,
                    .paragraphStyle: paragraphStyle
                ])
            
            attributedString.append(
                NSAttributedString(
                    string: "\(title)",
                    attributes: [
                        .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                                      size: Ocean.font.fontSizeXxxs) as Any,
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
            chartView.animate(xAxisDuration: 1,
                              yAxisDuration: 1.5,
                              easingOption: .easeInOutSine)
        }
        
        private func setupConstraints() {
            chartContainerView.oceanConstraints
                .width(constant: Constants.chartContainerViewWidth)
                .height(constant: Constants.chartContainerViewHeight)
                .make()
            
            chartView.oceanConstraints
                .fill(to: chartContainerView)
                .make()
            
            dummySkeletonChartView.oceanConstraints
                .center(to: chartContainerView)
                .width(constant: Constants.dummySkeletonChartViewWidth)
                .height(constant: Constants.dummySkeletonChartViewHeight)
                .make()
            
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
        }
        
        @objc func handleTapOnHeaderStack(_ gestureRecognizer: UITapGestureRecognizer) {
            activeAll()
        }
        
        private func activeAll() {
            chartView.highlightValue(nil, callDelegate: true)
        }
        
        private func updateUI() {
            setupPieChart()
            setupListItems()
            updateBottomCallToAction()
        }
        
        private func setupListItems() {
            guard showLegend else { return }
            
            for (index, item) in items.enumerated() {
                item.onLegendTapped = { [weak self] _ in self?.legendTaped(chartItem: item) }
                addLegendItemToStack(item: item, at: index)
            }
        }
        
        private func legendTaped(chartItem: ChartCardItem) {
            
            changeOpacityOfPieChart(except: chartItem)
          
        }
        
        private func updateBottomCallToAction() {
            bottomCallToAction.text = bottomCTAText
            bottomCallToAction.onTouch = bottomCTAAction
            bottomCallToAction.isHidden = bottomCTAText.isEmpty == true
        }
        
        private func addLegendItemToStack(item: ChartCardItem, at index: Int) {
            legendItemsListStack.add([item])
            if index < items.count - 1 {
                legendItemsListStack.add([Divider().addMargins(horizontal: Ocean.size.spacingStackXs)])
            }
        }
        
        private func changeOpacityOfPieChart(except selectedItem: ChartCardItem?) {
            let isFirstTime = items.allSatisfy { $0.isActive }
            var itemAlreadySelected = false
            
            if let selectedItem = selectedItem {
                itemAlreadySelected = items.contains(where: { $0 === selectedItem && $0.isActive })
            }
            
            if let selectedItem = selectedItem, (isFirstTime || !itemAlreadySelected) {
                onSelect?(selectedItem)
            }
            
            items.enumerated().forEach { index, item in
                var newColor: UIColor!
                
                if (!isFirstTime && itemAlreadySelected) ||
                    item == selectedItem || selectedItem == nil {
                    item.activated()
                    newColor = item.color.withAlphaComponent(1.0)
                } else {
                    item.inactivated()
                    newColor = item.color.withAlphaComponent(Ocean.size.opacityLevelLight)
                }
                updateItemAndColor(item: item, color: newColor, index: index)
            }
            chartView.notifyDataSetChanged()
        }
        
        private func updateItemAndColor(item: ChartCardItem, color: UIColor, index: Int) {
            item.setOpacity(opacity: color.cgColor.alpha)
            if let dataSet = chartView.data?.dataSets[0] as? PieChartDataSet {
                dataSet.colors[index] = color
            }
        }
        
        // MARK: ChartViewDelegate
        
        public func chartValueSelected(_ chartView: ChartViewBase,
                                       entry: ChartDataEntry,
                                       highlight: Highlight) {
            let chartItem = items[Int(highlight.x)]
            changeOpacityOfPieChart(except: chartItem)
        }
        
        public func chartValueNothingSelected(_ chartView: ChartViewBase) {
            changeOpacityOfPieChart(except: nil)
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
        rotationAngle = 270
    }
}
