//
//  OceanSwiftUI+TransactionList.swift
//  OceanComponents
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import Combine
import SwiftUI
import OceanTokens

// Shared pieces of the Transaction List family (Figma "Transaction List" — MR-615):
// Read Only, Action, Selectable, Expandable, Child Action and Child Read Only.
extension OceanSwiftUI {

    /// State of a Transaction List row. Hover/pressed is not a parameter: the interactive rows
    /// show it while they are being touched.
    public enum TransactionListState {
        case `default`
        /// Skeleton in place of the content and the amount.
        case loading
        /// Content and amount use their `inactive` types; the row does not react to touches.
        case disabled
    }

    /// Vertical rhythm of a row. Horizontal padding never changes.
    public enum TransactionListDensity {
        /// Each component's own vertical padding: `spacingStackXs` on top level rows,
        /// `spacingStackXxsExtra` around the content of child rows.
        case `default`
        /// `spacingStackXxs` on top and bottom for every row (the loading skeleton follows).
        case compact
    }

    /// Position of a child row in the timeline that links the children of an expandable row.
    public enum TransactionListChildPosition {
        /// Only child: no line.
        case standalone
        /// Line below the icon.
        case first
        /// Line above and below the icon.
        case middle
        /// Line above the icon.
        case last

        /// Position of the child at `index` in a list of `count` children.
        public static func position(at index: Int, count: Int) -> TransactionListChildPosition {
            if count <= 1 { return .standalone }
            if index <= 0 { return .first }
            return index >= count - 1 ? .last : .middle
        }

        var hasLineAbove: Bool { self == .middle || self == .last }
        var hasLineBelow: Bool { self == .first || self == .middle }
    }

    /// Color of the row icon (leading icon of the top level rows, timeline icon of the children).
    /// A disabled row always draws the icon in `Interface/Light/Deep`, whatever the choice.
    public enum TransactionListIconColor {
        /// `Interface/Dark/Up` — rows on a white background.
        case `default`
        /// `Interface/Dark/Down` — rows on colored backgrounds (e.g. `Status/Warning/Up`, `Status/Negative/Up` heroes).
        case onColor
        /// `Brand/Primary/Down` — more emphasis.
        case highlight

        public var color: UIColor {
            switch self {
            case .default:
                return Ocean.color.colorInterfaceDarkUp
            case .onColor:
                return Ocean.color.colorInterfaceDarkDown
            case .highlight:
                return Ocean.color.colorBrandPrimaryDown
            }
        }
    }

    /// Parameters shared by every row of the family. Content and amount sizes are independent
    /// (`contentList.size` and `amountDetails.size`).
    public class TransactionListParameters: ObservableObject {
        @Published public var state: TransactionListState
        @Published public var icon: UIImage?
        /// `nil` = the row's own default: `.default` (`Interface/Dark/Up`) for top level rows and
        /// `Interface/Light/Down` for child rows (timeline icon).
        @Published public var iconColor: TransactionListIconColor?
        @Published public var contentList: ContentListParameters {
            didSet { observeNestedParameters() }
        }
        @Published public var amountDetails: AmountDetailsParameters {
            didSet { observeNestedParameters() }
        }
        @Published public var showDivider: Bool
        @Published public var density: TransactionListDensity

        private var nestedObservation: AnyCancellable?

        public init(state: TransactionListState = .default,
                    icon: UIImage? = nil,
                    iconColor: TransactionListIconColor? = .default,
                    contentList: ContentListParameters = ContentListParameters(),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(),
                    showDivider: Bool = true,
                    density: TransactionListDensity = .default) {
            self.state = state
            self.icon = icon
            self.iconColor = iconColor
            self.contentList = contentList
            self.amountDetails = amountDetails
            self.showDivider = showDivider
            self.density = density
            observeNestedParameters()
        }

        var isEnabled: Bool { state == .default }

        /// Top and bottom padding of a top level row.
        var rowVerticalPadding: CGFloat {
            density == .compact ? Ocean.size.spacingStackXxs : Ocean.size.spacingStackXs
        }

        /// Top and bottom padding around the content of a child row.
        var childVerticalPadding: CGFloat {
            density == .compact ? Ocean.size.spacingStackXxs : Ocean.size.spacingStackXxsExtra
        }

        /// Icon color as drawn: disabled forces `Interface/Light/Deep`.
        var resolvedIconColor: UIColor {
            if state == .disabled { return Ocean.color.colorInterfaceLightDeep }
            return iconColor?.color ?? defaultIconColor
        }

