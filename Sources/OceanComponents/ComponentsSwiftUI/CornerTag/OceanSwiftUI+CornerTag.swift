//
//  OceanSwiftUI+CornerTag.swift
//  OceanComponents
//
//  Highlight Corner Tag — overlays the top-right corner of a card container.
//  Spec: Figma Ocean DS Core (PRD Pagnet#16178, Jira MR-490).
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class CornerTagParameters: ObservableObject {
        @Published public var label: String
        @Published public var color: Color

        public enum Color {
            case primaryDown
            case complementaryPure
        }

        public init(label: String = "",
                    color: Color = .primaryDown) {
            self.label = label
            self.color = color
        }
    }

    public struct CornerTag: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CornerTag) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CornerTagParameters

        // MARK: Constants

        private enum Constants {
            // Height/padding/font-size are Figma literals — Ocean iOS tokens do not
            // include a 10pt step (fontSizeXxxs is 12 on iOS, 10 on Web). Web uses
            // $font-size-xxxs (10px); iOS pins to the Figma value to keep parity.
            static let height: CGFloat = 20
            static let horizontalPadding: CGFloat = 8
            static let fontSize: CGFloat = 10
        }

        // MARK: Constructors

        public init(parameters: CornerTagParameters = CornerTagParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if !parameters.label.isEmpty {
                Text(parameters.label)
                    .font(Font(UIFont.baseExtraBold(size: Constants.fontSize)
                               ?? .systemFont(ofSize: Constants.fontSize, weight: .heavy)))
                    .foregroundColor(SwiftUI.Color(Ocean.color.colorInterfaceLightPure))
                    .padding(.horizontal, Constants.horizontalPadding)
                    .frame(height: Constants.height)
                    .background(SwiftUI.Color(backgroundColor))
                    .cornerRadius(Ocean.size.borderRadiusSm, corners: [.bottomLeft])
                    .accessibilityLabel(parameters.label)
            }
        }

        // MARK: Private

        private var backgroundColor: UIColor {
            switch parameters.color {
            case .primaryDown:
                return Ocean.color.colorBrandPrimaryDown
            case .complementaryPure:
                return Ocean.color.colorComplementaryPure
            }
        }
    }
}
