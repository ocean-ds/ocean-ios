//
//  OceanSwiftUI+SettingListItem.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 18/06/24.
//

import Foundation
import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class SettingListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var caption: String
        @Published public var hasDivider: Bool
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var type: SettingListItemType
        @Published public var buttonTitle: String
        public var buttonAction: () -> Void
        @Published public var showSkeleton: Bool

        public init(title: String = "",
                    description: String = "",
                    caption: String = "",
                    hasDivider: Bool = true,
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .warning,
                    type: SettingListItemType = .unchangedPrimary,
                    buttonTitle: String = "",
                    buttonAction: @escaping () -> Void = { },
                    showSkeleton: Bool = false) {
            self.title = title
            self.description = description
            self.caption = caption
            self.hasDivider = hasDivider
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.type = type
            self.buttonTitle = buttonTitle
            self.buttonAction = buttonAction
            self.showSkeleton = showSkeleton
        }

        public enum SettingListItemType {
            case unchangedPrimary
            case unchangedSecondary
            case unchangedBlocked
            case pending
            case changedPrimary
            case changedSecondary
            case changedBlocked
        }
    }

    public struct SettingListItem: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (SettingListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SettingListItemParameters

        // MARK: Private properties

        @ViewBuilder
        private var leadingView: some View {
            VStack(alignment: .leading, spacing: 0) {
                if !parameters.title.isEmpty {
                    Typography.description { label in
                        label.parameters.text = parameters.title
                    }
                }

                if !parameters.description.isEmpty {
                    Typography.paragraph { label in
                        label.parameters.text = parameters.description
                        label.parameters.textColor = getDescriptionColor()
                    }
                }

                if !parameters.caption.isEmpty {
                    Spacer()
                        .frame(height: Ocean.size.spacingStackXxs)

                    Typography.caption { label in
                        label.parameters.text = parameters.caption
                    }
                }
            }
        }

        @ViewBuilder
        private var trailingView: some View {
            VStack(alignment: .trailing, spacing: 0) {
                switch parameters.type {
                case .unchangedPrimary, .unchangedSecondary, .changedPrimary, .changedSecondary:
                    if !parameters.buttonTitle.isEmpty {
                        Button { button in
                            button.parameters.text = parameters.buttonTitle
                            button.parameters.style = getButtonStyle()
                            button.parameters.size = .small
                            button.parameters.onTouch = parameters.buttonAction
                        }
                    }
                case .unchangedBlocked, .changedBlocked:
                    Image(uiImage: Ocean.icon.lockClosedSolid)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .frame(width: 20, height: 20)
                default:
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

        public init(parameters: SettingListItemParameters = SettingListItemParameters()) {
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
                        leadingView
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
                .padding(.all, Ocean.size.spacingStackXs)

                if parameters.hasDivider {
                    Divider()
                }
            }
        }

        // MARK: Private Methods

        private func getDescriptionColor() -> UIColor {
            switch parameters.type {
            case .changedBlocked, .changedPrimary, .changedSecondary:
                return Ocean.color.colorInterfaceDarkPure
            default:
                return Ocean.color.colorInterfaceDarkUp
            }
        }

        private func getButtonStyle() -> ButtonParameters.Style {
            switch parameters.type {
            case .unchangedPrimary, .changedPrimary:
                return .primary
            default:
                return .secondary
            }
        }
    }
}