        /// Color used when `iconColor` is `nil`; child rows use `Interface/Light/Down`.
        var defaultIconColor: UIColor { TransactionListIconColor.default.color }

        /// Content block as drawn by the row: Figma metrics, no own padding/skeleton, `inactive` when disabled.
        func resolvedContentList() -> ContentListParameters {
            contentList.resolved(type: state == .disabled ? .inactive : nil,
                                 showSkeleton: false,
                                 padding: .all(0),
                                 usesFamilyMetrics: true)
        }

        /// Amount block as drawn by the row: `inactive` (Neutral tag) when disabled.
        func resolvedAmountDetails() -> AmountDetailsParameters {
            amountDetails.resolved(type: state == .disabled ? .inactive : nil)
        }

        /// Changes made through `contentList` and `amountDetails` re-render the row.
        private func observeNestedParameters() {
            nestedObservation = Publishers.Merge(contentList.objectWillChange, amountDetails.objectWillChange)
                .sink { [weak self] _ in self?.objectWillChange.send() }
        }
    }
}

// MARK: - Internal building blocks

/// Texts of the Content List and the amount additional data wrap up to two lines, then truncate
/// with a tail ellipsis (same rule as ocean-web). The amount value and the tag stay on one line.
let transactionListTextLineLimit = 2

/// Extra space that brings a text to the Figma line height (1.5 × font size); UIKit fonts report
/// a shorter natural line height for Nunito Sans.
func figmaLineSpacing(_ font: UIFont?) -> CGFloat {
    guard let font = font else { return 0 }
    return max(0, font.pointSize * 1.5 - font.lineHeight)
}

extension View {
    /// Gives a text at least the Figma line height (1.5 × font size), centered; extra lines of a
    /// wrapped text get the same rhythm through `lineSpacing = figmaLineSpacing(font)`.
    func figmaLineHeight(_ font: UIFont?) -> some View {
        frame(minHeight: (font?.pointSize ?? 0) * 1.5)
    }
}

/// Background of the interactive rows: `Interface/Light/Up` while pressed (Figma "Hover"), otherwise
/// transparent, so the row sits on the screen's background (white lists or colored heroes with `.onColor`).
struct TransactionListPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(Ocean.color.colorInterfaceLightUp) : Color.clear)
    }
}

/// Content List + Amount Details, or the skeleton while loading.
struct TransactionListContent: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters

    var body: some View {
        if parameters.state == .loading {
            TransactionListSkeleton()
        } else {
            let content = OceanSwiftUI.ContentList(parameters: parameters.resolvedContentList())
                .layoutPriority(1)
            let amount = OceanSwiftUI.AmountDetails(parameters: parameters.resolvedAmountDetails())

            if #available(iOS 16.0, *) {
                TransactionListContentLayout(spacing: Ocean.size.spacingStackXxs) {
                    content
                    amount
                }
            } else {
                // iOS 15 has no `Layout`: the content keeps priority, the amount gets what is left.
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    content
                    amount
                }
            }
        }
    }
}

/// Content List (first subview) and Amount Details (second), vertically centered. The amount takes
/// its natural width up to half of the row, never less than its value; the content gets the rest,
/// so a long tag or additional data never squeezes the content to nothing.
@available(iOS 16.0, *)
struct TransactionListContentLayout: Layout {
    /// Share of the row the amount block may take (same rule as ocean-web).
    static let maxAmountShare: CGFloat = 0.5

    let spacing: CGFloat

    /// Width given to the amount block for a row `width` wide.
    static func amountWidth(rowWidth width: CGFloat, ideal: CGFloat, minimum: CGFloat) -> CGFloat {
        min(ideal, max(width * maxAmountShare, minimum))
    }

