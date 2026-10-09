//
//  OceanSwiftUI+AmountDetails.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import Combine
import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    /// Amount block shared by the Transaction List family (Figma `_Content List / Amount`):
    /// the value, an optional tag below it and an optional additional data line.
    public class AmountDetailsParameters: ObservableObject {
        @Published public var amount: String
        /// Original value shown struck through before `amount` when `type` is
        /// `.strikethrough` or `.strikethroughNeutral`.
        @Published public var strikethroughAmount: String
        @Published public var type: AmountType
        @Published public var size: Size
        /// Optional tag below the value. Its size follows `size` (Medium in `.md`, Small in `.sm`)
        /// and it turns Neutral when `type == .inactive`.
        @Published public var tag: TagParameters? {
            didSet { observeTag() }
        }
        @Published public var additionalData: String

        private var tagObservation: AnyCancellable?

        public init(amount: String = "",
                    strikethroughAmount: String = "",
                    type: AmountType = .default,
                    size: Size = .md,
                    tag: TagParameters? = nil,
                    additionalData: String = "") {
            self.amount = amount
            self.strikethroughAmount = strikethroughAmount
            self.type = type
            self.size = size
            self.tag = tag
            self.additionalData = additionalData
            observeTag()
        }

        /// Edits made through `tag` (label, status, icon) re-render the block.
        private func observeTag() {
            tagObservation = tag?.objectWillChange.sink { [weak self] _ in self?.objectWillChange.send() }
        }

        public enum AmountType {
            case `default`
            case positive
            /// Prefixes the value with "- ".
            case negative
            case inactive
            /// Original struck in `Interface/Dark/Up` + current value in `Status/Positive/Deep`.
            case strikethrough
            /// Original struck in `Interface/Dark/Up` + current value in `Interface/Dark/Deep`.
            case strikethroughNeutral
        }

        public enum Size {
            /// Value 16 semibold, tag Medium.
            case md
            /// Value 14 semibold, tag Small.
            case sm
        }

        /// Copy used by composed components: same content, with the type they control replaced.
        func resolved(type: AmountType? = nil) -> AmountDetailsParameters {
            AmountDetailsParameters(amount: amount,
                                    strikethroughAmount: strikethroughAmount,
                                    type: type ?? self.type,
                                    size: size,
                                    tag: tag,
                                    additionalData: additionalData)
        }

        var displayAmount: String {
            type == .negative ? "- \(amount)" : amount
        }

        var showsStrikethrough: Bool {
            (type == .strikethrough || type == .strikethroughNeutral) && !strikethroughAmount.isEmpty
        }

        var fontSize: CGFloat {
            size == .md ? Ocean.font.fontSizeXs : Ocean.font.fontSizeXxs
        }

        var amountFont: UIFont? { .baseSemiBold(size: fontSize) }

        var strikethroughFont: UIFont? { .baseRegular(size: fontSize) }

        var amountColor: UIColor {
            switch type {
            case .default, .negative, .strikethroughNeutral:
                return Ocean.color.colorInterfaceDarkDeep
            case .positive, .strikethrough:
                return Ocean.color.colorStatusPositiveDeep
            case .inactive:
                return Ocean.color.colorInterfaceDarkUp
            }
        }

        var additionalDataColor: UIColor {
            type == .inactive ? Ocean.color.colorInterfaceDarkUp : Ocean.color.colorInterfaceDarkDown
        }

        var resolvedTag: TagParameters? {
            guard let tag = tag, !tag.label.isEmpty else { return nil }

            let resolved = TagParameters(label: tag.label,
                                         hasLabelBold: tag.hasLabelBold,
                                         icon: tag.icon,
                                         status: type == .inactive ? .neutralInterface : tag.status,
                                         size: size == .md ? .medium : .small,
                                         showSkeleton: tag.showSkeleton,
                                         font: tag.font)
            resolved.truncatesLabel = true
            return resolved
        }
    }

    public struct AmountDetails: View {

        static let additionalDataFont = UIFont.baseSemiBold(size: Ocean.font.fontSizeXxxs)

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (AmountDetails) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: AmountDetailsParameters

        // MARK: Constructors

        public init(parameters: AmountDetailsParameters = AmountDetailsParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(alignment: .trailing, spacing: Ocean.size.spacingStackXxxs) {
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(alignment: .firstTextBaseline, spacing: Ocean.size.spacingStackXxxs) {
                        if parameters.showsStrikethrough {
                            Typography { label in
                                label.parameters.text = parameters.strikethroughAmount
                                label.parameters.font = parameters.strikethroughFont
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.strikethrough = true
                                label.parameters.strikethroughColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.lineLimit = 1
                            }
                            .figmaLineHeight(parameters.strikethroughFont)
                        }

                        Typography { label in
                            label.parameters.text = parameters.displayAmount
                            label.parameters.font = parameters.amountFont
                            label.parameters.textColor = parameters.amountColor
                            label.parameters.lineLimit = 1
                            label.parameters.multilineTextAlignment = .trailing
                        }
                        .figmaLineHeight(parameters.amountFont)
                    }
                    // The value never wraps nor truncates; the tag and the additional data adapt instead.
                    .fixedSize(horizontal: true, vertical: false)

                    if let tag = parameters.resolvedTag {
                        Tag(parameters: tag)
                    }
                }

                if !parameters.additionalData.isEmpty {
                    Typography.captionBold { label in
                        label.parameters.text = parameters.additionalData
                        label.parameters.textColor = parameters.additionalDataColor
                        label.parameters.lineLimit = transactionListTextLineLimit
                        label.parameters.lineSpacing = figmaLineSpacing(Self.additionalDataFont)
                        label.parameters.multilineTextAlignment = .trailing
                    }
                    .figmaLineHeight(Self.additionalDataFont)
                }
            }
        }
    }
}
