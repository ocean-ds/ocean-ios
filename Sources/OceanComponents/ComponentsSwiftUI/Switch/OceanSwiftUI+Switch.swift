//
//  OceanSwiftUI+Switch.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 27/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class SwitchParameters: ObservableObject {
        @Published public var isOn: Bool
        @Published public var isDisabled: Bool
        @Published public var showSkeleton: Bool
        public var onValueChanged: (Bool) -> Void

        public init(isOn: Bool = false,
                    isDisabled: Bool = false,
                    showSkeleton: Bool = false,
                    onValueChanged: @escaping (Bool) -> Void = { _ in }) {
            self.isOn = isOn
            self.isDisabled = isDisabled
            self.showSkeleton = showSkeleton
            self.onValueChanged = onValueChanged
        }
    }

    public struct Switch: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Switch) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SwitchParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: SwitchParameters = SwitchParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            Toggle("", isOn: self.$parameters.isOn)
                .toggleStyle(OceanSwitchStyle(isDisabled: self.parameters.isDisabled,
                                              onValueChanged: self.parameters.onValueChanged))
                .oceanSkeleton(isActive: self.parameters.showSkeleton, size: .init(width: 40, height: 20))
        }

        // MARK: Methods private
    }
    
    public struct OceanSwitchStyle: ToggleStyle {
        public var isDisabled: Bool
        public var onValueChanged: (Bool) -> Void

        let onColor = Color(Ocean.color.colorComplementaryPure)
        let offColor = Color(Ocean.color.colorInterfaceLightPure)
        let offThumbColor = Color(Ocean.color.colorInterfaceDarkUp)
        let onThumbColor = Color(Ocean.color.colorInterfaceLightPure)
        let onBorderColor = Ocean.color.colorComplementaryPure
        let offBorderColor = Ocean.color.colorInterfaceDarkUp
        let disabledColor = Color(Ocean.color.colorInterfaceLightDown)
        let disabledBorderColor = Ocean.color.colorInterfaceLightDown

        init(isDisabled: Bool = false, onValueChanged: @escaping (Bool) -> Void) {
            self.isDisabled = isDisabled
            self.onValueChanged = onValueChanged
        }

        public func makeBody(configuration: Configuration) -> some View {
            let isEnabled = !self.isDisabled

            return RoundedRectangle(cornerRadius: Ocean.size.borderRadiusLg, style: .circular)
                .fill(configuration.isOn ? (isEnabled ? onColor : disabledColor) : offColor)
                .frame(width: 40, height: 20)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? onThumbColor : (isEnabled ? offThumbColor : disabledColor))
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .border(cornerRadius: Ocean.size.borderRadiusLg,
                        width: Ocean.size.borderWidthHairline,
                        color: isEnabled ? (configuration.isOn ? onBorderColor : offBorderColor) : disabledBorderColor)
                .onTapGesture {
                    guard isEnabled else { return }

                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                        self.onValueChanged(configuration.isOn)
                    }
                }
        }
    }
}