    private func widths(for width: CGFloat, subviews: Subviews) -> (content: CGFloat, amount: CGFloat) {
        guard subviews.count == 2 else { return (width, 0) }

        let amount = subviews[1]
        let amountWidth = Self.amountWidth(rowWidth: width,
                                           ideal: amount.sizeThatFits(.unspecified).width,
                                           minimum: amount.sizeThatFits(ProposedViewSize(width: 0, height: nil)).width)
        return (max(0, width - spacing - amountWidth), amountWidth)
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard let width = proposal.width, width.isFinite else {
            let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
            return CGSize(width: sizes.reduce(spacing) { $0 + $1.width },
                          height: sizes.map(\.height).max() ?? 0)
        }

        let columns = widths(for: width, subviews: subviews)
        let contentHeight = subviews[0].sizeThatFits(ProposedViewSize(width: columns.content, height: nil)).height
        let amountHeight = subviews[1].sizeThatFits(ProposedViewSize(width: columns.amount, height: nil)).height
        return CGSize(width: width, height: max(contentHeight, amountHeight))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard subviews.count == 2 else { return }

        let columns = widths(for: bounds.width, subviews: subviews)
        subviews[0].place(at: CGPoint(x: bounds.minX, y: bounds.midY),
                          anchor: .leading,
                          proposal: ProposedViewSize(width: columns.content, height: nil))
        subviews[1].place(at: CGPoint(x: bounds.maxX, y: bounds.midY),
                          anchor: .trailing,
                          proposal: ProposedViewSize(width: columns.amount, height: nil))
    }
}

/// Two lines on the left and two 86pt lines on the right (Figma `Skeleton / Two-line List`).
struct TransactionListSkeleton: View {
    var body: some View {
        HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                HStack(spacing: 0) {
                    TransactionListSkeletonBar()
                    Color.clear.frame(height: TransactionListSkeletonBar.height)
                    Color.clear.frame(height: TransactionListSkeletonBar.height)
                }
                TransactionListSkeletonBar()
            }

            VStack(alignment: .trailing, spacing: Ocean.size.spacingStackXxs) {
                TransactionListSkeletonBar()
                TransactionListSkeletonBar()
            }
            .frame(width: 86)
        }
    }
}

/// 16pt high bar that fills the width, or a square (icon placeholder) when `squareSide` is set.
struct TransactionListSkeletonBar: View {
    static let height: CGFloat = 16
    var squareSide: CGFloat?

    var body: some View {
        Color.clear
            .frame(width: squareSide, height: squareSide ?? Self.height)
            .frame(maxWidth: squareSide == nil ? .infinity : nil)
            .oceanSkeleton(isActive: true, shape: .rounded(.radius(Ocean.size.borderRadiusTiny)))
    }
}

/// 24pt leading icon of the top level rows (skeleton while loading).
struct TransactionListLeadingIcon: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters

    var body: some View {
        if parameters.state == .loading {
            TransactionListSkeletonBar(squareSide: 24)
        } else if let icon = parameters.icon {
            Image(uiImage: icon)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(parameters.resolvedIconColor))
                .frame(width: 24, height: 24)
        }
    }
}

/// 20pt trailing action icon (chevron). Disabled forces `Interface/Light/Deep` — the only forced color.
struct TransactionListActionIcon: View {
    let image: UIImage?
    let isDisabled: Bool

    var body: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color(isDisabled ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceDarkUp))
            .frame(width: 20, height: 20)
    }
}

/// Menu action: 20pt `dotsVerticalSolid` in a 32pt round touch area (Figma `_Contextual Menu`);
/// active = `Interface/Light/Up` circle with the icon in `Brand/Primary/Pure`.
struct TransactionListMenuIcon: View {
    let isActive: Bool
    let isDisabled: Bool

    var iconColor: UIColor {
        if isDisabled { return Ocean.color.colorInterfaceLightDeep }
        return isActive ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkUp
    }

    var body: some View {
        Image(uiImage: Ocean.icon.dotsVerticalSolid ?? UIImage())
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color(iconColor))
            .frame(width: 20, height: 20)
            .frame(width: 32, height: 32)
            .background(Circle().fill(Color(isActive ? Ocean.color.colorInterfaceLightUp : .clear)))
    }
}

/// Horizontal divider inset by `spacingStackXs` on both sides.
struct TransactionListDivider: View {
    var body: some View {
        OceanSwiftUI.Divider()
            .padding(.horizontal, Ocean.size.spacingStackXs)
    }
}

