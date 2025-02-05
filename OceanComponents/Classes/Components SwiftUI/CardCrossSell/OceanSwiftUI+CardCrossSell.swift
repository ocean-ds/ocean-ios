//
//  OceanSwiftUI+CardCrossSell.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 09/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class CardCrossSellParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var titleColor: UIColor
        @Published public var subtitleColor: UIColor
        @Published public var backgroundColor: UIColor
        @Published public var ctaText: String
        @Published public var ctaIcon: UIImage?
        @Published public var image: UIImage?
        @Published public var isLoading: Bool
        @Published public var showSkeleton: Bool
        public var onTouch: () -> Void

        public init(title: String = "",
                    subtitle: String = "",
                    titleColor: UIColor = Ocean.color.colorInterfaceLightPure,
                    subtitleColor: UIColor = Ocean.color.colorBrandPrimaryUp,
                    backgroundColor: UIColor = Ocean.color.colorBrandPrimaryPure,
                    ctaText: String = "",
                    ctaIcon: UIImage? = Ocean.icon.chevronRightSolid,
                    image: UIImage? = nil,
                    isLoading: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.titleColor = titleColor
            self.subtitleColor = subtitleColor
            self.backgroundColor = backgroundColor
            self.ctaText = ctaText
            self.ctaIcon = ctaIcon
            self.image = image
            self.isLoading = isLoading
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
    }

    public struct CardCrossSell: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardCrossSell) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardCrossSellParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: CardCrossSellParameters = CardCrossSellParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                        if !self.parameters.title.isEmpty {
                            Typography.heading4 { label in
                                label.parameters.text = self.parameters.title
                                label.parameters.textColor = self.parameters.titleColor
                                label.parameters.showSkeleton = self.parameters.showSkeleton
                            }
                        }

                        if !self.parameters.subtitle.isEmpty {
                            Typography.description { label in
                                label.parameters.text = self.parameters.subtitle
                                label.parameters.textColor = self.parameters.subtitleColor
                                label.parameters.showSkeleton = self.parameters.showSkeleton
                            }
                        }
                    }

                    Spacer()

                    if let image = self.parameters.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 72,
                                   height: 72,
                                   alignment: .center)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, Ocean.size.spacingStackXs)
                .background(Color(self.parameters.backgroundColor))
                .cornerRadius(Ocean.size.borderRadiusMd, corners: [.topLeft, .topRight])

                if !parameters.showSkeleton {
                    CardCTA { cardCTA in
                        cardCTA.parameters.text = self.parameters.ctaText
                        cardCTA.parameters.icon = self.parameters.ctaIcon
                        cardCTA.parameters.isLoading = self.parameters.isLoading
                        cardCTA.parameters.onTouch = self.parameters.onTouch
                    }
                }
            }
            .padding(.all, 1)
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(Ocean.size.borderRadiusMd)
            .border(cornerRadius: Ocean.size.borderRadiusMd,
                    width: Ocean.size.borderWidthHairline,
                    color: Ocean.color.colorInterfaceLightDown)
        }

        // MARK: Methods private
    }
}
