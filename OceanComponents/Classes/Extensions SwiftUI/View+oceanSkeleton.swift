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
                       scales: [Int: CGFloat]? = .none) -> some View {
        self.modifier(OceanSkeletonView(isActive: isActive,
                                        size: size,
                                        shape: shape,
                                        lines: lines,
                                        scales: scales))
    }
}

struct OceanSkeletonView: ViewModifier {
    var isActive: Bool
    var isAnimated: Bool
    var size: CGSize?
    var shape: ShapeType
    var lines: Int
    var scales: [Int: CGFloat]?

    private var gradientColor = [Color(Ocean.color.colorInterfaceLightDown),
                                 Color(Ocean.color.colorInterfaceLightUp),
                                 Color(Ocean.color.colorInterfaceLightDown)]

    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)

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

    public init(isActive: Bool,
                isAnimated: Bool = true,
                size: CGSize? = nil,
                shape: ShapeType = .capsule,
                lines: Int = 1,
                scales: [Int : CGFloat]? = nil) {
        self.isActive = isActive
        self.isAnimated = isAnimated
        self.size = size
        self.shape = shape
        self.lines = lines
        self.scales = scales
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
                content
                    .hidden()
                    .overlay(skeletonView)
            } else {
                content
            }
        }
    }
}