/// Top level row: `spacingStackXs` padding, leading, content, trailing and the divider below.
struct TransactionListRow<Leading: View, Trailing: View>: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters
    var spacing: CGFloat = Ocean.size.spacingStackXxsExtra
    /// Overrides `parameters.showDivider` (the expandable row draws its own divider).
    var showsDivider: Bool?
    /// The menu action sits in a 32pt touch area, so the row keeps `spacingStackXxs` on the right.
    var trailingPadding: CGFloat = Ocean.size.spacingStackXs
    @ViewBuilder var leading: () -> Leading
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: spacing) {
                leading()
                TransactionListContent(parameters: parameters)
                trailing()
            }
            .padding(.vertical, parameters.rowVerticalPadding)
            .padding(.leading, Ocean.size.spacingStackXs)
            .padding(.trailing, trailingPadding)

            if showsDivider ?? parameters.showDivider {
                TransactionListDivider()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

/// Child row: timeline column on the left, content with `spacingStackXxsExtra` of vertical padding.
struct TransactionListChildRow<Trailing: View>: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters
    let position: OceanSwiftUI.TransactionListChildPosition
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(alignment: .center, spacing: Ocean.size.spacingStackXxsExtra) {
            TransactionListTimeline(parameters: parameters, position: position)

            TransactionListContent(parameters: parameters)
                .padding(.vertical, parameters.childVerticalPadding)

            trailing()
        }
        .padding(.horizontal, Ocean.size.spacingStackXs)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
    }
}

/// 24pt wide column: line above, 16pt icon (4pt inset), line below — lines in `Interface/Light/Down`.
struct TransactionListTimeline: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters
    let position: OceanSwiftUI.TransactionListChildPosition

    var body: some View {
        VStack(spacing: 0) {
            line(isVisible: position.hasLineAbove)

            Group {
                if parameters.state == .loading {
                    TransactionListSkeletonBar(squareSide: 16)
                } else if let icon = parameters.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(parameters.resolvedIconColor))
                        .frame(width: 16, height: 16)
                } else {
                    Color.clear.frame(width: 16, height: 16)
                }
            }
            .padding(.all, Ocean.size.spacingStackXxxs)

            line(isVisible: position.hasLineBelow)
        }
        .frame(width: 24)
        .frame(maxHeight: .infinity)
    }

    private func line(isVisible: Bool) -> some View {
        Rectangle()
            .fill(Color(isVisible ? Ocean.color.colorInterfaceLightDown : .clear))
            .frame(width: 1)
            .frame(maxHeight: .infinity)
    }
}

/// 20pt checkbox or radio drawn from the Ocean `Checkbox Element` / `Radio` tokens, with the
/// indeterminate state the Selectable needs.
struct TransactionListSelectionControl: View {
    let controlType: OceanSwiftUI.TransactionListSelectableParameters.ControlType
    let isSelected: Bool
    let isIndeterminate: Bool
    let hasError: Bool
    let isEnabled: Bool

    private let size: CGFloat = 20

    var body: some View {
        switch controlType {
        case .checkbox:
            checkbox
        case .radio:
            radio
        }
    }

    var isFilled: Bool { isSelected || isIndeterminate }

    var strokeColor: UIColor {
        if !isEnabled { return isFilled ? Ocean.color.colorInterfaceLightDeep : Ocean.color.colorInterfaceLightDown }
        if hasError { return Ocean.color.colorStatusNegativePure }
        return isFilled ? Ocean.color.colorComplementaryPure : Ocean.color.colorInterfaceDarkUp
    }

    var checkboxFillColor: UIColor {
        guard isFilled && !hasError else { return Ocean.color.colorInterfaceLightPure }
        return isEnabled ? Ocean.color.colorComplementaryPure : Ocean.color.colorInterfaceLightDeep
    }

    private var checkbox: some View {
        RoundedRectangle(cornerRadius: Ocean.size.borderRadiusTiny)
            .fill(Color(checkboxFillColor))
            .overlay(RoundedRectangle(cornerRadius: Ocean.size.borderRadiusTiny)
                .stroke(Color(strokeColor), lineWidth: 1))
            .overlay(checkboxMark)
            .frame(width: size, height: size)
    }

    @ViewBuilder
    private var checkboxMark: some View {
        if isFilled && !hasError {
            Image(uiImage: (isIndeterminate ? Ocean.icon.minusSolid : Ocean.icon.checkSolid) ?? UIImage())
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                .frame(width: 16, height: 16)
        }
    }

    private var radio: some View {
        let isChecked = isSelected && !hasError
        let ringSize: CGFloat = isChecked ? 14 : size

        return Circle()
            .fill(Color(Ocean.color.colorInterfaceLightPure))
            .frame(width: size, height: size)
            .overlay(Circle()
                .stroke(Color(strokeColor), lineWidth: isChecked ? 6 : 1)
                .frame(width: ringSize, height: ringSize))
    }
}
