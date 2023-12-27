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
        @Published public var isDisabled: Bool
        @Published public var showSkeleton: Bool
        @Published public var onTouch: () -> Void = { }
        
        public enum Style {
            case primary
            case secondary
            case text
            case primaryCritical
            case secondaryCritical
            case textCritical
            case primaryInverse
            case warning
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
        
        public init(text: String = "",
                    icon: UIImage? = nil,
                    isLoading: Bool = false,
                    style: Style = .primary,
                    size: Size = .medium,
                    isDisabled: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.icon = icon
            self.isLoading = isLoading
            self.style = style
            self.size = size
            self.isDisabled = isDisabled
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
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
                HStack {
                    Spacer()
                    if !self.parameters.isDisabled && self.parameters.isLoading {
                        self.getLoadingView()
                    } else {
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
                    }
                    Spacer()
                }
            }
            .buttonStyle(OceanButtonStyle(parameters: self.parameters, foregroundColor: self.getForegroundColor()))
            .skeleton(with: self.parameters.showSkeleton)
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
            case .primary, .primaryCritical, .primaryInverse:
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
            case .text:
                return Color(Ocean.color.colorBrandPrimaryPure)
            case .primaryCritical:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .secondaryCritical:
                return Color(Ocean.color.colorStatusNegativePure)
            case .textCritical:
                return Color(Ocean.color.colorStatusNegativePure)
            case .primaryInverse:
                return Color(Ocean.color.colorInterfaceLightPure)
            case .warning:
                return Color(Ocean.color.colorInterfaceLightPure)
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
            configuration.label
                .font(Font(UIFont.baseBold(size: self.parameters.size.getFontSize())!))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       idealHeight: self.parameters.size.rawValue,
                       maxHeight: self.parameters.size.rawValue,
                       alignment: .center)
                .padding(.horizontal, self.parameters.size.getPadding())
                .background(
                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusCircular * self.parameters.size.rawValue)
                        .fill(self.getBackgroundColor(configuration: configuration))
                )
                .foregroundColor(self.foregroundColor)
        }
        
        public func getBackgroundColor(configuration: Self.Configuration) -> Color {
            guard !self.parameters.isDisabled else {
                switch self.parameters.style {
                case .text, .textCritical:
                    return Color.clear
                default:
                    return Color(Ocean.color.colorInterfaceLightDown)
                }
            }
            
            switch self.parameters.style {
            case .primary:
                return configuration.isPressed ? Color(Ocean.color.colorBrandPrimaryDeep) : Color(Ocean.color.colorBrandPrimaryPure)
            case .secondary:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceDarkUp) : Color(Ocean.color.colorInterfaceLightUp)
            case .text:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryCritical:
                return configuration.isPressed ? Color(Ocean.color.colorStatusNegativeDeep) : Color(Ocean.color.colorStatusNegativePure)
            case .secondaryCritical:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(Ocean.color.colorStatusNegativeUp)
            case .textCritical:
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryInverse:
                return configuration.isPressed ? Color(Ocean.color.colorComplementaryDeep) : Color(Ocean.color.colorComplementaryPure)
            case .warning:
                return configuration.isPressed ? Color(Ocean.color.colorStatusNeutralDeep) : Color(Ocean.color.colorStatusNeutralPure)
            }
        }
    }
}

struct Ocean_Button_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.Button()
    }
}
