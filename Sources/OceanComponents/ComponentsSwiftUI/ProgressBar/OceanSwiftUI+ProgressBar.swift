//
//  OceanSwiftUI+ProgressBar.swift
//  DGCharts
//
//  Created by Renan Massaroto on 21/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class ProgressBarParameters: ObservableObject {
        @Published public var progress: Float
        @Published public var showValue: Bool
        @Published public var padding: EdgeInsets

        public init(progress: Float = 0,
                    showValue: Bool = true,
                    padding: EdgeInsets = .init(top: Ocean.size.spacingStackXxs,
                                                leading: Ocean.size.spacingStackXs,
                                                bottom: Ocean.size.spacingStackXxs,
                                                trailing: Ocean.size.spacingStackXs)) {
            self.progress = progress
            self.showValue = showValue
            self.padding = padding
        }
    }

    public struct ProgressBar: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ProgressBar) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ProgressBarParameters

        // MARK: Private properties

        @State private var progressWidth: CGFloat = .zero

        // MARK: Constructors

        public init(parameters: ProgressBarParameters = ProgressBarParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(Ocean.color.colorInterfaceLightDown))

                    Rectangle()
                        .fill(Color(Ocean.color.colorBrandPrimaryPure))
                        .frame(width: parameters.progress < 1
                               ? progressWidth * CGFloat(parameters.progress)
                               : progressWidth
                        )
                        .cornerRadius(Ocean.size.spacingStackXxxs, corners: .allCorners)
                }
                .frame(height: Ocean.size.spacingStackXxs)
                .frame(maxWidth: .infinity)
                .cornerRadius(Ocean.size.spacingStackXxxs, corners: .allCorners)
                .overlay(GeometryReader { geometryReader in
                    Color.clear.onAppear {
                        progressWidth = geometryReader.size.width
                    }
                })
                .animation(.default)

                if parameters.showValue {
                    OceanSwiftUI.Typography.caption { view in
                        let progress = parameters.progress < 1 ? parameters.progress * 100 : 100
                        view.parameters.text = "\(String(format: "%.0f", progress))%"
                    }
                    .frame(minWidth: 33)
                }
            }
            .padding(parameters.padding)
        }
    }
}
