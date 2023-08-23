//
//  Ocean.Button.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 18/08/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class ButtonParameters: ObservableObject {
        @Published public var text: String
        @Published public var icon: UIImage?
        @Published public var isLoading: Bool
        @Published public var style: Style
        @Published public var size: Size
        @Published public var isDisabled: Bool
        @Published public var onTouch: () -> Void = { }

        public enum Style {
            case primary
            case secondary
            case text
            case primaryCritical
            case secondaryCritical
            case textCritical
            case primaryInverse
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
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.icon = icon
            self.isLoading = isLoading
            self.style = style
            self.size = size
            self.isDisabled = isDisabled
            self.onTouch = onTouch
        }
    }

    public struct Button: View {
        @ObservedObject public var parameters: ButtonParameters

        @GestureState private var isPressedTapped = false
        @State private var isTapped = false

        public init(parameters: ButtonParameters = ButtonParameters()) {
            self.parameters = parameters
        }

        public var body: some View {
            HStack {
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
            }
            .font(Font(UIFont.baseBold(size: self.parameters.size.getFontSize())!))
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   idealHeight: self.parameters.size.rawValue,
                   maxHeight: self.parameters.size.rawValue,
                   alignment: .center)
            .padding(.horizontal, self.parameters.size.getPadding())
            .background(
                RoundedRectangle(cornerRadius: Ocean.size.borderRadiusCircular * self.parameters.size.rawValue)
                    .fill(self.getBackgroundColor())
            )
            .foregroundColor(self.getForegroundColor())
            .gesture(DragGesture(minimumDistance: 0)
                .updating($isPressedTapped) { (_, isPressedTapped, _) in
                    guard !self.parameters.isDisabled else { return }

                    isPressedTapped = true
                }
                .onChanged { _ in
                    guard !self.parameters.isDisabled else { return }

                    if !self.isTapped {
                        self.isTapped = true
                    }
                }
                .onEnded { _ in
                    guard !self.parameters.isDisabled else { return }

                    if !self.parameters.isLoading && self.isTapped {
                        self.isTapped = false
                        self.parameters.onTouch()
                    }
                }
            )
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

        public func getBackgroundColor() -> Color {
            guard !self.parameters.isDisabled else { return Color(Ocean.color.colorInterfaceLightDown) }

            switch self.parameters.style {
            case .primary:
                return self.isPressedTapped ? Color(Ocean.color.colorBrandPrimaryDeep) : Color(Ocean.color.colorBrandPrimaryPure)
            case .secondary:
                return self.isPressedTapped ? Color(Ocean.color.colorInterfaceDarkUp) : Color(Ocean.color.colorInterfaceLightUp)
            case .text:
                return self.isPressedTapped ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryCritical:
                return self.isPressedTapped ? Color(Ocean.color.colorStatusNegativeDeep) : Color(Ocean.color.colorStatusNegativePure)
            case .secondaryCritical:
                return self.isPressedTapped ? Color(Ocean.color.colorInterfaceLightDeep) : Color(Ocean.color.colorStatusNegativeUp)
            case .textCritical:
                return self.isPressedTapped ? Color(Ocean.color.colorInterfaceLightDeep) : Color(UIColor.clear)
            case .primaryInverse:
                return self.isPressedTapped ? Color(Ocean.color.colorComplementaryDeep) : Color(Ocean.color.colorComplementaryPure)
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
            }
        }
    }
}

struct Ocean_Button_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.Button()
    }
}
