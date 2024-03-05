//
//  OceanSwiftUI+Tooltip.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 05/03/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class TooltipParameters: ObservableObject {
        @Published public var text: String
        @Published public var show: Bool
        @Published public var position: Position
        @Published public var timer: Timer
        @Published public var size: Size
        @Published public var arrowSize: CGSize

        public enum Position: Int {
            case top = 4
            case bottom = 0

            func getArrowAngleRadians() -> Optional<Double> {
                return Double(self.rawValue) * .pi / 4
            }
        }

        public enum Timer: CGFloat {
            case short = 3
            case medium = 4
            case long = 5
        }

        public enum Size {
            case short
            case medium
            case large

            public func getCGSize() -> CGSize {
                switch self {
                case .short:
                    return .init(width: 200, height: 40)
                case .medium:
                    return .init(width: 250, height: 50)
                case .large:
                    return .init(width: 300, height: 80)
                }
            }
        }

        public init(text: String = "",
                    show: Bool = false,
                    position: Position = .bottom,
                    timer: Timer = .medium,
                    size: Size = .medium,
                    arrowSize: CGSize = .init(width: 12, height: 6)) {
            self.text = text
            self.show = show
            self.position = position
            self.timer = timer
            self.size = size
            self.arrowSize = arrowSize
        }
    }

    public struct Tooltip: ViewModifier {

        // MARK: Properties for UIKit

        // MARK: Builder

        public typealias Builder = (Tooltip) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TooltipParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TooltipParameters = TooltipParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        var arrowOffsetX: CGFloat {
            return 0
        }

        var arrowOffsetY: CGFloat {
            switch parameters.position {
            case .top:
                return (parameters.size.getCGSize().height / 2 + parameters.arrowSize.height / 2)
            case .bottom:
                return -(parameters.size.getCGSize().height / 2 + parameters.arrowSize.height / 2)
            }
        }

        var tooltipBody: some View {
            GeometryReader { g in
                ZStack {
                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd, style: .circular)
                        .stroke(Color(Ocean.color.colorInterfaceDarkPure))
                        .frame(width: parameters.size.getCGSize().width, height: parameters.size.getCGSize().height)
                        .mask(self.arrowCutoutMask)
                        .background(
                            RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                                .foregroundColor(Color(Ocean.color.colorInterfaceDarkPure))
                        )

                    ZStack {
                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = parameters.text
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                        .padding(.all, Ocean.size.spacingStackXs)
                        .frame(
                            width: parameters.size.getCGSize().width,
                            height: parameters.size.getCGSize().height
                        )
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .overlay(self.arrowView)
                }
                .offset(x: self.offsetHorizontal(g), y: self.offsetVertical(g))
                .zIndex(10000)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + parameters.timer.rawValue) {
                        self.parameters.show = false
                    }
                })
            }
        }

        public func body(content: Content) -> some View {
            content
                .overlay(parameters.show ? tooltipBody : nil)
        }

        // MARK: Methods private

        private func offsetHorizontal(_ g: GeometryProxy) -> CGFloat {
            return (g.size.width - parameters.size.getCGSize().width) / 2
        }

        private func offsetVertical(_ g: GeometryProxy) -> CGFloat {
            switch parameters.position {
            case .top:
                return -(parameters.size.getCGSize().height + Ocean.size.spacingStackXxs + parameters.arrowSize.height)
            case .bottom:
                return g.size.height + Ocean.size.spacingStackXxs + parameters.arrowSize.height
            }
        }

        private var arrowView: some View {
            guard let arrowAngle = parameters.position.getArrowAngleRadians() else {
                return AnyView(EmptyView())
            }

            return AnyView(
                arrowShape(angle: arrowAngle)
                    .background(arrowShape(angle: arrowAngle)
                        .frame(width: parameters.arrowSize.width, height: parameters.arrowSize.height)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkDeep))
                    )
                    .frame(width: parameters.arrowSize.width, height: parameters.arrowSize.height)
                .offset(x: CGFloat(Int(self.arrowOffsetX)), y: CGFloat(Int(self.arrowOffsetY)))
            )
        }

        private func arrowShape(angle: Double) -> AnyView {
            let shape = ArrowShape()
                .rotation(Angle(radians: angle))
            return AnyView(shape)
        }

        private var arrowCutoutMask: some View {
            guard let arrowAngle = parameters.position.getArrowAngleRadians() else {
                return AnyView(EmptyView())
            }

            return AnyView(
                ZStack {
                    Rectangle()
                        .frame(
                            width: parameters.size.getCGSize().width + Ocean.size.borderWidthHairline * 2,
                            height: parameters.size.getCGSize().height + Ocean.size.borderWidthHairline * 2)
                        .foregroundColor(.white)
                    Rectangle()
                        .frame(
                            width: parameters.arrowSize.width,
                            height: parameters.arrowSize.height + Ocean.size.borderWidthHairline)
                        .rotationEffect(Angle(radians: arrowAngle))
                        .offset(
                            x: self.arrowOffsetX,
                            y: self.arrowOffsetY)
                        .foregroundColor(.black)
                }
                    .compositingGroup()
                    .luminanceToAlpha()
            )
        }

        private struct ArrowShape: Shape {
            public func path(in rect: CGRect) -> Path {
                var path = Path()
                path.addLines([
                    CGPoint(x: 0, y: rect.height),
                    CGPoint(x: rect.width / 2, y: 0),
                    CGPoint(x: rect.width, y: rect.height),
                ])
                return path
            }
        }
    }
}
