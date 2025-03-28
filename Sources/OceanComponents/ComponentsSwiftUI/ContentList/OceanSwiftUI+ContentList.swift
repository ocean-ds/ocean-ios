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
        @Published public var tagTitle: String
        @Published public var tagStatus: TagParameters.Status
        @Published public var errorMessage: String
        @Published public var type: ContentListItemType
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets
        
        public init(title: String = "",
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    descriptionFont: UIFont? = nil,
                    newDescription: String = "",
                    caption: String = "",
                    tagTitle: String = "",
                    tagStatus: TagParameters.Status = .warning,
                    errorMessage: String = "",
                    type: ContentListItemType = .default,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs)) {
            self.title = title
            self.description = description
            self.descriptionColor = descriptionColor
            self.descriptionFont = descriptionFont
            self.newDescription = newDescription
            self.caption = caption
            self.tagTitle = tagTitle
            self.tagStatus = tagStatus
            self.errorMessage = errorMessage
            self.type = type
            self.showSkeleton = showSkeleton
            self.padding = padding
        }
        
        public enum ContentListItemType {
            case `default`
            case inverted
            case inactive
            case highlight
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
        
        private func getTitleColor() -> UIColor {
            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkPure
            case .inverted, .inactive, .highlight:
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
            case .highlight:
                return Ocean.color.colorInterfaceDarkDeep
            }
        }
        
        private func getFont() -> UIFont? {
            if let font = parameters.descriptionFont { return font }
            
            switch parameters.type {
            case .highlight:
                return .baseBold(size: Ocean.font.fontSizeXs)
            default:
                return .baseRegular(size: Ocean.font.fontSizeXs)
            }
        }
    }
}
