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
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs)) {
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
        }

        public enum ContentListItemType {
            case `default`
            @available(*, deprecated, message: "Use isInverted = true no ContentListParameters. Este case sera removido em versao futura.")
            case inverted
            case inactive
            case highlight
            case highlightLead
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
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: Ocean.size.spacingStackXxxs) {
                            if !parameters.title.isEmpty {
                                Typography.description { label in
                                    label.parameters.text = parameters.title
                                    label.parameters.font = getTitleFont()
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
                                    label.parameters.font = getDescriptionFont()

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
        
        // MARK: Private Methods

        /// Cor base que a title assume quando o componente NAO esta invertido.
        private func titleColorForType() -> UIColor {
            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkPure
            case .inverted, .inactive, .highlight, .highlightLead:
                return Ocean.color.colorInterfaceDarkDown
            }
        }

        /// Cor base que a description assume quando o componente NAO esta invertido.
        private func descriptionColorForType() -> UIColor {
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
            }
        }

        /// Fonte base que a description assume quando o componente NAO esta invertido.
        private func descriptionFontForType() -> UIFont? {
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

        /// Fonte base que a title assume quando o componente NAO esta invertido
        /// (14pt regular, espelhando o default de Typography.description).
        private func titleFontForType() -> UIFont? {
            return .baseRegular(size: Ocean.font.fontSizeXxs)
        }

        // isInverted (novo): troca cor E fonte entre title/description.
        // type == .inverted (legacy): continua trocando somente cores, sem mexer em fonte.

        private func getTitleColor() -> UIColor {
            if parameters.isInverted {
                return descriptionColorForType()
            }
            return titleColorForType()
        }

        private func getDescriptionColor() -> UIColor {
            if parameters.isInverted {
                return titleColorForType()
            }
            return descriptionColorForType()
        }

        private func getTitleFont() -> UIFont? {
            parameters.isInverted ? descriptionFontForType() : nil
        }

        private func getDescriptionFont() -> UIFont? {
            parameters.isInverted ? titleFontForType() : descriptionFontForType()
        }
    }
}
