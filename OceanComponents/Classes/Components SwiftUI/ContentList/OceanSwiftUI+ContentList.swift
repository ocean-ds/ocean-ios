//
//  OceanSwiftUI+ContentList.swift
//  DGCharts
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
        @Published public var newDescription: String
        @Published public var caption: String
        @Published public var errorMessage: String
        @Published public var type: ContentListItemType
        @Published public var showSkeleton: Bool
        @Published public var padding: EdgeInsets

        public init(title: String = "",
                    description: String = "",
                    descriptionColor: UIColor? = nil,
                    newDescription: String = "",
                    caption: String = "",
                    errorMessage: String = "",
                    type: ContentListItemType = .default,
                    showSkeleton: Bool = false,
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs)) {
            self.title = title
            self.description = description
            self.descriptionColor = descriptionColor
            self.newDescription = newDescription
            self.caption = caption
            self.errorMessage = errorMessage
            self.type = type
            self.showSkeleton = showSkeleton
            self.padding = padding
        }

        public enum ContentListItemType {
            case `default`
            case inverted
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
                        if !parameters.title.isEmpty {
                            Typography.description { label in
                                label.parameters.text = parameters.title
                                label.parameters.textColor = getTitleColor()
                            }
                        }
                        
                        HStack(spacing: Ocean.size.spacingStackXxxs) {
                            if !parameters.description.isEmpty {
                                Typography.paragraph { label in
                                    label.parameters.text = parameters.description
                                    
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

        private func getDescriptionColor() -> UIColor {
            if let descriptionColor = parameters.descriptionColor {
                return descriptionColor
            }

            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkDown
            case .inverted:
                return Ocean.color.colorInterfaceDarkPure
            }
        }

        private func getTitleColor() -> UIColor {
            switch parameters.type {
            case .default:
                return Ocean.color.colorInterfaceDarkPure
            case .inverted:
                return Ocean.color.colorInterfaceDarkDown
            }
        }
    }
}
