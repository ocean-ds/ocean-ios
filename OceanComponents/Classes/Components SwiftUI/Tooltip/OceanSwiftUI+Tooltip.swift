//
//  OceanSwiftUI+Tooltip.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 05/03/24.
//

import SwiftUI
import OceanTokens
import EasyTipView

extension OceanSwiftUI {

    // MARK: Parameters

    public class TooltipParameters: ObservableObject {
        @Published public var text: String
        @Published public var timer: Timer

        public enum Timer: CGFloat {
            case short = 2
            case medium = 3
            case long = 5
        }

        public init(text: String = "",
                    timer: Timer = .medium) {
            self.text = text
            self.timer = timer
        }
    }

    public struct Tooltip: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Tooltip) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TooltipParameters

        // MARK: Properties private

        @State private var show: Bool = false

        // MARK: Constructors

        public init(parameters: TooltipParameters = TooltipParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            SwiftUI.Button {
                self.show = true
            } label: {
                Image(uiImage: Ocean.icon.infoSolid)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(Color(Ocean.color.colorInterfaceLightDeep))
                    .overlay(TooltipView(text: self.$parameters.text, show: self.$show, 
                                         timer: self.$parameters.timer))
            }
        }

        // MARK: Methods private
    }

    private struct TooltipView: UIViewRepresentable {
        @Binding var text: String
        @Binding var show: Bool
        @Binding var timer: TooltipParameters.Timer

        func makeUIView(context: Context) -> UIView {
            return UIView(frame: .zero)
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            if show {
                var preferences = EasyTipView.Preferences()
                preferences.drawing.font = .baseRegular(size: Ocean.font.fontSizeXxs)!
                preferences.drawing.foregroundColor = Ocean.color.colorInterfaceLightPure
                preferences.drawing.backgroundColor = Ocean.color.colorInterfaceDarkDeep
                preferences.drawing.textAlignment = .left
                preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.any
                preferences.positioning.maxWidth = 200
                preferences.animating.dismissDuration = 0

                let tipView = EasyTipView(text: text, preferences: preferences)
                tipView.show(forView: uiView)

                DispatchQueue.main.asyncAfter(deadline: .now() + timer.rawValue) {
                    tipView.dismiss {
                        self.show = false
                    }
                }
            }
        }
    }
}
