//
//  OceanSwiftUI+RoundedIcon.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 19/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class RoundedIconParameters: ObservableObject {
        @Published public var icon: UIImage
        @Published public var color: UIColor
        @Published public var backgroundColor: UIColor

        public init(icon: UIImage = Ocean.icon.placeholderOutline!,
                    color: UIColor = Ocean.color.colorBrandPrimaryDown,
                    backgroundColor: UIColor = Ocean.color.colorInterfaceLightUp) {
            self.icon = icon
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }

    public struct RoundedIcon: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (RoundedIcon) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: RoundedIconParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: RoundedIconParameters = RoundedIconParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(alignment: .center, spacing: 0) {
                Image(uiImage: self.parameters.icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(Color(self.parameters.color))
            }
            .padding(Ocean.size.spacingStackXxs)
            .frame(width: 40, height: 40, alignment: .center)
            .background(Color(self.parameters.backgroundColor))
            .cornerRadius(40 * Ocean.size.borderRadiusCircular)
        }

        // MARK: Methods private
    }
}
