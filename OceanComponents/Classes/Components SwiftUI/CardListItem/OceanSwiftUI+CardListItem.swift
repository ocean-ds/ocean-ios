//
//  OceanSwiftUI+CardListItem.swift
//  Charts
//
//  Created by Renan Massaroto on 22/12/23.
//

import SwiftUI
import OceanTokens
import SkeletonUI

extension OceanSwiftUI {
    // MARK: Parameters

    public class CardListItemParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var caption: String

        @Published public var leadingIcon: UIImage?
        @Published public var trailingIcon: UIImage?

        @Published public var titleLineLimit: Int?
        @Published public var subtitleLineLimit: Int?
        @Published public var captionLineLimit: Int?

        @Published public var onTouch: (() -> Void)

        @Published public var isLoading: Bool = false

        public init(title: String = "", 
                    subtitle: String = "",
                    caption: String = "",
                    leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    titleLineLimit: Int? = nil,
                    subtitleLineLimit: Int? = nil,
                    captionLineLimit: Int? = nil,
                    onTouch: @escaping (() -> Void) = {}) {
            self.title = title
            self.subtitle = subtitle
            self.caption = caption
            self.leadingIcon = leadingIcon
            self.trailingIcon = trailingIcon
            self.titleLineLimit = titleLineLimit
            self.subtitleLineLimit = subtitleLineLimit
            self.captionLineLimit = captionLineLimit
            self.onTouch = onTouch
        }
    }

    struct Constants {
        static let leadingIconSize: CGFloat = 40
        static let leadingIconImageMaxSize: CGFloat = 24
        static let trailingIconImageMaxSize: CGFloat = 20
    }

    public struct CardListItem: View {

        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (CardListItem) -> Void

        // MARK: Properties
        
        @ObservedObject public var parameters: CardListItemParameters

        // MARK: Properties private
        
        // MARK: Constructors
        
        public init(parameters: CardListItemParameters = CardListItemParameters()) {
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
                    if let image = parameters.leadingIcon {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(Ocean.color.colorBrandPrimaryDown))
                                .frame(maxWidth: Constants.leadingIconImageMaxSize, 
                                       maxHeight: Constants.leadingIconImageMaxSize)
                                .skeleton(with: parameters.isLoading)
                        }
                        .frame(width: Constants.leadingIconSize, height: Constants.leadingIconSize)
                        .background(Color(Ocean.color.colorInterfaceLightUp))
                        .cornerRadius(Constants.leadingIconSize / 2)

                        Spacer().frame(width: Ocean.size.spacingInsetSm)
                    }

                    VStack(alignment: .leading) {
                        OceanSwiftUI.Typography.heading4 { label in
                            label.parameters.text = parameters.title
                            label.parameters.lineLimit = parameters.titleLineLimit
                        }
                        .skeleton(with: parameters.isLoading)

                        if !parameters.subtitle.isEmpty {
                            OceanSwiftUI.Typography.description { label in
                                label.parameters.text = parameters.subtitle
                                label.parameters.lineLimit = parameters.subtitleLineLimit
                            }
                        }

                        if !parameters.caption.isEmpty {
                            Spacer().frame(height: Ocean.size.spacingInsetXxs)

                            OceanSwiftUI.Typography.caption { label in
                                label.parameters.text = parameters.caption
                                label.parameters.lineLimit = parameters.captionLineLimit
                            }
                        }
                    }

                    Spacer()

                    if let image = parameters.trailingIcon {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkDown))
                            .frame(maxWidth: Constants.trailingIconImageMaxSize, maxHeight: Constants.trailingIconImageMaxSize)

                        Spacer().frame(width: Ocean.size.spacingInsetXxs)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, Ocean.size.spacingStackXs)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .border(cornerRadius: Ocean.size.borderRadiusMd,
                    width: Ocean.size.borderWidthHairline,
                    color: Ocean.color.colorInterfaceLightDown)
            .onTapGesture { parameters.onTouch() }
        }
    }
}
