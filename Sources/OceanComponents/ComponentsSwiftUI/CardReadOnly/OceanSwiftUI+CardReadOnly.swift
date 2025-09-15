//
//  OceanSwiftUI+CardReadOnly.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 15/09/25.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class CardReadOnlyParameters: ObservableObject {
        @Published public var contentList: OceanSwiftUI.ContentListParameters
        @Published public var backgroundColor: UIColor
        @Published public var cornerRadius: CGFloat
        @Published public var borderColor: UIColor?
        @Published public var borderWidth: CGFloat
        @Published public var cardPadding: EdgeInsets

        public init(contentList: OceanSwiftUI.ContentListParameters = OceanSwiftUI.ContentListParameters(),
                    backgroundColor: UIColor = Ocean.color.colorInterfaceLightPure,
                    cornerRadius: CGFloat = Ocean.size.borderRadiusMd,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = Ocean.size.borderWidthHairline,
                    cardPadding: EdgeInsets = .all(0)) {
            self.contentList = contentList
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cardPadding = cardPadding
        }
    }

    public struct CardReadOnly: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardReadOnly) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardReadOnlyParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: CardReadOnlyParameters = CardReadOnlyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                ContentList(parameters: parameters.contentList)
            }
            .background(Color(parameters.backgroundColor))
            .border(cornerRadius: parameters.cornerRadius,
                    width: parameters.borderWidth,
                    color: parameters.borderColor ?? Ocean.color.colorInterfaceLightDown)
            .padding(parameters.cardPadding)
        }
    }
}
