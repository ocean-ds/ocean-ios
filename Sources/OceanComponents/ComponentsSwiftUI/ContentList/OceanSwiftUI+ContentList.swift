//
//  OceanSwiftUI+ContentList.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 04/09/24.
//

import Foundation
import OceanTokens
import SwiftUI

extension OceanSwiftUI {
    
    // MARK: Parameter
    
    public class ContentListParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var descriptionColor: UIColor?
        @Published public var descriptionFont: UIFont?
        @Published public var newDescription: String
        @Published public var caption: String
        @Published public var captionColor: UIColor
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var errorMessage: String
        @Published public var type: ContentListItemType
        @Published public var isInverted: Bool
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets
        /// Typography scale of the block. `.md` (default) keeps the current rendering; `.sm` is the
        /// compact scale used by child rows (title `captionBold`, description `description`).
        @Published public var size: Size
        /// Original value shown struck through before `description` when `type == .strikethrough`.
        @Published public var strikethroughText: String

        /// Set by the Transaction List family so the block follows the Figma metrics also in `.md`
        /// (caption `captionBold` 4pt below, description `Interface/Dark/Deep`). Existing callers keep
        /// the legacy rendering.
        var usesFamilyMetrics = false

        public init(title: String = "",
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    descriptionFont: UIFont? = nil,
                    newDescription: String = "",
                    caption: String = "",
                    captionColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .warning,
                    errorMessage: String = "",
                    type: ContentListItemType = .default,
                    isInverted: Bool = false,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs),
                    size: Size = .md,
                    strikethroughText: String = "") {
            self.title = title
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
            self.isInverted = isInverted
            self.showSkeleton = showSkeleton
            self.padding = padding
            self.size = size
            self.strikethroughText = strikethroughText
        }

        public enum Size {
            case md
            case sm
        }

        public enum ContentListItemType {
            case `default`
            @available(*, deprecated, message: "Use isInverted = true no ContentListParameters. Este case sera removido em versao futura.")
            case inverted
            case inactive
            case highlight
            case highlightLead
            case positive
            case warning
            case strikethrough
        }

        /// Copy used by composed components: same content, with the state they control replaced.
        func resolved(type: ContentListItemType? = nil,
                      showSkeleton: Bool? = nil,
                      padding: EdgeInsets? = nil,
                      usesFamilyMetrics: Bool? = nil) -> ContentListParameters {
            let copy = ContentListParameters(title: title,
                                             description: description,
                                             descriptionColor: descriptionColor,
                                             descriptionFont: descriptionFont,
                                             newDescription: newDescription,
                                             caption: caption,
                                             captionColor: captionColor,
                                             tagTitle: tagTitle,
                                             tagStatus: tagStatus,
                                             errorMessage: errorMessage,
                                             type: type ?? self.type,
                                             isInverted: isInverted,
                                             showSkeleton: showSkeleton ?? self.showSkeleton,
                                             padding: padding ?? self.padding,
                                             size: size,
                                             strikethroughText: strikethroughText)
            copy.usesFamilyMetrics = usesFamilyMetrics ?? self.usesFamilyMetrics
            return copy
        }

        /// The Figma metrics apply to the compact size, to the types added with the Transaction List
        /// family and to the family itself; the legacy `.md` rendering is kept for everything else.
        var appliesFigmaMetrics: Bool {
            if usesFamilyMetrics || size == .sm { return true }

            switch type {
            case .positive, .warning, .strikethrough:
                return true
            case .default, .inverted, .inactive, .highlight, .highlightLead:
                return false
            }
        }
    }
    
    public struct ContentList: View {
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (ContentList) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: ContentListParameters
        
        // MARK: Private properties
        
        // MARK: Constructors
        
        public init(parameters: ContentListParameters = ContentListParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            HStack(spacing: 0) {
                if parameters.showSkeleton {
                    OceanSwiftUI.Skeleton { view in
                        view.parameters.lines = 2
                    }
                } else if parameters.appliesFigmaMetrics {
                    figmaContent
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: Ocean.size.spacingStackXxxs) {
                            if !parameters.title.isEmpty {
                                Typography.description { label in
                                    label.parameters.text = parameters.title
                                    label.parameters.textColor = getTitleColor()
                                }
                            }
                            
                            if !parameters.tagTitle.isEmpty {
                                Tag { tag in
                                    tag.parameters.label = parameters.tagTitle
                                    tag.parameters.status = parameters.tagStatus
                                }
                            }
                        }
                        
                        HStack(spacing: Ocean.size.spacingStackXxxs) {
                            if !parameters.description.isEmpty {
                                Typography.paragraph { label in
                                    label.parameters.text = parameters.description
                                    label.parameters.font = getFont()
                                    
                                    if parameters.newDescription.isEmpty {
                                        label.parameters.textColor = getDescriptionColor()
                                    } else {
                                        label.parameters.strikethrough = true
                                        label.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                                    }
                                }
                            }
                            
                            if !parameters.newDescription.isEmpty {
                                OceanSwiftUI.Typography.paragraph { label in
                                    label.parameters.text = parameters.newDescription
                                    label.parameters.textColor = getDescriptionColor()
                                    label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                                }
                            }
                        }
                        
                        if !parameters.caption.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)
                            
                            Typography.caption { label in
                                label.parameters.text = parameters.caption
                                label.parameters.textColor = parameters.captionColor
                            }
                        }
                        
                        if !parameters.errorMessage.isEmpty {
                            Spacer()
                                .frame(height: Ocean.size.spacingStackXxs)
                            
                            Typography.caption { label in
                                label.parameters.text = parameters.errorMessage
                                label.parameters.textColor = Ocean.color.colorStatusNegativePure
                            }
                        }
                    }
                }
                
                Spacer()
                
            }
            .padding(parameters.padding)
        }
        
        // MARK: Figma metrics (size `.sm`, new types and the Transaction List family)

        private var figmaContent: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: Ocean.size.spacingStackXxxs) {
                        if !parameters.title.isEmpty {
                            Typography { label in
                                label.parameters.text = parameters.title
                                label.parameters.font = figmaTitleFont
                                label.parameters.textColor = figmaTitleColor
                                label.parameters.lineSpacing = figmaLineSpacing(figmaTitleFont)
                                label.parameters.lineLimit = transactionListTextLineLimit
                            }
                            .figmaLineHeight(figmaTitleFont)
                        }

                        if !parameters.tagTitle.isEmpty {
                            Tag { tag in
                                tag.parameters.label = parameters.tagTitle
                                tag.parameters.status = parameters.tagStatus
                            }
                        }
                    }

                    HStack(alignment: .firstTextBaseline, spacing: Ocean.size.spacingStackXxxs) {
                        if parameters.type == .strikethrough && !parameters.strikethroughText.isEmpty {
                            Typography { label in
                                label.parameters.text = parameters.strikethroughText
                                label.parameters.font = figmaStrikethroughFont
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.strikethrough = true
                                label.parameters.strikethroughColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.lineSpacing = figmaLineSpacing(figmaStrikethroughFont)
                            }
                            .figmaLineHeight(figmaStrikethroughFont)
                            .fixedSize()
                        }

                        if !parameters.description.isEmpty {
                            Typography { label in
                                label.parameters.text = parameters.description
                                label.parameters.font = resolvedFigmaDescriptionFont
                                label.parameters.textColor = parameters.newDescription.isEmpty
                                    ? figmaDescriptionColor
                                    : Ocean.color.colorInterfaceDarkUp
                                label.parameters.strikethrough = !parameters.newDescription.isEmpty
                                label.parameters.strikethroughColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.lineSpacing = figmaLineSpacing(resolvedFigmaDescriptionFont)
                                label.parameters.lineLimit = transactionListTextLineLimit
                            }
                            .figmaLineHeight(resolvedFigmaDescriptionFont)
                        }

                        if !parameters.newDescription.isEmpty {
                            Typography { label in
                                label.parameters.text = parameters.newDescription
                                label.parameters.font = resolvedFigmaDescriptionFont
                                label.parameters.textColor = figmaDescriptionColor
                                label.parameters.lineSpacing = figmaLineSpacing(resolvedFigmaDescriptionFont)
                                label.parameters.lineLimit = transactionListTextLineLimit
                            }
                            .figmaLineHeight(resolvedFigmaDescriptionFont)
                        }
                    }
                }

                if !parameters.caption.isEmpty {
                    Typography.captionBold { label in
                        label.parameters.text = parameters.caption
                        label.parameters.textColor = parameters.type == .inactive
                            ? Ocean.color.colorInterfaceDarkUp
                            : parameters.captionColor
                        label.parameters.lineSpacing = figmaLineSpacing(Self.figmaCaptionBoldFont)
                        label.parameters.lineLimit = transactionListTextLineLimit
                    }
                    .figmaLineHeight(Self.figmaCaptionBoldFont)
                }

                if !parameters.errorMessage.isEmpty {
                    Typography.caption { label in
                        label.parameters.text = parameters.errorMessage
                        label.parameters.textColor = Ocean.color.colorStatusNegativePure
                        label.parameters.lineSpacing = figmaLineSpacing(Self.figmaCaptionFont)
                    }
                    .figmaLineHeight(Self.figmaCaptionFont)
                }
            }
        }

        static let figmaCaptionBoldFont = UIFont.baseSemiBold(size: Ocean.font.fontSizeXxxs)
        static let figmaCaptionFont = UIFont.baseRegular(size: Ocean.font.fontSizeXxxs)

        var figmaStrikethroughFont: UIFont? { .baseRegular(size: figmaDescriptionSize) }

        var resolvedFigmaDescriptionFont: UIFont? { parameters.descriptionFont ?? figmaDescriptionFont }

        var figmaTitleFont: UIFont? {
            parameters.size == .sm
                ? .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                : .baseRegular(size: Ocean.font.fontSizeXxs)
        }

        var figmaTitleColor: UIColor {
            parameters.type == .inactive ? Ocean.color.colorInterfaceDarkUp : Ocean.color.colorInterfaceDarkDown
        }

        var figmaDescriptionSize: CGFloat {
            parameters.size == .sm ? Ocean.font.fontSizeXxs : Ocean.font.fontSizeXs
        }

        var figmaDescriptionFont: UIFont? {
            switch (parameters.type, parameters.size) {
            case (.highlight, _):
                return .baseBold(size: figmaDescriptionSize)
            case (.highlightLead, .md):
                return .baseBold(size: Ocean.font.fontSizeSm)
            case (.highlightLead, .sm):
                return .baseRegular(size: Ocean.font.fontSizeXs)
            default:
                return .baseRegular(size: figmaDescriptionSize)
            }
        }

        var figmaDescriptionColor: UIColor {
            // Inactive (disabled rows) always wins: a disabled row never keeps a custom color.
            if parameters.type == .inactive {
                return Ocean.color.colorInterfaceDarkUp
            }

            if let descriptionColor = parameters.descriptionColor {
                return descriptionColor
            }

            switch parameters.type {
            case .default, .inverted, .highlight, .highlightLead:
                return Ocean.color.colorInterfaceDarkDeep
            case .inactive:
                return Ocean.color.colorInterfaceDarkUp
            case .positive, .strikethrough:
                return Ocean.color.colorStatusPositiveDeep
            case .warning:
                return Ocean.color.colorStatusWarningDeep
            }
        }

        // MARK: Private Methods
        
        private var resolvedInverted: Bool {
            parameters.isInverted || parameters.type == .inverted
        }

        private func getTitleColor() -> UIColor {
            if resolvedInverted {
                return Ocean.color.colorInterfaceDarkDown
            }

            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkPure
            case .inverted, .inactive, .highlight, .highlightLead, .positive, .warning, .strikethrough:
                return Ocean.color.colorInterfaceDarkDown
            }
        }

        private func getDescriptionColor() -> UIColor {
            if let descriptionColor = parameters.descriptionColor {
                return descriptionColor
            }

            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkDown
            case .inverted:
                return Ocean.color.colorInterfaceDarkPure
            case .inactive:
                return Ocean.color.colorInterfaceDarkUp
            case .highlight, .highlightLead:
                return Ocean.color.colorInterfaceDarkDeep
            case .positive, .warning, .strikethrough:
                return figmaDescriptionColor
            }
        }

        private func getFont() -> UIFont? {
            if let font = parameters.descriptionFont { return font }

            switch parameters.type {
            case .highlight:
                return .baseBold(size: Ocean.font.fontSizeXs)
            case .highlightLead:
                return .baseBold(size: Ocean.font.fontSizeSm)
            default:
                return .baseRegular(size: Ocean.font.fontSizeXs)
            }
        }
    }
}
