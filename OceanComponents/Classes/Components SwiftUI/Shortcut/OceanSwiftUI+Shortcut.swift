//
//  OceanSwiftUI+Shortcut.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 10/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class ShortcutParameters: ObservableObject {
        @Published public var items: [ShortcutModel]
        @Published public var cols: Int
        @Published public var size: Size
        @Published public var orientation: Orientation
        @Published public var showSkeleton: Bool
        public var onTouch: (ShortcutModel) -> Void = { _ in }

        public enum Size {
            case tiny
            case small
            case medium
        }

        public enum Orientation {
            case horizontal
            case vertical
        }

        public init(items: [ShortcutModel] = [],
                    cols: Int = 2,
                    size: Size = .small,
                    orientation: Orientation = .vertical,
                    showSkeleton: Bool = false,
                    onTouch: @escaping (ShortcutModel) -> Void = { _ in }) {
            self.items = items
            self.cols = cols
            self.size = size
            self.orientation = orientation
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
    }

    public class ShortcutModel: ObservableObject, Identifiable {
        @Published public var icon: UIImage?
        @Published public var badgeNumber: Int?
        @Published public var badgeStatus: BadgeParameters.Status
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var blocked: Bool

        public init(icon: UIImage? = nil,
                    badgeNumber: Int? = nil,
                    badgeStatus: BadgeParameters.Status = .warning,
                    title: String,
                    subtitle: String = "",
                    blocked: Bool = false) {
            self.icon = icon
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
            self.title = title
            self.subtitle = subtitle
            self.blocked = blocked
        }
    }

    public struct Shortcut: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Shortcut) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ShortcutParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: ShortcutParameters = ShortcutParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: Ocean.size.spacingStackXxs) {
                let chunks = self.parameters.items.chunked(into: self.parameters.cols)

                ForEach(0..<chunks.count, id: \.self) { chunksIndex in
                    HStack(spacing: Ocean.size.spacingStackXxs) {
                        ForEach(0..<chunks[chunksIndex].count, id: \.self) { index in
                            let item = chunks[chunksIndex][index]

                            SwiftUI.Button(action: {
                                self.parameters.onTouch(item)
                            }, label: {
                                HStack(spacing: 0) {
                                    if self.parameters.orientation == .vertical {
                                        self.getViewVertical(item: item)
                                    } else {
                                        self.getViewHorizontal(item: item)
                                    }

                                    Spacer()
                                }
                                .padding(.all, Ocean.size.spacingStackXs)
                                .overlay(self.getOverlay(item: item), alignment: .topTrailing)
                                .border(cornerRadius: Ocean.size.borderRadiusMd,
                                        width: Ocean.size.borderWidthHairline,
                                        color: Ocean.color.colorInterfaceLightDown)
                                .frame(minWidth: 0, maxWidth: .infinity,
                                       minHeight: 0, maxHeight: .infinity)
                            })
                            .buttonStyle(OceanShortcutStyle())
                            .disabled(item.blocked)
                            .layoutPriority(1.0)
                        }

                        let quantityEmpty = self.parameters.cols - chunks[chunksIndex].count
                        ForEach(0..<quantityEmpty, id: \.self) { _ in
                            Spacer()
                                .layoutPriority(1.0)
                        }
                    }
                }
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getViewVertical(item: ShortcutModel) -> some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                if let icon = item.icon {
                    getImage(icon: icon)
                }

                getTitle(title: item.title)

                if self.parameters.size == .medium {
                    getSubtitle(subtitle: item.subtitle)
                }
            }
        }

        @ViewBuilder
        private func getViewHorizontal(item: ShortcutModel) -> some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    if let icon = item.icon {
                        getImage(icon: icon)
                    }

                    getTitle(title: item.title)
                }

                if self.parameters.size == .medium {
                    getSubtitle(subtitle: item.subtitle)
                }
            }
        }

        @ViewBuilder
        private func getImage(icon: UIImage) -> some View {
            Image(uiImage: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24,
                       height: 24,
                       alignment: .center)
                .foregroundColor(Color(Ocean.color.colorBrandPrimaryDown))
        }

        @ViewBuilder
        private func getTitle(title: String) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                OceanSwiftUI.Typography.heading5 { label in
                    label.parameters.text = title
                }
            }
            .frame(minHeight: self.parameters.size == .small ? 40 : 0, maxHeight: .infinity)
        }

        @ViewBuilder
        private func getSubtitle(subtitle: String) -> some View {
            OceanSwiftUI.Typography.caption { label in
                label.parameters.text = subtitle
            }
        }

        @ViewBuilder
        private func getOverlay(item: ShortcutModel) -> some View {
            if let badgeNumber = item.badgeNumber {
                OceanSwiftUI.Badge { badge in
                    badge.parameters.count = badgeNumber
                    badge.parameters.status = item.badgeStatus
                    badge.parameters.size = .small
                }
                .padding(.top, Ocean.size.spacingStackXxs)
                .padding(.trailing, Ocean.size.spacingStackXxs)
            } else if item.blocked {
                Image(uiImage: Ocean.icon.lockClosedSolid)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16,
                           height: 16,
                           alignment: .center)
                    .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    .padding(.top, Ocean.size.spacingStackXxs)
                    .padding(.trailing, Ocean.size.spacingStackXxs)
            }
        }

        // MARK: - Style

        public struct OceanShortcutStyle: ButtonStyle {
            public func makeBody(configuration: Self.Configuration) -> some View {
                configuration.label
                    .background(self.getBackgroundColor(configuration: configuration))
            }

            public func getBackgroundColor(configuration: Self.Configuration) -> Color {
                return configuration.isPressed ? Color(Ocean.color.colorInterfaceLightUp) : Color(Ocean.color.colorInterfaceLightPure)
            }
        }
    }
}
