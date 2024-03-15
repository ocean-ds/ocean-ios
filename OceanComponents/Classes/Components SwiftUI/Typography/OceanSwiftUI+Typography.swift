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
        @Published public var tintColor: UIColor?
        @Published public var strikethrough: Bool
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
                    tintColor: UIColor? = nil,
                    strikethrough: Bool = false,
                    font: UIFont? = .baseRegular(size: Ocean.font.fontSizeXs),
                    lineLimit: Int? = nil,
                    lineSpacing: CGFloat = Ocean.font.lineHeightComfy,
                    multilineTextAlignment: TextAlignment = .leading,
                    showSkeleton: Bool = false) {
            self.text = text
            self.textColor = textColor
            self.tintColor = tintColor
            self.strikethrough = strikethrough
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

        @State private var labelWidth: CGSize = .zero

        // MARK: Constructors

        public init(parameters: TypographyParameters = TypographyParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        private var text: some View {
            Text(self.parameters.text.htmlToMarkdown())
                .strikethrough(self.parameters.strikethrough, color: Color(Ocean.color.colorInterfaceDarkPure))
                .font(Font(self.parameters.font ?? .systemFont(ofSize: Ocean.font.fontSizeXs)))
                .foregroundColor(Color(self.parameters.textColor))
                .lineLimit(self.parameters.lineLimit)
                .lineSpacing(self.parameters.lineSpacing)
                .multilineTextAlignment(self.parameters.multilineTextAlignment)
                .fixedSize(horizontal: false, vertical: true)
                .overlay(
                    Path()
                        .background(Color.clear)
                        .skeleton(with: self.parameters.showSkeleton, 
                                  shape: .rounded(.radius(Ocean.size.borderRadiusSm)))
                )
        }

        public var body: some View {
            Group {
                if #available(iOS 16.0, *) {
                    text
                        .tint(Color(self.parameters.tintColor ?? self.parameters.textColor))
                } else {
                    text
                }
            }
        }
    }
}

struct Ocean_Typography_Previews: PreviewProvider {
    static var previews: some View {
        OceanSwiftUI.Typography()
    }
}
