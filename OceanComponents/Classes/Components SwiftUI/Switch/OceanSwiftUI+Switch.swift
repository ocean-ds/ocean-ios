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
        public var onValueChanged: (Bool) -> Void
        
        public init(isOn: Bool = false,
                    onValueChanged: @escaping (Bool) -> Void = { _ in }) {
            self.isOn = isOn
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
                .toggleStyle(OceanSwitchStyle(onValueChanged: self.parameters.onValueChanged))
        }

        // MARK: Methods private
    }
    
    public struct OceanSwitchStyle: ToggleStyle {
        public var onValueChanged: (Bool) -> Void
        
        let onColor = Color(Ocean.color.colorComplementaryPure)
        let offColor = Color(Ocean.color.colorInterfaceLightPure)
        let offThumbColor = Color(Ocean.color.colorInterfaceDarkUp)
        let onThumbColor = Color(Ocean.color.colorInterfaceLightPure)
        let onBorderColor = Ocean.color.colorComplementaryPure
        let offBorderColor = Ocean.color.colorInterfaceDarkUp
        
        init(onValueChanged: @escaping (Bool) -> Void) {
            self.onValueChanged = onValueChanged
        }
        
        public func makeBody(configuration: Configuration) -> some View {
            RoundedRectangle(cornerRadius: Ocean.size.borderRadiusLg, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 40, height: 20)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? onThumbColor : offThumbColor)
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .border(cornerRadius: Ocean.size.borderRadiusLg,
                        width: Ocean.size.borderWidthHairline,
                        color: configuration.isOn ? onBorderColor : offBorderColor)
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                        self.onValueChanged(configuration.isOn)
                    }
                }
        }
    }
}
