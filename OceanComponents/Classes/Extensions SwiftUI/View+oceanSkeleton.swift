//
//  View+oceanSkeleton.swift
//  Pods
//
//  Created by Acassio Mendonça on 17/10/24.
//

import SwiftUI
import SkeletonUI
import OceanTokens

extension View {
    func oceanSkeleton(isActive: Bool,
                       isAnimated: Bool = true,
                       size: CGSize? = .none,
                       shape: OceanSkeletonView.ShapeType = .capsule,
                       lines: Int = 1,
                       scales: [Int: CGFloat]? = .none,
                       alignment: HorizontalAlignment = .leading) -> some View {
        self.modifier(OceanSkeletonView(isActive: isActive,
                                        size: size,
                                        shape: shape,
                                        lines: lines,
                                        scales: scales,
                                        alignment: alignment))
    }
}

struct OceanSkeletonView: ViewModifier {

    // MARK: Properties

    var isActive: Bool
    var isAnimated: Bool
    var size: CGSize?
    var shape: ShapeType
    var lines: Int
    var scales: [Int: CGFloat]?
    var alignment: HorizontalAlignment

    // MARK: Properties private

    private var gradientColor = [Color(Ocean.color.colorInterfaceLightDown),
                                 Color(Ocean.color.colorInterfaceLightUp),
                                 Color(Ocean.color.colorInterfaceLightDown)]

    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)

    // MARK: View SwiftUI

    @ViewBuilder
    private var skeletonView: some View {
        let gradient = LinearGradient(
            colors: gradientColor,
            startPoint: startPoint,
            endPoint: endPoint
        )

        let baseView = Group {
            switch shape {
            case let .rounded(.radius(radius, style)):
                RoundedRectangle(cornerRadius: radius, style: style).fill(gradient)
            case let .rounded(.size(size, style)):
                RoundedRectangle(cornerSize: size, style: style).fill(gradient)
            case .rectangle:
                Rectangle().fill(gradient)
            case .circle:
                Circle().fill(gradient)
            case .ellipse:
                Ellipse().fill(gradient)
            case .capsule:
                Capsule().fill(gradient)
            }
        }

        baseView
            .onAppear {
                if isAnimated {
                    withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                        startPoint = .init(x: 1, y: 1)
                        endPoint = .init(x: 2.2, y: 2.2)
                    }
                }
            }
    }

    // MARK: Constructors

    public init(isActive: Bool,
                isAnimated: Bool = true,
                size: CGSize? = nil,
                shape: ShapeType = .capsule,
                lines: Int = 1,
                scales: [Int : CGFloat]? = nil,
                alignment: HorizontalAlignment = .leading) {
        self.isActive = isActive
        self.isAnimated = isAnimated
        self.size = size
        self.shape = shape
        self.lines = lines
        self.scales = scales
        self.alignment = alignment
    }

    public enum RoundedType: Equatable {
        case radius(CGFloat, style: RoundedCornerStyle = .continuous)
        case size(CGSize, style: RoundedCornerStyle = .continuous)
    }

    public enum ShapeType: Equatable {
        case rounded(RoundedType)
        case rectangle
        case circle
        case ellipse
        case capsule
    }

    func body(content: Content) -> some View {
        ZStack {
            if isActive {
                if let size = size {
                    VStack(alignment: alignment) {
                        ForEach(0..<lines, id: \.self) { index in
                            GeometryReader { geometry in
                                skeletonView
                                    .frame(width: (scales?[index] ?? 1) * geometry.size.width, height: geometry.size.height)
                            }
                        }
                    }
                    .frame(width: size.width.isFinite ? size.width : nil, height: size.height.isFinite ? size.height : nil)
                } else {
                    content
                        .hidden()
                        .overlay(skeletonView)
                }
            } else {
                content
            }
        }
    }

    // MARK: Private functions

    private func validateDimension(_ dimension: CGFloat) -> CGFloat? {
        guard dimension.isFinite, dimension > 0 else { return nil }
        return dimension
    }
}
