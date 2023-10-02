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
        
        // MARK: Properties private
        
        private var icon: UIImage {
            if let providedIcon = self.parameters.icon {
                return providedIcon
            }
            return self.getIconImage()
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
                switch self.parameters.style {
                case .none:
                    defaultView
                case .longDescription:
                    longDescriptionView
                case .shortDescription:
                    shortDescriptionView
                }
            }
            .background(self.getBackgroundColor())
            .cornerRadius(8)
        }
        
        private var defaultView: some View {
            HStack {
                iconImage
                Spacer().frame(width: Ocean.size.spacingStackXxs)
                OceanSwiftUI.Typography.caption { label in
                    label.parameters.text = self.parameters.text
                }
                Spacer()
            }
            .padding(.all, 16)
        }
        
        private var longDescriptionView: some View {
            VStack {
                HStack {
                    iconImage
                    OceanSwiftUI.Typography.heading5 { label in
                        label.parameters.text = self.parameters.text
                        label.parameters.textColor = self.getForegroundColor()
                    }
                }
                OceanSwiftUI.Typography.caption { label in
                    label.parameters.text = self.parameters.text
                }
            }
            .padding(.all, 16)
        }
        
        private var shortDescriptionView: some View {
            HStack {
                iconImage
                Spacer(minLength: Ocean.size.spacingStackXxs)
                VStack {
                    OceanSwiftUI.Typography.heading5 { label in
                        label.parameters.text = self.parameters.text
                        label.parameters.textColor = self.getForegroundColor()
                    }
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = self.parameters.text
                    }
                }
            }
        }
        
        private var iconImage: some View {
            Image(uiImage: self.icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(Color(self.getForegroundColor()))
        }
        
        public func getForegroundColor() -> UIColor {
            switch self.parameters.status {
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
        
        public func getIconImage() -> UIImage {
            switch self.parameters.status {
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
       
        public func getBackgroundColor() -> Color {
            switch self.parameters.status {
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
