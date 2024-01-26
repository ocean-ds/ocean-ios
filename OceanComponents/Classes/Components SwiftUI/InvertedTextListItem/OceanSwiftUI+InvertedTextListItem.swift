//
//  OceanSwiftUI+InvertedTextListItem.swift
//  Charts
//
//  Created by Renan Massaroto on 26/01/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class InvertedTextListItemParameters: ObservableObject {

        @Published public var title: String
        @Published public var subtitle: String
        @Published public var newSubtitle: String
        @Published public var icon: UIImage?
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var status: OceanSwiftUI.InvertedTextListItemParameters.State
        @Published public var showSkeleton: Bool

        public init(title: String = "",
                    subtitle: String = "",
                    newSubtitle: String = "",
                    icon: UIImage? = nil,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .positive,
                    tagSize: OceanSwiftUI.TagParameters.Size = .medium,
                    status: OceanSwiftUI.InvertedTextListItemParameters.State = .normal,
                    showSkeleton: Bool = false) {
            self.title = title
            self.subtitle = subtitle
            self.newSubtitle = newSubtitle
            self.icon = icon
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.status = status
            self.showSkeleton = showSkeleton
        }

        public enum State {
            case normal
            case innactive
            case positive
            case warning
            case highlight
            case strikethrough
        }
    }

    public struct InvertedTextListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()
        
        // MARK: Builder

        public typealias Builder = (InvertedTextListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: InvertedTextListItemParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: InvertedTextListItemParameters = InvertedTextListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading) {
                OceanSwiftUI.Typography.description { label in
                    label.parameters.text = parameters.title
                    label.parameters.textColor = Ocean.color.colorInterfaceDarkDown
                }

                if parameters.showSkeleton {
                    GeometryReader { geometryReader in
                        Rectangle()
                            .skeleton(with: true,
                                      size: CGSize(width: geometryReader.size.width, 
                                                   height: Constants.skeletonHeight),
                                      shape: .rounded(.radius(Ocean.size.borderRadiusSm,
                                                              style: .circular)))
                    }
                } else {
                    HStack {
                        if let image = parameters.icon {
                            Image(uiImage: image)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(getStatusColor()))
                                .frame(width: Constants.iconSize, height: Constants.iconSize)

                            Spacer()
                                .frame(width: Ocean.size.spacingInsetXxs)
                        }

                        OceanSwiftUI.Typography.paragraph { label in
                            label.parameters.text = parameters.subtitle

                            if parameters.newSubtitle.isEmpty {
                                label.parameters.textColor = getStatusColor()
                            } else {
                                label.parameters.strikethrough = true
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                            }

                            if parameters.status == .highlight {
                                label.parameters.font = .baseBold(size: Ocean.font.fontSizeXs)
                            }
                        }

                        if !parameters.newSubtitle.isEmpty {
                            OceanSwiftUI.Typography.paragraph { label in
                                label.parameters.text = parameters.subtitle
                                label.parameters.textColor = getStatusColor()
                                label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                            }
                        }
                    }

                    if !parameters.tagLabel.isEmpty {
                        Spacer()
                            .frame(height: Ocean.size.spacingStackXxs)

                        OceanSwiftUI.Tag { tag in
                            tag.parameters.label = parameters.tagLabel
                            tag.parameters.icon = parameters.tagIcon
                            tag.parameters.status = parameters.tagStatus
                            tag.parameters.size = parameters.tagSize
                        }
                    }
                }

            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(.vertical, Ocean.size.spacingStackXxs)
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }

        private func getStatusColor() -> UIColor {
            switch parameters.status {
            case .innactive:
                return Ocean.color.colorInterfaceDarkUp
            case .positive:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusNeutralDeep
            case .strikethrough:
                return Ocean.color.colorStatusPositiveDeep
            default:
                return Ocean.color.colorInterfaceDarkDeep
            }
        }

        private struct Constants {
            static let iconSize: CGFloat = 20
            static let skeletonHeight: CGFloat = 24
        }
    }
}

struct InvertedTextListItem_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.InvertedTextListItem()
    }
}
