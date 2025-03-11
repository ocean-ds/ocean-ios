//
//  OceanSwiftUI+SettingsListItem.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 18/06/24.
//

import Foundation
import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class SettingsListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var descriptionColor: UIColor?
        @Published public var descriptionFont: UIFont?
        @Published public var newDescription: String
        @Published public var caption: String
        @Published public var errorMessage: String
        @Published public var type: SettingsListItemType
        @Published public var hasDivider: Bool
        @Published public var hasNewTag: Bool
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var buttonTitle: String
        @Published public var buttonStyle: ButtonParameters.Style
        @Published public var buttonIsLoading: Bool
        @Published public var contentType: ContentListParameters.ContentListItemType
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets
        public var buttonAction: () -> Void

        public init(title: String = "",
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    descriptionFont: UIFont? = nil,
                    newDescription: String = "",
                    caption: String = "",
                    errorMessage: String = "",
                    type: SettingsListItemType = .button,
                    hasDivider: Bool = true,
                    hasNewTag: Bool = false,
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .warning,
                    buttonTitle: String = "",
                    buttonStyle: ButtonParameters.Style = .primary,
                    buttonIsLoading: Bool = false,
                    contentType: ContentListParameters.ContentListItemType = .default,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
                    buttonAction: @escaping () -> Void = { }) {
            self.title = title
            self.description = description
            self.descriptionColor = descriptionColor
            self.descriptionFont = descriptionFont
            self.newDescription = newDescription
            self.caption = caption
            self.errorMessage = errorMessage
            self.type = type
            self.hasDivider = hasDivider
            self.hasNewTag = hasNewTag
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.buttonTitle = buttonTitle
            self.buttonStyle = buttonStyle
            self.buttonIsLoading = buttonIsLoading
            self.contentType = contentType
            self.showSkeleton = showSkeleton
            self.padding = padding
            self.buttonAction = buttonAction
        }

        public enum SettingsListItemType {
            case button
            case tag
            case blocked
        }
    }

    public struct SettingsListItem: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (SettingsListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SettingsListItemParameters

        // MARK: Private properties

        @ViewBuilder
        private var trailingView: some View {
            VStack(alignment: .trailing, spacing: 0) {
                switch parameters.type {
                case .button:
                    if !parameters.buttonTitle.isEmpty {
                        Button { button in
                            button.parameters.text = parameters.buttonTitle
                            button.parameters.style = parameters.buttonStyle
                            button.parameters.size = .small
                            button.parameters.isLoading = parameters.buttonIsLoading
                            button.parameters.hasPadding = getHasPadding()
                            button.parameters.onTouch = parameters.buttonAction
                        }
                    }
                case .blocked:
                    Image(uiImage: Ocean.icon.lockClosedSolid)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .frame(width: 20, height: 20)
                case .tag:
                    if !parameters.tagTitle.isEmpty {
                        Tag { tag in
                            tag.parameters.label = parameters.tagTitle
                            tag.parameters.status = parameters.tagStatus
                        }
                    }
                }
            }
        }

        // MARK: Constructors

        public init(parameters: SettingsListItemParameters = SettingsListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    if parameters.showSkeleton {
                        OceanSwiftUI.Skeleton { view in
                            view.parameters.lines = 2
                        }
                    } else {
                        ContentList { view in
                            view.parameters.title = parameters.title
                            view.parameters.description = parameters.description
                            view.parameters.newDescription = parameters.newDescription
                            view.parameters.descriptionColor = parameters.descriptionColor
                            view.parameters.descriptionFont = parameters.descriptionFont
                            view.parameters.caption = parameters.caption
                            view.parameters.tagTitle = parameters.hasNewTag ? "Novo" : ""
                            view.parameters.tagStatus = .highlightImportant
                            view.parameters.errorMessage = parameters.errorMessage
                            view.parameters.type = parameters.contentType
                            view.parameters.padding = .all(.zero)
                        }
                        .layoutPriority(1)
                    }

                    Spacer()
                        .frame(minWidth: Ocean.size.spacingStackXxs)

                    if parameters.showSkeleton {
                        Button.primarySM { view in
                            view.parameters.showSkeleton = true
                        }
                    } else {
                        trailingView
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                .padding(parameters.padding)

                if parameters.hasDivider {
                    Divider()
                }
            }
        }

        // MARK: Private Methods

        private func getHasPadding() -> Bool {
            switch parameters.buttonStyle {
            case .tertiary, .tertiaryCritical:
                return false
            default:
                return true
            }
        }
    }
}
