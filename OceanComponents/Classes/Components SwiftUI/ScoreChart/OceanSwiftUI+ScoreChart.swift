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
        @Published public var minValue: Double
        @Published public var maxValue: Double {
            didSet {
                self.calculateDiff()
            }
        }
        @Published public var currentValue: Double {
            didSet {
                self.calculateDiff()
            }
        }
        @Published fileprivate var diffValue: Double = 0

        public init(title: String = "",
                    subtitle: String = "",
                    minValue: Double = 0,
                    maxValue: Double = 1000,
                    currentValue: Double = 0) {
            self.title = title
            self.subtitle = subtitle
            self.minValue = minValue
            self.maxValue = maxValue
            self.currentValue = currentValue
        }

        private func calculateDiff() {
            self.diffValue = self.maxValue - self.currentValue
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
                    ChartView(currentValue: parameters.currentValue, diffValue: parameters.diffValue)
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
                    label.parameters.text = self.parameters.minValue.toDecimal()
                }
                .padding(.leading, 12)
                Spacer()
                OceanSwiftUI.Typography.caption { label in
                    label.parameters.text = self.parameters.maxValue.toDecimal()
                }
            }
            .padding(.horizontal, 87)
        }

        // MARK: Methods private
    }
}
