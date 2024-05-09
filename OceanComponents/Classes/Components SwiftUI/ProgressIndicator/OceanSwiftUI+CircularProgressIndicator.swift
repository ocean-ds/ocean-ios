//
//  OceanSwiftUI+CircularProgressIndicator.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 21/08/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class CircularProgressIndicatorParameters: ObservableObject {
        @Published public var style: Style
        @Published public var size: Size

        public enum Size: CGFloat {
            case small = 16
            case medium = 24
            case large = 32
        }

        public enum Style {
            case normal
            case primary
        }

        public init(style: Style = .normal,
                    size: Size = .medium) {
            self.style = style
            self.size = size
        }
    }

    public struct CircularProgressIndicator: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CircularProgressIndicator) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CircularProgressIndicatorParameters

        // MARK: Properties private

        @State private var isAnimating = false

        // MARK: Constructors

        public init(parameters: CircularProgressIndicatorParameters = CircularProgressIndicatorParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            let image = self.parameters.style == .normal ? Ocean.icon.spinner : Ocean.icon.spinnerPrimary
            Image(uiImage: image!)
                .resizable()
                .frame(width: self.parameters.size.rawValue,
                       height: self.parameters.size.rawValue,
                       alignment: .center)
                .rotationEffect(Angle(degrees: isAnimating ? 360.0 : 0.0))
                .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    self.isAnimating = true
                }
        }
    }
}
