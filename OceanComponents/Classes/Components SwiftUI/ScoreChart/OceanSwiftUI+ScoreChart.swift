//
//  OceanSwiftUI+ScoreChart.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 04/03/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class ScoreChartParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
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
        @Published fileprivate var colorPrimary: UIColor = Ocean.color.colorStatusNegativePure
        @Published fileprivate var colorSecondary: UIColor = Ocean.color.colorInterfaceLightDeep
        @Published fileprivate var scoreDifference: Double = 0

        public init(title: String = "",
                    subtitle: String = "",
                    scoreMin: Double = 0,
                    scoreMax: Double = 1000,
                    scoreCurrent: Double = 0) {
            self.title = title
            self.subtitle = subtitle
            self.scoreMin = scoreMin
            self.scoreMax = scoreMax
            self.scoreCurrent = scoreCurrent
        }

        private func configureChart() {
            calculateDiff()
            setPrimaryColorIfNeed()
        }

        private func calculateDiff() {
            self.scoreDifference = self.scoreMax - self.scoreCurrent
        }

        private func setPrimaryColorIfNeed() {
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
                headerView
                VStack {
                    ChartView(centerText: self.parameters.scoreCurrent.toDecimal(),
                            entries: [.init(value: self.parameters.scoreCurrent),
                                      .init(value: self.parameters.scoreDifference)],
                            colors: [self.parameters.colorPrimary,
                                     self.parameters.colorSecondary])
                    .frame(height: 100)
                    labelsView
                    Spacer()
                }
                Spacer()
            }
        }

        private var headerView: some View {
            HStack {
                VStack(alignment: .leading) {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = self.parameters.title
                    }
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxxs)
                    OceanSwiftUI.Typography.description { label in
                        label.parameters.text = self.parameters.subtitle
                    }
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }
                Spacer()
            }
        }

        private var labelsView: some View {
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
            .padding(.horizontal, 87)
        }

        // MARK: Methods private
    }
}
