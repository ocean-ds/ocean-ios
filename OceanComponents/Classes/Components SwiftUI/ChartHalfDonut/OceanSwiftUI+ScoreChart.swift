//
//  OceanSwiftUI+ScoreChart.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 04/03/24.
//

import UIKit
import SwiftUI
import OceanTokens
import DGCharts

struct MyChart: UIViewRepresentable {
    let centerText: String
    let entries: [PieChartDataEntry]
    let colors: [UIColor]

    public init(centerText: String = "",
                entries: [PieChartDataEntry],
                colors: [UIColor]) {
        self.centerText = centerText
        self.entries = entries
        self.colors = colors
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.centerAttributedText = buildAttributedString(text: centerText)
        uiView.configurePieChartViewHalfDonut()

        let dataSet = PieChartDataSet(entries: entries)
        dataSet.configureDataSetAppearance()
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
    }

    private func buildAttributedString(text: String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        return NSMutableAttributedString(
            string: text,
            attributes: [
                .font: UIFont(name: Ocean.font.fontFamilyBaseWeightRegular,
                              size: Ocean.font.fontSizeSm) as Any,
                .foregroundColor: Ocean.color.colorInterfaceDarkDeep,
                .paragraphStyle: paragraphStyle
            ])
    }
}


extension OceanSwiftUI {
    // MARK: Parameters

    public class ScoreChartParameters: ObservableObject {
        @Published public var scoreMin: Double
        @Published public var scoreMax: Double {
            didSet {
                self.configureChart()
            }
        }
        @Published public var scoreCurrent: Double {
            didSet {
                self.configureChart()
            }
        }
        @Published public var colorPrimary: UIColor?
        @Published public var colorSecondary: UIColor?

        @Published fileprivate var scoreDifference: Double = 0

        public init(scoreMin: Double = 0,
                    scoreMax: Double = 1000,
                    scoreCurrent: Double = 0,
                    colorPrimary: UIColor? = nil,
                    colorSecondary: UIColor? = nil) {
            self.scoreMin = scoreMin
            self.scoreMax = scoreMax
            self.scoreCurrent = scoreCurrent
            self.colorPrimary = colorPrimary
            self.colorSecondary = colorSecondary
        }

        private func configureChart() {
            calculateDiff()
            setPrimaryColorIfNeed()
            setSecondaryColorIfNeed()
        }

        private func calculateDiff() {
            self.scoreDifference = self.scoreMax - self.scoreCurrent
        }

        private func setPrimaryColorIfNeed() {
            guard let _ = colorPrimary else { return }

            if scoreCurrent < 301 {
                colorPrimary = Ocean.color.colorStatusNegativePure
            } else if scoreCurrent < 500 {
                colorPrimary = Ocean.color.colorStatusNeutralDeep
            } else if scoreCurrent < 700 {
                colorPrimary = Ocean.color.colorStatusPositivePure
            } else {
                colorPrimary = Ocean.color.colorStatusPositiveDeep
            }
        }

        private func setSecondaryColorIfNeed() {
            guard let _ = colorSecondary else { return }
            colorSecondary = Ocean.color.colorInterfaceLightDeep
        }
    }

    public struct ScoreChart: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ScoreChart) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ScoreChartParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: ScoreChartParameters = ScoreChartParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                Spacer()
                VStack {
                    MyChart(centerText: self.parameters.scoreCurrent.toDecimal(),
                            entries: [.init(value: self.parameters.scoreCurrent),
                                      .init(value: self.parameters.scoreDifference)],
                            colors: [self.parameters.colorPrimary!,
                                     self.parameters.colorSecondary!])
                    .frame(height: 100)
                }
                HStack {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = self.parameters.scoreMin.toDecimal()
                    }
                    .padding(.leading, 12)
                    Spacer()
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = self.parameters.scoreMax.toDecimal()
                    }
                }
                .padding(.horizontal, 32)
                Spacer()
            }
            .frame(width: 250, height: 150)
        }

        // MARK: Methods private



        private func getColorForScore() {

        }
    }
}

extension PieChartView {
    func configurePieChartViewHalfDonut() {
        holeRadiusPercent = 0.55
        drawHoleEnabled = true
        rotationEnabled = false
        highlightPerTapEnabled = true
        drawEntryLabelsEnabled = false
        drawCenterTextEnabled = true
        legend.enabled = false
        maxAngle = 180
        rotationAngle = 180
        centerTextOffset = CGPoint(x: 0, y: -10)
    }
}
