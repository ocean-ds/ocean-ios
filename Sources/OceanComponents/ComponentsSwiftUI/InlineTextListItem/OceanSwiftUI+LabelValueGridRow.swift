//
//  OceanSwiftUI+LabelValueGridRow.swift
//  OceanComponents
//
//  Created by Igor Monteiro on 03/09/2026.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    /// Two-column label/value row shared by `InlineTextListItem` and `TransactionFooter`.
    ///
    /// Both texts are flexible columns sharing the available width equally, separated by a
    /// gap, so each side wraps inside its own column and neither grows into the other. The
    /// label is leading-aligned, the value side trailing-aligned, and the column that does
    /// not wrap stays vertically centered against the one that does. A small leading image
    /// (20pt) fits the value column and keeps its intrinsic size.
    struct LabelValueGridRow: View {
        let text: String
        let value: String
        let valueColor: UIColor
        let isBoldValue: Bool
        let newValue: String
        let newValueColor: UIColor
        let imageIcon: UIImage?
        let imageColor: UIColor

        var body: some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                Typography.paragraph { label in
                    label.parameters.text = text
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: Ocean.size.spacingStackXxs) {
                    if let icon = imageIcon {
                        LabelValueImageIcon(icon: icon, color: imageColor)
                    }

                    LabelValueTexts(value: value,
                                    valueColor: valueColor,
                                    isBoldValue: isBoldValue,
                                    newValue: newValue,
                                    newValueColor: newValueColor,
                                    alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    /// The 20pt template image that may precede a value.
    struct LabelValueImageIcon: View {
        let icon: UIImage
        let color: UIColor

        var body: some View {
            Image(uiImage: icon.withRenderingMode(.alwaysTemplate))
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundColor(Color(color))
                .fixedSize()
        }
    }

    /// The value block: either a struck-through old value followed by the new one, or a
    /// single value that may be bold.
    struct LabelValueTexts: View {
        let value: String
        let valueColor: UIColor
        let isBoldValue: Bool
        let newValue: String
        let newValueColor: UIColor
        let alignment: TextAlignment

        var body: some View {
            if !newValue.isEmpty, !value.isEmpty {
                Typography.paragraph { label in
                    label.parameters.text = value
                    label.parameters.textColor = valueColor
                    label.parameters.strikethrough = true
                    label.parameters.multilineTextAlignment = alignment
                }
                Typography.paragraph { label in
                    label.parameters.text = newValue
                    label.parameters.textColor = newValueColor
                    label.parameters.multilineTextAlignment = alignment
                }
            } else {
                Typography.paragraph { label in
                    label.parameters.text = value
                    label.parameters.textColor = valueColor
                    label.parameters.font = isBoldValue
                    ? .baseBold(size: Ocean.font.fontSizeXs)
                    : .baseRegular(size: Ocean.font.fontSizeXs)
                    label.parameters.multilineTextAlignment = alignment
                }
            }
        }
    }
}
