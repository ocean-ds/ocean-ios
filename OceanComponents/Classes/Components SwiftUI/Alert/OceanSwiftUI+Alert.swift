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
        @Published public var tooltipText: String
        @Published public var hasCornerRadius: Bool
        public var actionOnTouch: () -> Void

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
            case inverted
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
                    tooltipText: String = "",
                    hasCornerRadius: Bool = true,
                    actionOnTouch: @escaping () -> Void = { }) {
            self.title = title
            self.text = text
            self.icon = icon
            self.withIcon = withIcon
            self.status = status
            self.style = style
            self.actionText = actionText
            self.actionType = actionType
            self.tooltipText = tooltipText
            self.hasCornerRadius = hasCornerRadius
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
        @State var position: CGPoint = .zero
        private var iconWidth: CGFloat = 24
        private var iconHeight: CGFloat = 24
        private let coordinateSpaceName = UUID()
        private var cornerRadius: CGFloat { parameters.hasCornerRadius ? Ocean.size.borderRadiusMd : 0 }

        // MARK: Properties private

        private var icon: UIImage {
            if let providedIcon = parameters.icon {
                return providedIcon
            }
            return getIconImage()
        }

        @ViewBuilder
        private var iconImage: some View {
            if self.parameters.withIcon {
                Image(uiImage: icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: iconWidth, height: iconHeight, alignment: .center)
                    .foregroundColor(Color(getForegroundColor()))
                Spacer().frame(width: Ocean.size.spacingStackXxs)
            }
        }

        @ViewBuilder
        private var titleView: some View {
            if !parameters.title.isEmpty {
                HStack(spacing: Ocean.size.spacingStackXxxs) {
                    if parameters.style == .inverted {
                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = parameters.title
                            label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                        }
                    } else {
                        OceanSwiftUI.Typography.heading5 { label in
                            label.parameters.text = parameters.title
                            label.parameters.textColor = getForegroundColor()
                        }
                    }

                    if !parameters.tooltipText.isEmpty {
                        OceanSwiftUI.Tooltip { tooltip in
                            tooltip.parameters.text = parameters.tooltipText
                        }
                    }
                }
            }
        }

        @ViewBuilder
        private var textView: some View {
            if !parameters.text.isEmpty {
                if parameters.style == .inverted {
                    OceanSwiftUI.Typography.paragraph { label in
                        label.parameters.text = parameters.text
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                    }
                } else {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = parameters.text
                    }
                }
            }
        }

        @ViewBuilder
        private var withActionLink: some View {
            if self.parameters.actionType == .link && !self.parameters.actionText.isEmpty {
                OceanSwiftUI.Link.primaryTiny { link in
                    link.parameters.text = self.parameters.actionText
                    link.parameters.type = .chevron
                    link.parameters.textColor = getForegroundColor()
                    link.parameters.onTouch = parameters.actionOnTouch
                }
            }
        }

        @ViewBuilder
        private var withActionButton: some View {
            if self.parameters.actionType == .button && !self.parameters.actionText.isEmpty {
                OceanSwiftUI.Button { button in
                    button.parameters.text = self.parameters.actionText
                    button.parameters.onTouch = self.parameters.actionOnTouch
                    button.parameters.size = .small
                    button.parameters.style = self.getButtonStyle()
                }
                .fixedSize(horizontal: true, vertical: false)
            }
        }

        @ViewBuilder
        private var defaultView: some View {
            HStack(alignment: .center, spacing: 0) {
                iconImage

                textView

                Spacer()
            }
        }

        @ViewBuilder
        private var longDescriptionView: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                    HStack(alignment: .center, spacing: 0) {
                        iconImage

                        titleView

                        Spacer()
                    }
                    .padding(.bottom, Ocean.size.spacingStackXxs)

                    textView

                    withActionLink
                }
                Spacer()

                withActionButton
            }
        }

        @ViewBuilder
        private var shortDescriptionView: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                iconImage

                VStack(alignment: .leading, spacing: 0) {
                    titleView

                    textView

                    withActionLink
                }

                Spacer()

                withActionButton
            }
        }

        @ViewBuilder
        private var invertedView: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                iconImage

                VStack(alignment: .leading, spacing: 0) {
                    titleView

                    textView

                    withActionLink
                }
                Spacer()

                withActionButton
            }
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
                case .inverted:
                    invertedView
                }
            }
            .padding(Ocean.size.spacingStackXs)
            .background(getBackgroundColor())
            .cornerRadius(cornerRadius)
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
                return Ocean.color.colorStatusWarningDeep
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
                return Color(Ocean.color.colorStatusWarningUp)
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
