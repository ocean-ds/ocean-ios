//
//  OceanSwiftUI+Tag.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 24/11/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class TagParameters: ObservableObject {
        @Published public var label: String
        @Published public var hasLabelBold: Bool
        @Published public var icon: UIImage?
        @Published public var status: Status
        @Published public var size: Size
        @Published public var showSkeleton: Bool

        public enum Status {
            case positive
            case warning
            case negative
            case complementary
            case neutralInterface
            case neutralPrimary
            case highlightImportant
            case highlightNeutral
        }

        public enum Size {
            case medium
            case small
        }

        public init(label: String = "",
                    hasLabelBold: Bool = false,
                    icon: UIImage? = nil,
                    status: Status = .positive,
                    size: Size = .medium,
                    showSkeleton: Bool = false) {
            self.label = label
            self.hasLabelBold = hasLabelBold
            self.icon = icon
            self.status = status
            self.size = size
            self.showSkeleton = showSkeleton
        }
    }

    public struct Tag: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Tag) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TagParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TagParameters = TagParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack {
                HStack {
                    if let icon = self.parameters.icon {
                        Image(uiImage: icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 16, height: 16, alignment: .center)
                            .foregroundColor(Color(self.getColor()))

                        Spacer().frame(width: Ocean.size.spacingStackXxxs)
                    }

                    if parameters.hasLabelBold {
                        OceanSwiftUI.Typography.captionBold { label in
                            label.parameters.text = self.parameters.label
                            label.parameters.textColor = self.getColor()
                        }
                    } else {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = self.parameters.label
                            label.parameters.textColor = self.getColor()
                        }
                    }
                }
                .padding(.horizontal, self.parameters.size == .medium ? Ocean.size.spacingStackXxs : Ocean.size.spacingStackXxxs)
            }
            .background(Color(self.getBackgroundColor()))
            .cornerRadius(Ocean.size.borderRadiusLg)
            .oceanSkeleton(isActive: self.parameters.showSkeleton)
        }

        // MARK: Methods private

        private func getColor() -> UIColor {
            switch parameters.status {
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusWarningDeep
            case .negative:
                return Ocean.color.colorStatusNegativePure
            case .complementary:
                return Ocean.color.colorComplementaryPure
            case .neutralInterface:
                return Ocean.color.colorInterfaceDarkUp
            case .neutralPrimary:
                return Ocean.color.colorBrandPrimaryDown
            case .highlightImportant, .highlightNeutral:
                return Ocean.color.colorInterfaceLightPure
            }
        }

        private func getBackgroundColor() -> UIColor {
            switch parameters.status {
            case .positive:
                return Ocean.color.colorStatusPositiveUp
            case .warning:
                return Ocean.color.colorStatusWarningUp
            case .negative:
                return Ocean.color.colorStatusNegativeUp
            case .complementary:
                return Ocean.color.colorComplementaryPure.withAlphaComponent(Ocean.size.opacityLevelSemitransparent)
            case .neutralInterface:
                return Ocean.color.colorInterfaceLightUp
            case .neutralPrimary:
                return Ocean.color.colorInterfaceLightUp
            case .highlightImportant:
                return Ocean.color.colorHighlightPure
            case .highlightNeutral:
                return Ocean.color.colorBrandPrimaryDown
            }
        }
    }
}
