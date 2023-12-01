//
//  OceanSwiftUI+OrderedListItem.swift
//  Charts
//
//  Created by Acassio Mendonça on 29/11/23.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {
    
    // MARK: Parameters
    
    public class OrderedListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var text: String
        @Published public var style: Style
        @Published public var status: Status
        @Published public var number: Int?
        @Published public var icon: UIImage?
        
        public enum Style {
            case ordered
            case unordered
        }
        
        public enum Status {
            case info
            case negative
        }
        
        public init(title: String = "",
                    text: String = "",
                    style: Style = .ordered,
                    status: Status = .info,
                    number: Int? = nil,
                    icon: UIImage? = nil) {
            self.title = title
            self.text = text
            self.style = style
            self.status = status
            self.number = number
            self.icon = icon
        }
    }
    
    public struct OrderedListItem: View {
        
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (OrderedListItem) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: OrderedListItemParameters
        private var roundedViewHeightWidthLg: CGFloat = Ocean.size.spacingStackSm
        
        // MARK: Properties private
        
        private var numberLabel: some View {
            OceanSwiftUI.Typography.description { label in
                label.parameters.text = parameters.number?.description ?? "1"
                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.parameters.textColor = getForegroundColor()
            }
            .lineLimit(1)
        }
        
        private var imageView: some View {
            let providedIcon = parameters.icon ?? Ocean.icon.chevronRightSolid!
            
            return Image(uiImage: providedIcon)
                .resizable()
                .renderingMode(.template)
                .frame(width: Ocean.size.spacingStackXs,
                       height: Ocean.size.spacingStackXs)
                .foregroundColor(Color(getForegroundColor()))
        }
        
        private var roundedView: some View {
            ZStack {
                Circle()
                    .fill(getBackgroundColor())
                    .frame(width: self.roundedViewHeightWidthLg,
                           height: self.roundedViewHeightWidthLg,
                           alignment: .center)
                switch parameters.style {
                case .ordered:
                    numberLabel
                case .unordered:
                    imageView
                }
            }
        }

        private var titleView: some View {
         OceanSwiftUI.Typography.heading4 { label in
            label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
            label.parameters.text = parameters.title
            }
        }
        
        private var textView: some View {
            OceanSwiftUI.Typography.description { label in
                label.parameters.text = parameters.text
            }
        }
        
        private var defaultView: some View {
            HStack(alignment: .top) {
                roundedView
                Spacer().frame(width: Ocean.size.spacingStackXxs)
                textView
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        private var withTitleView: some View {
            HStack(alignment: .top) {
                roundedView
                VStack(alignment: .leading) {
                    titleView
                    textView
                }
                Spacer()
            }
            .padding(.all, Ocean.size.spacingStackXs)
        }
        
        // MARK: Constructors
        
        public init(parameters: OrderedListItemParameters = OrderedListItemParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            if parameters.title.isEmpty {
                defaultView
            } else {
                withTitleView
            }
        }
        
        // MARK: Methods private
        
        private func getForegroundColor() -> UIColor {
            switch parameters.status {
            case .info:
                return Ocean.color.colorBrandPrimaryDown
            case .negative:
                return Ocean.color.colorStatusNegativePure
            }
        }
        
        private func getBackgroundColor() -> Color {
            switch parameters.status {
            case .info:
                return (Color(Ocean.color.colorInterfaceLightUp))
            case .negative:
                return (Color(Ocean.color.colorStatusNegativeUp))
            }
        }
    }
}
