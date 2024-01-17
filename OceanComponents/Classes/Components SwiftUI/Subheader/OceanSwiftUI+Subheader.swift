//
//  SUISubheader.swift
//  Blu
//
//  Created by Renan Massaroto on 16/01/24.
//  Copyright © 2024 Blu. All rights reserved.
//

import SwiftUI
import OceanTokens


extension OceanSwiftUI {

    private struct Constants {
        static let mediumHeight: CGFloat = 40
        static let smallHeight: CGFloat = 32
        static let iconSize: CGFloat = 16
    }

    public enum Size {
        case medium
        case small
    }

    public class SubheaderParameters: ObservableObject {
        @Published public var icon: UIImage?
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var size: Size

        public init(icon: UIImage? = nil,
                    title: String = "",
                    subtitle: String = "",
                    size: Size = .medium) {
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
            self.size = size
        }
    }

    public struct Subheader: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Subheader) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: SubheaderParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: SubheaderParameters = SubheaderParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack {
                Spacer()
                    .frame(width: Ocean.size.spacingStackXs)

                if let icon = parameters.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: Constants.iconSize, height: Constants.iconSize, alignment: .center)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))

                    Spacer()
                        .frame(width: Ocean.size.spacingStackXxs)
                }

                Typography.caption { label in
                    label.parameters.text = parameters.title
                }
                .fixedSize(horizontal: true, vertical: false)

                Spacer(minLength: Ocean.size.spacingStackXs)

                Typography.caption { label in
                    label.parameters.text = parameters.subtitle
                }
                .fixedSize(horizontal: true, vertical: false)

                Spacer()
                    .frame(width: Ocean.size.spacingStackXs)
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: parameters.size == .medium ? Constants.mediumHeight : Constants.smallHeight)
            .background(Color(Ocean.color.colorInterfaceLightUp))
        }
    }
}
