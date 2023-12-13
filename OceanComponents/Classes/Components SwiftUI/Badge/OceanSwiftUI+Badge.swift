//
//  OceanSwiftUI+Badge.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 13/12/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class BadgeParameters: ObservableObject {
        @Published public var count: Int
        @Published public var status: Status
        @Published public var size: Size
        @Published public var style: Style

        public enum Status {
            case primary
            case primaryInverted
            case warning
            case highlight
            case disabled
        }
        
        public enum Size: CGFloat {
            case small = 16
            case medium = 24
        }

        public enum Style {
            case count
            case dot
        }

        public var value: String {
            return self.count < 100 ? self.count.description : "99+"
        }

        public init(count: Int = 0,
                    status: Status = .primary,
                    size: Size = .medium,
                    style: Style = .count) {
            self.count = count
            self.status = status
            self.size = size
            self.style = style
        }
    }

    public struct Badge: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Badge) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BadgeParameters

        // MARK: Properties private

        private var countView: some View {
            HStack(alignment: .center) {
                OceanSwiftUI.Typography { label in
                    label.parameters.font = .baseRegular(size: self.parameters.size == .medium ? Ocean.font.fontSizeXxxs : 10)
                    label.parameters.text = self.parameters.value
                    label.parameters.textColor = self.getForegroundColor()
                }
            }
            .frame(width: self.getWidth(), height: self.parameters.size.rawValue)
            .background(Color(self.getBackgroundColor()))
            .cornerRadius(self.parameters.size.rawValue * Ocean.size.borderRadiusCircular)
        }

        private var dotView: some View {
            HStack {
                Spacer()
            }
            .frame(width: 8, height: 8)
            .background(Color(Ocean.color.colorHighlightPure))
            .cornerRadius(Ocean.size.borderRadiusSm)
        }

        // MARK: Constructors

        public init(parameters: BadgeParameters = BadgeParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            switch parameters.style {
            case .count:
                countView
            case .dot:
                dotView
            }
        }

        // MARK: Methods private

        private func getForegroundColor() -> UIColor {
            switch parameters.status {
            case .primaryInverted:
                return Ocean.color.colorBrandPrimaryPure
            case .disabled:
                return Ocean.color.colorInterfaceLightUp
            default:
                return Ocean.color.colorInterfaceLightPure
            }
        }

        private func getBackgroundColor() -> UIColor {
            switch parameters.status {
            case .primary:
                return Ocean.color.colorBrandPrimaryPure
            case .primaryInverted:
                return Ocean.color.colorInterfaceLightPure
            case .warning:
                return Ocean.color.colorStatusNeutralDeep
            case .highlight:
                return Ocean.color.colorHighlightPure
            case .disabled:
                return Ocean.color.colorInterfaceDarkUp
            }
        }

        private func getWidth() -> CGFloat {
            switch self.parameters.size {
            case .medium:
                switch self.parameters.value.count {
                case 2:
                    return 24
                case 3:
                    return 30
                default:
                    return 24
                }
            case .small:
                switch self.parameters.value.count {
                case 2:
                    return 20
                case 3:
                    return 26
                default:
                    return 16
                }
            }
        }
    }
}
