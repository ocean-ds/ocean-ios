//
//  OceanSwiftUI+Banner.swift
//  OceanComponents
//
//  Created by Mateus Amarante on 09/06/26.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class BannerParameters: ObservableObject {

        public enum Size {
            case large
            case small
        }

        public enum BannerType {
            case `default`
            case warning
            case negative
            case emphasys
        }

        @Published public var size: Size
        @Published public var bannerType: BannerType
        @Published public var title: String
        @Published public var description: String
        @Published public var image: UIImage?
        @Published public var imageURL: String?
        @Published public var buttons: [ButtonParameters]

        public init(size: Size = .large,
                    bannerType: BannerType = .default,
                    title: String = "",
                    description: String = "",
                    image: UIImage? = nil,
                    imageURL: String? = nil,
                    buttons: [ButtonParameters] = []) {
            self.size = size
            self.bannerType = bannerType
            self.title = title
            self.description = description
            self.image = image
            self.imageURL = imageURL
            self.buttons = buttons
        }
    }

    public struct Banner: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Banner) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BannerParameters

        // MARK: Constructors

        public init(parameters: BannerParameters = BannerParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            Group {
                if parameters.size == .large {
                    largeLayout
                } else {
                    smallLayout
                }
            }
            .background(Color(resolvedBackgroundColor))
            .cornerRadius(Ocean.size.borderRadiusSm)
        }

        // MARK: Layouts

        private var largeLayout: some View {
            VStack(alignment: .leading, spacing: 0) {
                if hasImage {
                    bannerImage
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                }

                contentStack
                    .padding(.all, Ocean.size.spacingStackXs)
            }
            .frame(maxWidth: .infinity)
        }

        private var smallLayout: some View {
            HStack(alignment: .top, spacing: Ocean.size.spacingStackXs) {
                contentStack
                    .frame(maxWidth: .infinity, alignment: .leading)

                if hasImage {
                    bannerImage
                        .frame(width: 82, height: 82)
                        .clipped()
                        .cornerRadius(Ocean.size.borderRadiusSm)
                }
            }
            .padding(.all, Ocean.size.spacingStackXs)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var contentStack: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                if !parameters.title.isEmpty {
                    titleView
                }

                if !parameters.description.isEmpty {
                    descriptionView
                }

                if !parameters.buttons.isEmpty {
                    let limitedButtons = Array(parameters.buttons.prefix(2))
                    VStack(spacing: Ocean.size.spacingStackXxs) {
                        ForEach(Array(limitedButtons.enumerated()), id: \.offset) { index, buttonParam in
                            buttonView(for: buttonParam, isPrimary: index == 0)
                        }
                    }
                    .padding(.top, Ocean.size.spacingStackXxsExtra)
                }
            }
        }

        private var titleView: some View {
            Typography.heading4 { label in
                label.parameters.text = self.parameters.title
                label.parameters.textColor = self.resolvedTitleColor
            }
        }

        private var descriptionView: some View {
            Typography.paragraph { label in
                label.parameters.text = self.parameters.description
                label.parameters.textColor = self.resolvedDescriptionColor
            }
        }

        @ViewBuilder
        private func buttonView(for buttonParam: ButtonParameters, isPrimary: Bool) -> some View {
            if isPrimary {
                switch parameters.bannerType {
                case .default:
                    OceanSwiftUI.Button.primarySM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .warning:
                    OceanSwiftUI.Button.primaryWarningSM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .negative:
                    OceanSwiftUI.Button.primaryCriticalSM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .emphasys:
                    OceanSwiftUI.Button.secondarySM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                }
            } else {
                switch parameters.bannerType {
                case .default:
                    OceanSwiftUI.Button.tertiarySM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .warning:
                    OceanSwiftUI.Button.tertiaryWarningSM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .negative:
                    OceanSwiftUI.Button.tertiaryCriticalSM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                case .emphasys:
                    OceanSwiftUI.Button.primaryInverseSM { button in
                        button.parameters.text = buttonParam.text
                        button.parameters.onTouch = buttonParam.onTouch
                    }
                }
            }
        }

        // MARK: Private properties

        private var hasImage: Bool {
            parameters.image != nil || !(parameters.imageURL?.isEmpty ?? true)
        }

        @ViewBuilder
        private var bannerImage: some View {
            if let image = parameters.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if let url = parameters.imageURL, !url.isEmpty {
                OceanSwiftUI.ImageDownload(parameters: .init(url: url, contentMode: .fill))
            }
        }

        private var resolvedBackgroundColor: UIColor {
            switch parameters.bannerType {
            case .default:
                return Ocean.color.colorInterfaceLightUp
            case .warning:
                return Ocean.color.colorStatusWarningUp
            case .negative:
                return Ocean.color.colorStatusNegativeUp
            case .emphasys:
                return Ocean.color.colorBrandPrimaryPure
            }
        }

        private var resolvedTitleColor: UIColor {
            switch parameters.bannerType {
            case .emphasys:
                return Ocean.color.colorInterfaceLightPure
            default:
                return Ocean.color.colorInterfaceDarkDeep
            }
        }

        private var resolvedDescriptionColor: UIColor {
            switch parameters.bannerType {
            case .emphasys:
                return Ocean.color.colorInterfaceLightUp
            default:
                return Ocean.color.colorInterfaceDarkDown
            }
        }
    }
}
