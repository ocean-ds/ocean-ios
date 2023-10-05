//
//  OceanSwiftUI+Alert.swift
//  Charts
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
        @Published public var status: Status
        @Published public var style: Style
        @Published public var actionText: String?
        @Published public var actionOnTouch: (() -> Void)?
        
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
        
        public init(title: String = "",
                    text: String = "",
                    icon: UIImage? = nil,
                    status: Status = .info,
                    style: Style = .none,
                    actionText: String? = nil,
                    actionOnTouch: (() -> Void)? = nil ){
            self.title = title
            self.text = text
            self.icon = icon
            self.status = status
            self.style = style
            self.actionText = actionText
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
            Image(uiImage: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: iconWidth, height: iconHeight, alignment: .center)
                .foregroundColor(Color(getForegroundColor()))
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
        
        private var withAction: some View {
            Group {
                if let actionText = parameters.actionText {
                    Spacer().frame(width: Ocean.size.spacingStackXxxs + Ocean.size.spacingStackXxs)
                    OceanSwiftUI.Link.primaryTiny { link in
                        link.parameters.text = actionText
                        link.parameters.type = .chevron
                        link.parameters.textColor = getForegroundColor()
                        link.parameters.onTouch = parameters.actionOnTouch ?? { }
                    }
                }
            }
        }
        
        private var defaultView: some View {
            HStack {
                iconImage
                Spacer().frame(width: Ocean.size.spacingStackXxs)
                textView
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        private var longDescriptionView: some View {
            VStack(alignment: .leading) {
                HStack {
                    iconImage
                    Spacer().frame(width: Ocean.size.spacingStackXxs)
                    titleView
                    Spacer()
                }
                Spacer().frame(width: Ocean.size.spacingStackXxs)
                textView
                withAction
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        private var shortDescriptionView: some View {
            HStack {
                iconImage
                VStack(alignment: .leading) {
                    titleView
                    textView
                    withAction
                }
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
    }
}
