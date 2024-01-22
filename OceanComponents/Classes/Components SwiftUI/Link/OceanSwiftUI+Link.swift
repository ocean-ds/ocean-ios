//
//  OceanSwiftUI+Link.swift
//  Charts
//
//  Created by Acassio Mendonça on 02/10/23.
//

import Foundation

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    
    // MARK: Parameters
    
    public class LinkParameters: ObservableObject {
        @Published public var text: String
        @Published public var textColor: UIColor?
        @Published public var icon: UIImage?
        @Published public var size: Size
        @Published public var style: Style
        @Published public var isEnabled: Bool
        @Published public var type: LinkType
        public var onTouch: (() -> Void)
        
        public enum Size {
            case medium
            case small
            case tiny
            
            public func getFontSize() -> CGFloat {
                switch self {
                case .medium:
                    return Ocean.font.fontSizeXs
                case .small:
                    return Ocean.font.fontSizeXxs
                case .tiny:
                    return Ocean.font.fontSizeXxxs
                }
            }
            
            public func getIconSize() -> CGFloat {
                switch self {
                case .tiny:
                    return 14
                default:
                    return 16
                }
            }
        }
        
        public enum Style {
            case primary
            case inverse
            case neutral
            
            public func getFontColorFromStyle() -> Color {
                switch self {
                case .primary:
                    return Color(Ocean.color.colorBrandPrimaryPure)
                case .inverse:
                    return Color(Ocean.color.colorComplementaryDown)
                case .neutral:
                    return Color(Ocean.color.colorInterfaceDarkDown)
                }
            }
        }
        
        public enum LinkType {
            case normal
            case chevron
            case external
        }
        
        public init(text: String = "",
                    textColor: UIColor? = nil,
                    icon: UIImage? = nil,
                    size: Size = .medium,
                    style: Style = .neutral,
                    isEnabled: Bool = true,
                    type: LinkType = .normal,
                    onTouch: @escaping () -> Void = { }) {
            self.text = text
            self.textColor = textColor
            self.icon = icon
            self.size = size
            self.style = style
            self.isEnabled = isEnabled
            self.type = type
            self.onTouch = onTouch
        }
    }
    
    public struct Link: View {
        
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (Link) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: LinkParameters
        
        // MARK: Properties private
        
        private var titleView: some View {
            Text(parameters.text)
                .font(Font(UIFont.baseBold(size: parameters.size.getFontSize())!))
                .foregroundColor(getForegroundColor())
                .underline()
        }
        
        private var icon: UIImage? {
            if let providedIcon = parameters.icon {
                return providedIcon
            }
            if parameters.type == .normal { return nil }
            return getIconImage()
        }
        
        private var iconView: some View {
            Group {
                if let icon = icon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(
                            maxWidth: parameters.size.getIconSize(),
                            maxHeight: parameters.size.getIconSize(),
                            alignment: .center
                        )
                        .foregroundColor(getForegroundColor())
                }
            }
        }
        
        private var defaultView: some View {
            HStack(spacing: self.parameters.type == .chevron ? 2 : 4) {
                titleView
                iconView
            }
            .onTapGesture { self.parameters.onTouch() }
        }
        
        private var disabledView: some View {
            HStack {
                Text(parameters.text)
                    .font(Font(UIFont.baseBold(size: parameters.size.getFontSize())!))
                    .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    .underline()
                if let icon = icon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: parameters.size.getIconSize(),
                               height: parameters.size.getIconSize(),
                               alignment: .center)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                }
            }
        }
        
        // MARK: Constructors
        
        public init(parameters: LinkParameters = LinkParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            if self.parameters.isEnabled {
                defaultView
            } else {
                disabledView
            }
        }
        
        // MARK: Methods private
        
        private func getForegroundColor() -> Color {
            if let color = self.parameters.textColor {
                return Color(color)
            }
            return self.parameters.style.getFontColorFromStyle()
        }
        
        private func getIconImage() -> UIImage? {
            switch self.parameters.type {
            case .chevron:
                return Ocean.icon.chevronRightSolid!
            case .external:
                return Ocean.icon.externalLinkOutline!
            default:
                return nil
            }
        }
    }
}
