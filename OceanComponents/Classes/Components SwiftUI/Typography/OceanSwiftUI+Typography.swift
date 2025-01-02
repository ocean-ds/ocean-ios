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
        @Published public var strikethroughColor: UIColor
        @Published public var font: UIFont?
        @Published public var lineLimit: Int?
        @Published public var lineSpacing: CGFloat
        @Published public var kerning: CGFloat
        @Published public var multilineTextAlignment: TextAlignment
        @Published public var skeletonSize: SkeletonSize
        @Published public var showSkeleton: Bool

        public enum Style {
            case normal
            case primary
        }

        public enum SkeletonSize {
            case small
            case medium
            case large
            case large2x
            case large3x
        }

        public init(text: String = "",
                    textColor: UIColor = Ocean.color.colorInterfaceDarkDown,
                    tintColor: UIColor? = nil,
                    strikethrough: Bool = false,
                    strikethroughColor: UIColor = Ocean.color.colorInterfaceDarkPure,
                    font: UIFont? = .baseRegular(size: Ocean.font.fontSizeXs),
                    lineLimit: Int? = nil,
                    lineSpacing: CGFloat = Ocean.font.lineHeightComfy,
                    kerning: CGFloat = 0,
                    multilineTextAlignment: TextAlignment = .leading,
                    skeletonSize: SkeletonSize = .large,
                    showSkeleton: Bool = false) {
            self.text = text
            self.textColor = textColor
            self.tintColor = tintColor
            self.strikethrough = strikethrough
            self.strikethroughColor = strikethroughColor
            self.font = font
            self.lineLimit = lineLimit
            self.lineSpacing = lineSpacing
            self.kerning = kerning
            self.multilineTextAlignment = multilineTextAlignment
            self.skeletonSize = skeletonSize
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

        private var skeletonPlaceholder: LocalizedStringKey {
            var blank = "            "

            switch parameters.skeletonSize {
            case .small:
                blank = String(repeating: blank, count: 1)
            case .medium:
                blank = String(repeating: blank, count: 2)
            case .large:
                blank = String(repeating: blank, count: 3)
            case .large2x:
                blank = String(repeating: blank, count: 6)
            case .large3x:
                blank = String(repeating: blank, count: 9)
            }
            
            return blank.htmlToMarkdown()
        }

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
            Text(self.parameters.showSkeleton ? self.skeletonPlaceholder : self.parameters.text.htmlToMarkdown())
                .strikethrough(self.parameters.strikethrough, color: Color(self.parameters.strikethroughColor))
                .font(Font(self.parameters.font ?? .systemFont(ofSize: Ocean.font.fontSizeXs)))
                .foregroundColor(Color(self.parameters.textColor))
                .lineLimit(self.parameters.lineLimit)
                .lineSpacing(self.parameters.lineSpacing)
                .multilineTextAlignment(self.parameters.multilineTextAlignment)
                .fixedSize(horizontal: false, vertical: true)
                .oceanSkeleton(isActive: self.parameters.showSkeleton, shape: .capsule)
        }

        public var body: some View {
            Group {
                if #available(iOS 16.0, *) {
                    text
                        .tint(Color(self.parameters.tintColor ?? self.parameters.textColor))
                        .kerning(self.parameters.kerning)
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
