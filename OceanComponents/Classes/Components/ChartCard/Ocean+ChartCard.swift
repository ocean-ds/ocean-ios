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
        
        struct ConstantsChartCard {
            static let skeletonViewBorderRadius = 140.0
            static let skeletonViewHeight = 300.0
            static let skeletonViewWidth = 300.0
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
        
        private var selectedItem: ChartCardItem? = nil
        
        private lazy var chartView: PieChartView = {
            let chartView = PieChartView()
            chartView.isSkeletonable = true
            chartView.isHiddenWhenSkeletonIsActive = true
            
            return chartView
        }()
        
        private lazy var dummySkeletonChartView: UIView = {
            let view = UIView()

            view.applyRadius(radius: ConstantsChartCard.skeletonViewBorderRadius)

            view.backgroundColor = .clear
            view.isUserInteractionEnabled = false
            view.layer.borderWidth = 0

            view.isSkeletonable = true
            view.isUserInteractionDisabledWhenSkeletonIsActive = true
            view.skeletonCornerRadius = Float(ConstantsChartCard.skeletonViewBorderRadius)

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
                .width(constant: ConstantsChartCard.skeletonViewHeight)
                .height(constant: ConstantsChartCard.skeletonViewHeight)
                .make()
            
            chartView.oceanConstraints
                .fill(to: chartContainerView)
                .make()
            
            dummySkeletonChartView.oceanConstraints
                .center(to: chartContainerView)
                .width(constant: 280)
                .height(constant: 280)
                .make()
            
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
        }
        
        @objc func handleTapOnHeaderStack(_ gestureRecognizer: UITapGestureRecognizer) {
            deselectAllItems()
//            for (index, item) in items {
//                item.deselected()
//            }
//            chartView.highlightValue(nil, callDelegate: true)
        }
        
        private func deselectAllItems() {
            for (index, item) in items {
                item.inactivated()
            }
            chartView.highlightValue(nil, callDelegate: true)
//            chartView.highlightValue(nil, callDelegate: true)
//            selectedItem = nil
//            toggleSelectionForItems(except: nil)
        }
        
        private func updateUI() {
            setupPieChart()
            setupListItems()
            updateBottomCallToAction()
        }
        
        private func setupListItems() {
            guard showLegend else { return }
            
            for (index, item) in items.enumerated() {
//                setupItem(item: item, index: index)
                addLegendItemToStack(item: item, at: index)
            }
        }
        
        private func updateBottomCallToAction() {
            bottomCallToAction.text = bottomCTAText
            bottomCallToAction.onTouch = bottomCTAAction
            bottomCallToAction.isHidden = bottomCTAText.isEmpty == true
        }
        
//        private func setupItem(item: ChartCardItem, index: Int) {
//            item.onSelect = { [weak self] _ in self?.handleItemSelected(item, at: index) }
//           item.onDeselect = { [weak self] _ in self?.handleItemDeselected(item) }
//
//            addLegendItemToStack(item: item, at: index)
//        }
        
//        private func handleItemSelected(_ item: ChartCardItem, at index: Int) {
//            onSelect?(item)
//            legendTapped(item)
//           chartView.highlightValue(x: Double(index), dataSetIndex: 0, callDelegate: false)
//        }
        
//        private func handleItemDeselected(_ item: ChartCardItem) {
//           legendTapped(item)
//            deselectAllItems()
//        }
        
        private func addLegendItemToStack(item: ChartCardItem, at index: Int) {
            legendItemsListStack.add([item])
            if index < items.count - 1 {
                legendItemsListStack.add([Divider().addMargins(horizontal: Ocean.size.spacingStackXs)])
            }
        }
        
//        private func legendTapped(_ tappedItem: ChartCardItem) {
//            toggleSelectionForItems(except: tappedItem)
//            changeOpacityOfUnselectedItems(except: tappedItem)
//        }
        
//        private func toggleSelectionForItems(except selectedItem: ChartCardItem?) {
//
//            if let item = selectedItem, item != self.selectedItem {
//                item.selected()
//                onSelect?(item)
//                self.selectedItem = item
//            } else {
//                self.selectedItem?.deselected()
//                chartView.highlightValue(nil, callDelegate: true)
//                self.selectedItem = nil
//            }
//        }
        
        private func changeOpacityOfPieChart(except selectedItem: ChartCardItem?) {
            items.enumerated().forEach { index, item in
                let newColor: UIColor
                if let selectedItem = selectedItem, item !== selectedItem {
                    newColor = item.color.withAlphaComponent(Ocean.size.opacityLevelLight)
                } else {
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
            changeOpacityOfPieChart(except: chartItem)
            for (index, item) in items {
                if item == chartItem {
                    item.selected()
                } else {
                    item.deselected()
                }
            }
//            self.legendTapped(chartItem)
        }
        
        public func chartValueNothingSelected(_ chartView: ChartViewBase) {
//            self.selectedItem?.deselected()
//            self.selectedItem = nil
            
            changeOpacityOfPieChart(except: nil)
            
//            changeOpacityOfUnselectedItems(except: nil)
            
//            items.enumerated().forEach { index, item in
//                item.setOpacity(opacity: 1.0)
//                if let dataSet = chartView.data?.dataSets[0] as? PieChartDataSet {
//                    dataSet.colors[index] = item.color.withAlphaComponent(1.0)
//                }
//            }
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
