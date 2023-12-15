//
//  OceanSwiftUI+Alert.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 02/10/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    
    // MARK: Parameters
    
    public class AlertParameters: ObservableObject {
        @Published public var title: String
        @Published public var text: String
        @Published public var icon: UIImage?
        @Published public var withIcon: Bool
        @Published public var status: Status
        @Published public var style: Style
        @Published public var actionText: String
        @Published public var actionType: ActionType
        @Published public var actionOnTouch: () -> Void

        public enum Status {
            case info
            case positive
            case warning
            case negative
        }
        
        public enum Style {
            case none
            case longDescription
            case shortDescription
        }

        public enum ActionType {
            case link
            case button
        }

        public init(title: String = "",
                    text: String = "",
                    icon: UIImage? = nil,
                    withIcon: Bool = true,
                    status: Status = .info,
                    style: Style = .none,
                    actionText: String = "",
                    actionType: ActionType = .link,
                    actionOnTouch: @escaping () -> Void = { }){
            self.title = title
            self.text = text
            self.icon = icon
            self.withIcon = withIcon
            self.status = status
            self.style = style
            self.actionText = actionText
            self.actionType = actionType
            self.actionOnTouch = actionOnTouch
        }
    }
    
    public struct Alert: View {
        
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (Alert) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: AlertParameters
        private var iconWidth: CGFloat = 24
        private var iconHeight: CGFloat = 24
        
        // MARK: Properties private
        
        private var icon: UIImage {
            if let providedIcon = parameters.icon {
                return providedIcon
            }
            return getIconImage()
        }
        
        private var iconImage: some View {
            Group {
                if self.parameters.withIcon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: iconWidth, height: iconHeight, alignment: .center)
                        .foregroundColor(Color(getForegroundColor()))
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                }
            }
        }
        
        private var titleView: some View {
            OceanSwiftUI.Typography.heading5 { label in
                label.parameters.text = parameters.title
                label.parameters.textColor = getForegroundColor()
            }
        }
        
        private var textView: some View {
            OceanSwiftUI.Typography.caption { label in
                label.parameters.text = parameters.text
            }
        }
        
        private var withActionLink: some View {
            Group {
                if self.parameters.actionType == .link && !self.parameters.actionText.isEmpty {
                    Spacer().frame(width: Ocean.size.spacingStackXxxs + Ocean.size.spacingStackXxs)
                    OceanSwiftUI.Link.primaryTiny { link in
                        link.parameters.text = self.parameters.actionText
                        link.parameters.type = .chevron
                        link.parameters.textColor = getForegroundColor()
                        link.parameters.onTouch = parameters.actionOnTouch
                    }
                }
            }
        }

        private var withActionButton: some View {
            Group {
                if self.parameters.actionType == .button && !self.parameters.actionText.isEmpty {
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                    OceanSwiftUI.Button { button in
                        button.parameters.text = self.parameters.actionText
                        button.parameters.onTouch = self.parameters.actionOnTouch
                        button.parameters.size = .small
                        button.parameters.style = self.getButtonStyle()
                    }
                    .frame(width: 80)
                }
            }
        }

        private var defaultView: some View {
            HStack {
                iconImage
                textView
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        private var longDescriptionView: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        iconImage
                        titleView
                        Spacer()
                    }
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                    textView
                    withActionLink
                }
                Spacer()
                withActionButton
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        private var shortDescriptionView: some View {
            HStack {
                iconImage
                VStack(alignment: .leading) {
                    titleView
                    textView
                    withActionLink
                }
                Spacer()
                withActionButton
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        // MARK: Constructors
        
        public init(parameters: AlertParameters = AlertParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            VStack {
                switch parameters.style {
                case .none:
                    defaultView
                case .longDescription:
                    longDescriptionView
                case .shortDescription:
                    shortDescriptionView
                }
            }
            .background(getBackgroundColor())
            .cornerRadius(Ocean.size.borderRadiusMd)
        }
        
        // MARK: Methods private
        
        private func getIconImage() -> UIImage {
            switch parameters.status {
            case .info:
                return Ocean.icon.infoOutline!
            case .positive:
                return Ocean.icon.checkCircleOutline!
            case .warning:
                return Ocean.icon.exclamationCircleOutline!
            case .negative:
                return Ocean.icon.xCircleOutline!
            }
        }
        
        private func getForegroundColor() -> UIColor {
            switch parameters.status {
            case .info:
                return Ocean.color.colorBrandPrimaryDown
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusNeutralDeep
            case .negative:
                return Ocean.color.colorStatusNegativePure
            }
        }
        
        private func getBackgroundColor() -> Color {
            switch parameters.status {
            case .info:
                return Color(Ocean.color.colorInterfaceLightUp)
            case .positive:
                return Color(Ocean.color.colorStatusPositiveUp)
            case .warning:
                return Color(Ocean.color.colorStatusNeutralUp)
            case .negative:
                return Color(Ocean.color.colorStatusNegativeUp)
            }
        }

        private func getButtonStyle() -> ButtonParameters.Style {
            switch parameters.status {
            case .info:
                return .primary
            case .positive:
                return .primaryInverse
            case .warning:
                return .warning
            case .negative:
                return .primaryCritical
            }
        }
    }
}
