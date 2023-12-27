//
//  OceanSwiftUI+Typography.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 23/08/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class TypographyParameters: ObservableObject {
        @Published public var text: String
        @Published public var textColor: UIColor
        @Published public var font: UIFont?
        @Published public var lineLimit: Int?
        @Published public var lineSpacing: CGFloat
        @Published public var multilineTextAlignment: TextAlignment
        @Published public var showSkeleton: Bool

        public enum Style {
            case normal
            case primary
        }

        public init(text: String = "",
                    textColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    font: UIFont? = .baseRegular(size: Ocean.font.fontSizeXs),
                    lineLimit: Int? = nil,
                    lineSpacing: CGFloat = Ocean.font.lineHeightComfy,
                    multilineTextAlignment: TextAlignment = .leading,
                    showSkeleton: Bool = false) {
            self.text = text
            self.textColor = textColor
            self.font = font
            self.lineLimit = lineLimit
            self.lineSpacing = lineSpacing
            self.multilineTextAlignment = multilineTextAlignment
            self.showSkeleton = showSkeleton
        }
    }

    public struct Typography: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Typography) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TypographyParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TypographyParameters = TypographyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            Text(self.parameters.text.htmlToMarkdown())
                .font(Font(self.parameters.font ?? .systemFont(ofSize: Ocean.font.fontSizeXs)))
                .foregroundColor(Color(self.parameters.textColor))
                .lineLimit(self.parameters.lineLimit)
                .lineSpacing(self.parameters.lineSpacing)
                .multilineTextAlignment(self.parameters.multilineTextAlignment)
                .fixedSize(horizontal: false, vertical: true)
                .skeleton(with: self.parameters.showSkeleton)
        }
    }
}

struct Ocean_Typography_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.Typography()
    }
}
