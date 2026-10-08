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
        @Published public var iconColor: TransactionListIconColor
        @Published public var contentList: ContentListParameters {
            didSet { observeNestedParameters() }
        }
        @Published public var amountDetails: AmountDetailsParameters {
            didSet { observeNestedParameters() }
        }
        @Published public var showDivider: Bool

        private var nestedObservation: AnyCancellable?

        public init(state: TransactionListState = .default,
                    icon: UIImage? = nil,
                    iconColor: TransactionListIconColor = .default,
                    contentList: ContentListParameters = ContentListParameters(),
                    amountDetails: AmountDetailsParameters = AmountDetailsParameters(),
                    showDivider: Bool = true) {
            self.state = state
            self.icon = icon
            self.iconColor = iconColor
            self.contentList = contentList
            self.amountDetails = amountDetails
            self.showDivider = showDivider
            observeNestedParameters()
        }

        var isEnabled: Bool { state == .default }

        /// Icon color as drawn: disabled forces `Interface/Light/Deep`.
        var resolvedIconColor: UIColor {
            state == .disabled ? Ocean.color.colorInterfaceLightDeep : iconColor.color
        }

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

/// Background of the interactive rows: `Interface/Light/Up` while pressed (Figma "Hover").
struct TransactionListPressableStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(configuration.isPressed
                              ? Ocean.color.colorInterfaceLightUp
                              : Ocean.color.colorInterfaceLightPure))
    }
}

/// Content List + Amount Details, or the skeleton while loading.
struct TransactionListContent: View {
    @ObservedObject var parameters: OceanSwiftUI.TransactionListParameters

    var body: some View {
        if parameters.state == .loading {
            TransactionListSkeleton()
        } else {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                OceanSwiftUI.ContentList(parameters: parameters.resolvedContentList())
                OceanSwiftUI.AmountDetails(parameters: parameters.resolvedAmountDetails())
            }
        }
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
            .padding(.vertical, Ocean.size.spacingStackXs)
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
                .padding(.vertical, Ocean.size.spacingStackXxsExtra)

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
