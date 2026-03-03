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
        @Published public var style: Style
        @Published public var textColor: UIColor?
        @Published public var tintColor: UIColor?
        @Published public var strikethrough: Bool
        @Published public var strikethroughColor: UIColor
        @Published public var font: UIFont?
        @Published public var lineLimit: Int?
        @Published public var lineSpacing: CGFloat?
        @Published public var kerning: CGFloat?
        @Published public var multilineTextAlignment: TextAlignment
        @Published public var skeletonSize: SkeletonSize
        @Published public var showSkeleton: Bool

        public enum Style {
            case heading1
            case heading2
            case heading3
            case heading4
            case heading5
            case heading1Inverse
            case heading2Inverse
            case heading3Inverse
            case heading4Inverse
            case heading5Inverse
            case subTitle1
            case subTitle2
            case subTitle1Inverse
            case subTitle2Inverse
            case paragraph
            case paragraphInverse
            case lead
            case leadInverse
            case description
            case descriptionInverse
            case caption
            case captionBold
            case captionInverse
            case eyebrow
            
            func getFont() -> UIFont? {
                switch self {
                case .heading1, .heading1Inverse:
                    return .highlightExtraBold(size: Ocean.font.fontSizeLg)
                case .heading2, .heading2Inverse:
                    return .highlightExtraBold(size: Ocean.font.fontSizeMd)
                case .heading3, .heading3Inverse:
                    return .highlightExtraBold(size: Ocean.font.fontSizeSm)
                case .heading4, .heading4Inverse:
                    return .highlightBold(size: Ocean.font.fontSizeXs)
                case .heading5, .heading5Inverse:
                    return .highlightBold(size: Ocean.font.fontSizeXxs)
                case .subTitle1, .subTitle1Inverse:
                    return .baseRegular(size: Ocean.font.fontSizeMd)
                case .subTitle2, .subTitle2Inverse:
                    return .baseRegular(size: Ocean.font.fontSizeSm)
                case .paragraph, .paragraphInverse:
                    return .baseRegular(size: Ocean.font.fontSizeXs)
                case .lead, .leadInverse:
                    return .baseBold(size: Ocean.font.fontSizeSm)
                case .description, .descriptionInverse:
                    return .baseRegular(size: Ocean.font.fontSizeXxs)
                case .caption:
                    return .baseRegular(size: Ocean.font.fontSizeXxxs)
                case .captionBold, .captionInverse:
                    return .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                case .eyebrow:
                    return .baseBold(size: Ocean.font.fontSizeXxxs)
                }
            }
            
            func getTextColor() -> UIColor {
                switch self {
                case .heading1, .heading2, .heading3, .heading4, .heading5, .lead:
                    return Ocean.color.colorInterfaceDarkDeep
                case .heading1Inverse, .heading2Inverse, .heading3Inverse, .heading4Inverse, .heading5Inverse:
                    return Ocean.color.colorInterfaceLightPure
                case .subTitle1, .subTitle2, .paragraph, .description, .caption, .captionBold, .eyebrow:
                    return Ocean.color.colorInterfaceDarkDown
                case .subTitle1Inverse, .subTitle2Inverse, .paragraphInverse, .leadInverse:
                    return Ocean.color.colorInterfaceLightDown
                case .descriptionInverse, .captionInverse:
                    return Ocean.color.colorBrandPrimaryUp
                }
            }
            
            func getLineSpacing() -> CGFloat {
                switch self {
                case .heading1, .heading1Inverse:
                    return Ocean.font.lineHeightMedium
                case .heading2, .heading2Inverse:
                    return Ocean.font.lineHeightMedium
                case .heading3, .heading3Inverse:
                    return Ocean.font.lineHeightMedium
                case .heading4, .heading4Inverse:
                    return Ocean.font.lineHeightLoose
                case .heading5, .heading5Inverse:
                    return Ocean.font.lineHeightLoose
                case .subTitle1, .subTitle1Inverse:
                    return Ocean.font.lineHeightLoose
                case .subTitle2, .subTitle2Inverse:
                    return Ocean.font.lineHeightLoose
                default:
                    return Ocean.font.lineHeightComfy
                }
            }
            
            func getKerning() -> CGFloat {
                switch self {
                case .eyebrow:
                    return 2.16
                default:
                    return 0
                }
            }
        }

        public enum SkeletonSize {
            case small
            case medium
            case large
            case large2x
            case large3x
        }

        public init(text: String = "",
                    style: Style = .description,
                    textColor: UIColor? = nil,
                    tintColor: UIColor? = nil,
                    strikethrough: Bool = false,
                    strikethroughColor: UIColor = Ocean.color.colorInterfaceDarkPure,
                    font: UIFont? = nil,
                    lineLimit: Int? = nil,
                    lineSpacing: CGFloat? = nil,
                    kerning: CGFloat? = nil,
                    multilineTextAlignment: TextAlignment = .leading,
                    skeletonSize: SkeletonSize = .large,
                    showSkeleton: Bool = false) {
            self.text = text
            self.style = style
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
            Text(parameters.showSkeleton ? skeletonPlaceholder : parameters.text.htmlToMarkdown())
                .strikethrough(parameters.strikethrough, color: Color(parameters.strikethroughColor))
                .font(Font(parameters.font ?? parameters.style.getFont() ?? .systemFont(ofSize: Ocean.font.fontSizeXs)))
                .foregroundColor(Color(parameters.textColor ?? parameters.style.getTextColor()))
                .lineLimit(parameters.lineLimit)
                .lineSpacing(parameters.lineSpacing ?? parameters.style.getLineSpacing())
                .multilineTextAlignment(parameters.multilineTextAlignment)
                .fixedSize(horizontal: false, vertical: true)
                .oceanSkeleton(isActive: parameters.showSkeleton, shape: .capsule)
        }

        public var body: some View {
            Group {
                if #available(iOS 16.0, *) {
                    text
                        .tint(Color(parameters.tintColor ?? parameters.textColor ?? parameters.style.getTextColor()))
                        .kerning(parameters.kerning ?? parameters.style.getKerning())
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
