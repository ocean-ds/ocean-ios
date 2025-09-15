//
//  OceanSwiftUI+CardReadOnly.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 15/09/25.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class CardReadOnlyParameters: ObservableObject {
        @Published public var title: String
        @Published public var titleColor: UIColor
        @Published public var description: String
        @Published public var descriptionColor: UIColor?
        @Published public var descriptionFont: UIFont?
        @Published public var newDescription: String
        @Published public var caption: String
        @Published public var captionColor: UIColor
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var errorMessage: String
        @Published public var type: ContentListParameters.ContentListItemType
        @Published public var showSkeleton: Bool
        @Published public var backgroundColor: UIColor
        @Published public var cornerRadius: CGFloat
        @Published public var borderColor: UIColor?
        @Published public var borderWidth: CGFloat
        @Published public var contentPadding: EdgeInsets
        @Published public var cardPadding: EdgeInsets

        public init(title: String = "",
                    description: String = "",
                    titleColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    descriptionColor: UIColor? = nil,
                    descriptionFont: UIFont? = nil,
                    newDescription: String = "",
                    caption: String = "",
                    captionColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .warning,
                    errorMessage: String = "",
                    type: ContentListParameters.ContentListItemType = .default,
                    showSkeleton: Bool = false,
                    backgroundColor: UIColor = Ocean.color.colorInterfaceLightPure,
                    cornerRadius: CGFloat = Ocean.size.borderRadiusMd,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = Ocean.size.borderWidthHairline,
                    contentPadding: EdgeInsets = .all(Ocean.size.spacingStackXs),
                    cardPadding: EdgeInsets = .all(0)) {
            self.title = title
            self.titleColor = titleColor
            self.description = description
            self.descriptionColor = descriptionColor
            self.descriptionFont = descriptionFont
            self.newDescription = newDescription
            self.caption = caption
            self.captionColor = captionColor
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.errorMessage = errorMessage
            self.type = type
            self.showSkeleton = showSkeleton
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.contentPadding = contentPadding
            self.cardPadding = cardPadding
        }
    }

    public struct CardReadOnly: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardReadOnly) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardReadOnlyParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: CardReadOnlyParameters = CardReadOnlyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                ContentList { contentList in
                    contentList.parameters.title = parameters.title
                    contentList.parameters.description = parameters.description
                    contentList.parameters.descriptionColor = parameters.descriptionColor
                    contentList.parameters.descriptionFont = parameters.descriptionFont
                    contentList.parameters.newDescription = parameters.newDescription
                    contentList.parameters.caption = parameters.caption
                    contentList.parameters.captionColor = parameters.captionColor
                    contentList.parameters.tagTitle = parameters.tagTitle
                    contentList.parameters.tagStatus = parameters.tagStatus
                    contentList.parameters.errorMessage = parameters.errorMessage
                    contentList.parameters.type = parameters.type
                    contentList.parameters.showSkeleton = parameters.showSkeleton
                    contentList.parameters.padding = parameters.contentPadding
                }
            }
            .background(Color(parameters.backgroundColor))
            .border(cornerRadius: parameters.cornerRadius,
                    width: parameters.borderWidth,
                    color: parameters.borderColor ?? Ocean.color.colorInterfaceLightDown)
            .padding(parameters.cardPadding)
        }
    }
}
