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

        public struct BannerButtonParameters {
            public var text: String
            public var onTouch: () -> Void

            public init(text: String, onTouch: @escaping () -> Void = { }) {
                self.text = text
                self.onTouch = onTouch
            }
        }

        @Published public var size: Size
        @Published public var bannerType: BannerType
        @Published public var title: String
        @Published public var description: String
        @Published public var image: UIImage?
        @Published public var imageURL: String?
        @Published public var backgroundColor: UIColor?
        @Published public var buttons: [BannerButtonParameters]

        public init(size: Size = .large,
                    bannerType: BannerType = .default,
                    title: String = "",
                    description: String = "",
                    image: UIImage? = nil,
                    imageURL: String? = nil,
                    backgroundColor: UIColor? = nil,
                    buttons: [BannerButtonParameters] = []) {
            self.size = size
            self.bannerType = bannerType
            self.title = title
            self.description = description
            self.image = image
            self.imageURL = imageURL
            self.backgroundColor = backgroundColor
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

        // MARK: Private properties

        @State private var downloadedImage: UIImage?

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
            .cornerRadius(Ocean.size.borderRadiusMd)
            .onAppear {
                loadImageIfNeeded()
            }
        }

        // MARK: Layouts

        private var largeLayout: some View {
            VStack(alignment: .leading, spacing: 0) {
                imageView
                    .map { img in
                        AnyView(
                            img
                                .resizable()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        )
                    } ?? AnyView(EmptyView())

                contentStack
                    .padding(.all, Ocean.size.spacingStackXs)
            }
            .frame(maxWidth: .infinity)
        }

        private var smallLayout: some View {
            HStack(alignment: .top, spacing: Ocean.size.spacingStackXs) {
                contentStack
                    .frame(maxWidth: .infinity, alignment: .leading)

                imageView
                    .map { img in
                        AnyView(
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .cornerRadius(Ocean.size.borderRadiusSm)
                        )
                    } ?? AnyView(EmptyView())
            }
            .padding(.all, Ocean.size.spacingStackXs)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        private var contentStack: some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                if !parameters.title.isEmpty {
                    Typography.heading4 { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.textColor = self.resolvedTextColor
                    }
                }

                if !parameters.description.isEmpty {
                    Typography.paragraph { label in
                        label.parameters.text = self.parameters.description
                        label.parameters.textColor = self.resolvedTextColor
                    }
                }

                if !parameters.buttons.isEmpty {
                    let limitedButtons = Array(parameters.buttons.prefix(2))
                    VStack(spacing: Ocean.size.spacingStackXxs) {
                        ForEach(Array(limitedButtons.enumerated()), id: \.offset) { _, buttonParam in
                            buttonView(for: buttonParam)
                        }
                    }
                    .padding(.top, Ocean.size.spacingStackXxs)
                }
            }
        }

        @ViewBuilder
        private func buttonView(for buttonParam: BannerParameters.BannerButtonParameters) -> some View {
            if parameters.bannerType == .emphasys {
                OceanSwiftUI.Button.primaryInverseMD { button in
                    button.parameters.text = buttonParam.text
                    button.parameters.onTouch = buttonParam.onTouch
                }
            } else {
                OceanSwiftUI.Button.primarySM { button in
                    button.parameters.text = buttonParam.text
                    button.parameters.onTouch = buttonParam.onTouch
                }
            }
        }

        // MARK: Helpers

        private var imageView: Image? {
            if let img = parameters.image {
                return Image(uiImage: img)
            }
            if let img = downloadedImage {
                return Image(uiImage: img)
            }
            return nil
        }

        private var resolvedBackgroundColor: UIColor {
            if let custom = parameters.backgroundColor {
                return custom
            }
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

        private var resolvedTextColor: UIColor {
            switch parameters.bannerType {
            case .emphasys:
                return Ocean.color.colorInterfaceLightPure
            default:
                return Ocean.color.colorInterfaceDarkDeep
            }
        }

        private func loadImageIfNeeded() {
            guard parameters.image == nil,
                  let urlString = parameters.imageURL,
                  !urlString.isEmpty else { return }

            urlString.getImage { result in
                if let img = try? result.get() {
                    DispatchQueue.main.async {
                        self.downloadedImage = img
                    }
                }
            }
        }

        // MARK: Methods private
    }
}
