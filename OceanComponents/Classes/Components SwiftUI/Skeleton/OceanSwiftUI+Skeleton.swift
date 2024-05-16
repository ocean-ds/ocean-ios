//
//  OceanSwiftUI+Skeleton.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 19/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class SkeletonParameters: ObservableObject {
        @Published public var width: CGFloat?
        @Published public var height: CGFloat?
        @Published public var radius: CGFloat
        @Published public var lines: Int
        @Published public var withImage: Bool

        public init(width: CGFloat? = nil,
                    height: CGFloat? = nil,
                    radius: CGFloat = Ocean.size.borderRadiusSm,
                    lines: Int = 2,
                    withImage: Bool = false) {
            self.width = width
            self.height = height
            self.radius = radius
            self.lines = lines
            self.withImage = withImage
        }
    }

    public struct Skeleton: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Skeleton) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SkeletonParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: SkeletonParameters = SkeletonParameters()) {
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

                GeometryReader { geometryReader in
                    HStack(spacing: Ocean.size.spacingStackXs) {
                        if self.parameters.withImage {
                            Circle()
                                .skeleton(with: true,
                                          size: CGSize(width: 40,
                                                       height: 40),
                                          shape: .circle)
                        }

                        let width = self.parameters.withImage ? geometryReader.size.width * 0.6 : geometryReader.size.width
                        let scales: [Int: CGFloat] = self.parameters.lines == 1 ? [0: 1.0] : [0: 0.35, 1: 1.0]

                        Rectangle()
                            .skeleton(with: true,
                                      size: CGSize(width: self.parameters.width ?? width,
                                                   height: self.parameters.height ?? 60),
                                      shape: .rounded(.radius(self.parameters.radius,
                                                              style: .circular)),
                                      lines: self.parameters.lines,
                                      scales: scales)
                    }
                }

                Spacer()
                    .frame(height: self.parameters.height ?? 60)
            }
        }

        // MARK: Methods private
    }
}
