//
//  OceanSwiftUI+Button.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/08/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters
    
    public class ButtonParameters: ObservableObject {
        @Published public var text: String
        @Published public var icon: UIImage?
        @Published public var isLoading: Bool
        @Published public var style: Style
        @Published public var size: Size
        @Published public var widthMode: WidthMode
        @Published public var isDisabled: Bool
        @Published public var maxWidth: CGFloat?
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void = { }
        
        public enum Style {
            case primary
            case secondary
            case tertiary
            case primaryCritical
            case secondaryCritical
            case tertiaryCritical
            case primaryInverse
            case primaryWarning
            case secondaryWarning
            case tertiaryWarning
        }
        
        public enum Size: CGFloat {
            case small = 32
            case medium = 48
            case large = 56
            
            public func getFontSize() -> CGFloat {
                switch self {
                case .small:
                    return Ocean.font.fontSizeXxs
                case .medium:
                    return Ocean.font.fontSizeXs
                case .large:
                    return Ocean.font.fontSizeSm
                }
            }
            
            public func getIconSize() -> CGFloat {
                switch self {
                case .small:
                    return 16
                default:
                    return 24
                }
            }
            
            public func getPadding() -> CGFloat {
                switch self {
                case .small:
                    return Ocean.size.spacingStackXs
                case .medium:
                    return Ocean.size.spacingStackSm
                case .large:
                    return Ocean.size.spacingStackMd
                }
            }
        }

        public enum WidthMode {
            case fluid
            case hug
        }

        public init(text: String = "",
                    icon: UIImage? = nil,
                    isLoading: Bool = false,
                    style: Style = .primary,
                    size: Size = .medium,
                    widthMode: WidthMode = .fluid,
                    isDisabled: Bool = false,
                    maxWidth: CGFloat? = .infinity,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.icon = icon
            self.isLoading = isLoading
            self.style = style
            self.size = size
            self.widthMode = widthMode
            self.isDisabled = isDisabled
            self.maxWidth = maxWidth
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
        
        public func shouldShowLoading() -> Bool {
            guard isLoading && !isDisabled else { return false }

            switch style {
            case .primary, .primaryCritical, .primaryWarning, .primaryInverse, .secondary, .tertiary:
                return true
            default:
                return false
            }
        }
    }
    
    public struct Button: View {
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (Button) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: ButtonParameters
        
        // MARK: Properties private
        
        // MARK: Constructors
        
        public init(parameters: ButtonParameters = ButtonParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            SwiftUI.Button {
                if !self.parameters.isDisabled && !self.parameters.isLoading {
                    self.parameters.onTouch()
                }
            } label: {
                ZStack {
                    HStack {
                        if self.parameters.widthMode == .fluid {
                            Spacer()
                        }

                        if let icon = self.parameters.icon {
                            Image(uiImage: icon)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: self.parameters.size.getIconSize(),
                                       height: self.parameters.size.getIconSize(),
                                       alignment: .center)
                                .foregroundColor(self.getForegroundColor())
                        }
                        
                        if !self.parameters.text.isEmpty {
                            Text(self.parameters.text)
                                .fixedSize(horizontal: true, vertical: false)
                        }

                        if self.parameters.widthMode == .fluid {
                            Spacer()
                        }
                    }
                    .opacity(self.parameters.shouldShowLoading() ? 0 : 1)

                    if self.parameters.shouldShowLoading() {
                        self.getLoadingView()
                    }
                }
            }
            .buttonStyle(OceanButtonStyle(parameters: self.parameters, foregroundColor: self.getForegroundColor()))
            .frame(height: parameters.size.rawValue)
            .oceanSkeleton(isActive: self.parameters.showSkeleton,
                           size: .init(width: .infinity, height: parameters.size.rawValue))
        }
        
        public func getLoadingView() -> OceanSwiftUI.CircularProgressIndicator {
            var size: OceanSwiftUI.CircularProgressIndicatorParameters.Size
            switch self.parameters.size {
            case .small:
                size = .small
            case .medium:
                size = .medium
            case .large:
                size = .large
            }
            
            switch self.parameters.style {
            case .primary, .primaryCritical, .primaryInverse, .primaryWarning:
                return OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .normal, size: size))
            default:
                return OceanSwiftUI.CircularProgressIndicator(parameters: .init(style: .primary, size: size))
            }
        }

        public func getForegroundColor() -> Color {
            guard !self.parameters.isDisabled else { return Color(Ocean.color.colorInterfaceDarkUp) }

            switch self.parameters.style {
            case .primary:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .secondary:
                return Color(Ocean.color.colorBrandPrimaryPure)
            case .tertiary:
                return Color(Ocean.color.colorBrandPrimaryPure)
            case .primaryCritical:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .secondaryCritical:
                return Color(Ocean.color.colorStatusNegativePure)
            case .tertiaryCritical:
                return Color(Ocean.color.colorStatusNegativePure)
            case .primaryInverse:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .primaryWarning:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .secondaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep)
            case .tertiaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep)
            }
        }
    }
    
    public struct OceanButtonStyle: ButtonStyle {
        @ObservedObject public var parameters: ButtonParameters
        public var foregroundColor: Color

        public init(parameters: ButtonParameters = ButtonParameters(),
                    foregroundColor: Color) {
            self.parameters = parameters
            self.foregroundColor = foregroundColor
        }
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            let finalForegroundColor = self.parameters.widthMode == .hug && configuration.isPressed
            ? self.getPressedForegroundColor()
            : self.foregroundColor

            configuration.label
                .font(Font(UIFont.baseBold(size: self.parameters.size.getFontSize())!))
                .frame(maxWidth: self.getMaxWidth(),
                       minHeight: self.parameters.size.rawValue,
                       idealHeight: self.parameters.size.rawValue,
                       maxHeight: self.parameters.size.rawValue,
                       alignment: .center)
                .padding(.horizontal, getPadding())
                .background(
                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusCircular * self.parameters.size.rawValue)
                        .fill(self.getBackgroundColor(configuration: configuration))
                )
                .foregroundColor(finalForegroundColor)
        }

        public func getMaxWidth() -> CGFloat? {
            switch self.parameters.widthMode {
            case .fluid:
                return self.parameters.maxWidth
            case .hug:
                return nil
            }
        }

        public func getPadding() -> CGFloat {
            if self.parameters.widthMode == .hug {
                switch self.parameters.style {
                case .tertiary, .tertiaryCritical, .tertiaryWarning:
                    return .zero
                default:
                    return self.parameters.size.getPadding()
                }
            }

            switch self.parameters.style {
            case .tertiary, .tertiaryCritical, .tertiaryWarning:
                return .zero
            default:
                return self.parameters.size.getPadding()
            }
        }

        public func getPressedForegroundColor() -> Color {
            guard !self.parameters.isDisabled else { return Color(Ocean.color.colorInterfaceDarkUp) }

            switch self.parameters.style {
            case .primary:
                return Color(Ocean.color.colorBrandPrimaryDeep)
            case .secondary:
                return Color(Ocean.color.colorBrandPrimaryDeep)
            case .tertiary:
                return Color(Ocean.color.colorBrandPrimaryDeep)
            case .primaryCritical:
                return Color(Ocean.color.colorStatusNegativeDeep)
            case .secondaryCritical:
                return Color(Ocean.color.colorStatusNegativeDeep)
            case .tertiaryCritical:
                return Color(Ocean.color.colorStatusNegativeDeep)
            case .primaryInverse:
                return Color(Ocean.color.colorComplementaryDeep)
            case .primaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep).mix(with: Color(Ocean.color.colorInterfaceDarkPure), by: 0.12)
            case .secondaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep).mix(with: Color(Ocean.color.colorInterfaceDarkPure), by: 0.12)
            case .tertiaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep).mix(with: Color(Ocean.color.colorInterfaceDarkPure), by: 0.12)
            }
        }

        public func getBackgroundColor(configuration: Self.Configuration) -> Color {
            guard !self.parameters.isDisabled else {
                switch self.parameters.style {
                case .tertiary, .tertiaryCritical, .tertiaryWarning:
                    return Color.clear
                default:
                    return Color(Ocean.color.colorInterfaceLightDown)
                }
            }

            if self.parameters.widthMode == .hug {
                return self.getBaseBackgroundColor()
            }

            switch self.parameters.style {
            case .primary:
                return configuration.isPressed ? Color(Ocean.color.colorBrandPrimaryDeep) : Color(Ocean.color.colorBrandPrimaryPure)
            case .secondary:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceDarkUp) : Color(Ocean.color.colorInterfaceLightUp)
            case .tertiary:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryCritical:
                return configuration.isPressed ? Color(Ocean.color.colorStatusNegativeDeep) : Color(Ocean.color.colorStatusNegativePure)
            case .secondaryCritical:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(Ocean.color.colorStatusNegativeUp)
            case .tertiaryCritical:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryInverse:
                return configuration.isPressed ? Color(Ocean.color.colorComplementaryDeep) : Color(Ocean.color.colorComplementaryPure)
            case .primaryWarning:
                return configuration.isPressed ? Color(Ocean.color.colorStatusWarningDeep).mix(with: Color(Ocean.color.colorInterfaceDarkPure), by: 0.12) : Color(Ocean.color.colorStatusWarningDeep)
            case .secondaryWarning:
                return configuration.isPressed ? Color(Ocean.color.colorStatusWarningUp).mix(with: Color(Ocean.color.colorStatusWarningDeep), by: 0.16) : Color(Ocean.color.colorStatusWarningUp)
            case .tertiaryWarning:
                return configuration.isPressed ? Color(Ocean.color.colorStatusWarningUp).mix(with: Color(Ocean.color.colorStatusWarningDeep), by: 0.16) : Color(UIColor.clear)
            }
        }

        private func getBaseBackgroundColor() -> Color {
            switch self.parameters.style {
            case .primary:
                return Color(Ocean.color.colorBrandPrimaryPure)
            case .secondary:
                return Color(Ocean.color.colorInterfaceLightUp)
            case .tertiary:
                return Color(UIColor.clear)
            case .primaryCritical:
                return Color(Ocean.color.colorStatusNegativePure)
            case .secondaryCritical:
                return Color(Ocean.color.colorStatusNegativeUp)
            case .tertiaryCritical:
                return Color(UIColor.clear)
            case .primaryInverse:
                return Color(Ocean.color.colorComplementaryPure)
            case .primaryWarning:
                return Color(Ocean.color.colorStatusWarningDeep)
            case .secondaryWarning:
                return Color(Ocean.color.colorStatusWarningUp)
            case .tertiaryWarning:
                return Color(UIColor.clear)
            }
        }
    }
}
