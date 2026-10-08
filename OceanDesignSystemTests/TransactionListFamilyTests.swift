//
//  TransactionListFamilyTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import Combine
import OceanTokens
@testable import OceanComponents

/// Transaction List family (MR-615): shared Content List / Amount Details blocks, the rows and the
/// expandable with the Figma structure. Layout assertions measure the rendered height, the same way
/// `TransactionFooterSpacingTests` does.
final class TransactionListFamilyTests: XCTestCase {

    private typealias ContentType = OceanSwiftUI.ContentListParameters.ContentListItemType

    private let width: CGFloat = 360

    override func setUp() {
        super.setUp()
        Ocean.installFonts()
    }

    // MARK: - Helpers

    private func measuredHeight<V: View>(_ view: V) -> CGFloat {
        let controller = UIHostingController(rootView: view.frame(width: width))
        controller.view.frame = CGRect(x: 0, y: 0, width: width, height: 2000)
        controller.view.layoutIfNeeded()
        return controller.sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude)).height
    }

    private func content(_ size: OceanSwiftUI.ContentListParameters.Size = .md,
                         type: ContentType = .default) -> OceanSwiftUI.ContentListParameters {
        .init(title: "Title", description: "Description", caption: "Caption", type: type, size: size)
    }

    private func amount(_ size: OceanSwiftUI.AmountDetailsParameters.Size = .md,
                        type: OceanSwiftUI.AmountDetailsParameters.AmountType = .default) -> OceanSwiftUI.AmountDetailsParameters {
        .init(amount: "R$ 10,00",
              strikethroughAmount: "R$ 12,00",
              type: type,
              size: size,
              tag: .init(label: "Label", status: .positive),
              additionalData: "Additional data")
    }

    private func contentList(_ parameters: OceanSwiftUI.ContentListParameters) -> OceanSwiftUI.ContentList {
        OceanSwiftUI.ContentList(parameters: parameters)
    }

    // MARK: - Content List (shared block)

    func testContentListDefaultsKeepTheCurrentRendering() {
        let parameters = OceanSwiftUI.ContentListParameters(title: "Title", description: "Description")

        XCTAssertEqual(parameters.size, .md)
        XCTAssertEqual(parameters.strikethroughText, "")
        for type in [ContentType.default, .inactive, .highlight, .highlightLead] {
            parameters.type = type
            XCTAssertFalse(parameters.appliesFigmaMetrics, "existing type \(type) must keep the legacy rendering in md")
        }
    }

    func testNewTypesSmallSizeAndTheFamilyUseTheFigmaMetrics() {
        for type in [ContentType.positive, .warning, .strikethrough] {
            XCTAssertTrue(content(type: type).appliesFigmaMetrics)
        }
        XCTAssertTrue(content(.sm).appliesFigmaMetrics)
        XCTAssertTrue(content().resolved(usesFamilyMetrics: true).appliesFigmaMetrics)
    }

    func testSmallSizeUsesTheChildTypography() {
        let small = contentList(content(.sm))
        let medium = contentList(content().resolved(usesFamilyMetrics: true))

        XCTAssertEqual(small.figmaTitleFont?.pointSize, Ocean.font.fontSizeXxxs)
        XCTAssertEqual(small.figmaTitleFont?.fontName, UIFont.baseSemiBold(size: 12)?.fontName)
        XCTAssertEqual(small.figmaDescriptionFont?.pointSize, Ocean.font.fontSizeXxs)
        XCTAssertEqual(medium.figmaTitleFont?.pointSize, Ocean.font.fontSizeXxs)
        XCTAssertEqual(medium.figmaDescriptionFont?.pointSize, Ocean.font.fontSizeXs)
    }

    func testContentTypesUseTheFigmaColors() {
        XCTAssertEqual(contentList(content(type: .positive)).figmaDescriptionColor, Ocean.color.colorStatusPositiveDeep)
        XCTAssertEqual(contentList(content(type: .warning)).figmaDescriptionColor, Ocean.color.colorStatusWarningDeep)
        XCTAssertEqual(contentList(content(type: .strikethrough)).figmaDescriptionColor, Ocean.color.colorStatusPositiveDeep)
        XCTAssertEqual(contentList(content(.sm, type: .inactive)).figmaDescriptionColor, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(contentList(content(.sm, type: .inactive)).figmaTitleColor, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(contentList(content(.sm)).figmaDescriptionColor, Ocean.color.colorInterfaceDarkDeep)
        XCTAssertEqual(contentList(content(.sm)).figmaTitleColor, Ocean.color.colorInterfaceDarkDown)
    }

    func testSmallContentIsShorterThanMedium() {
        let medium = measuredHeight(contentList(content(type: .positive).resolved(padding: .all(0))))
        let small = measuredHeight(contentList(content(.sm, type: .positive).resolved(padding: .all(0))))

        XCTAssertLessThan(small, medium)
    }

    func testStrikethroughTextIsDrawnOnTheDescriptionLine() {
        let withoutStrike = content(type: .strikethrough).resolved(padding: .all(0))
        let withStrike = content(type: .strikethrough).resolved(padding: .all(0))
        withStrike.strikethroughText = "Strikethrough"

        XCTAssertEqual(measuredHeight(contentList(withStrike)), measuredHeight(contentList(withoutStrike)), accuracy: 0.5,
                       "the struck text sits beside the description, not on a new line")
    }

    func testResolvedCopyKeepsTheContent() {
        let source = content(.sm, type: .strikethrough)
        source.strikethroughText = "R$ 1,00"
        source.tagTitle = "Tag"

        let copy = source.resolved(type: .inactive, padding: .all(0))

        XCTAssertEqual(copy.title, source.title)
        XCTAssertEqual(copy.description, source.description)
        XCTAssertEqual(copy.caption, source.caption)
        XCTAssertEqual(copy.tagTitle, source.tagTitle)
        XCTAssertEqual(copy.size, .sm)
        XCTAssertEqual(copy.strikethroughText, "R$ 1,00")
        XCTAssertEqual(copy.type, .inactive)
        XCTAssertEqual(copy.padding, .all(0))
    }

    func testNewTypesAreAvailableFromTokens() {
        XCTAssertEqual("positive".toOceanContentType(), .positive)
        XCTAssertEqual("warning".toOceanContentType(), .warning)
        XCTAssertEqual("strikethrough".toOceanContentType(), .strikethrough)
    }

    func testInactiveWinsOverACustomDescriptionColorInTheFigmaMetrics() {
        let parameters = content(.sm, type: .inactive)
        parameters.descriptionColor = Ocean.color.colorStatusNegativePure

        XCTAssertEqual(contentList(parameters).figmaDescriptionColor, Ocean.color.colorInterfaceDarkUp)
    }

    // MARK: - Amount Details (shared block)

    func testNegativeAmountIsPrefixed() {
        XCTAssertEqual(amount(type: .negative).displayAmount, "- R$ 10,00")
        XCTAssertEqual(amount(type: .positive).displayAmount, "R$ 10,00")
    }

    func testAmountColorsFollowTheType() {
        XCTAssertEqual(amount(type: .default).amountColor, Ocean.color.colorInterfaceDarkDeep)
        XCTAssertEqual(amount(type: .negative).amountColor, Ocean.color.colorInterfaceDarkDeep)
        XCTAssertEqual(amount(type: .positive).amountColor, Ocean.color.colorStatusPositiveDeep)
        XCTAssertEqual(amount(type: .strikethrough).amountColor, Ocean.color.colorStatusPositiveDeep)
        XCTAssertEqual(amount(type: .strikethroughNeutral).amountColor, Ocean.color.colorInterfaceDarkDeep)
        XCTAssertEqual(amount(type: .inactive).amountColor, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(amount(type: .inactive).additionalDataColor, Ocean.color.colorInterfaceDarkUp)
    }

    func testStrikethroughIsShownOnlyForTheStrikethroughTypes() {
        XCTAssertTrue(amount(type: .strikethrough).showsStrikethrough)
        XCTAssertTrue(amount(type: .strikethroughNeutral).showsStrikethrough)
        XCTAssertFalse(amount(type: .default).showsStrikethrough)
        XCTAssertFalse(OceanSwiftUI.AmountDetailsParameters(amount: "Grátis", type: .strikethrough).showsStrikethrough)
    }

    func testTagSizeFollowsTheAmountSizeAndTurnsNeutralWhenInactive() {
        XCTAssertEqual(amount(.md).resolvedTag?.size, .medium)
        XCTAssertEqual(amount(.sm).resolvedTag?.size, .small)
        XCTAssertEqual(amount(type: .positive).resolvedTag?.status, .positive)
        XCTAssertEqual(amount(type: .inactive).resolvedTag?.status, .neutralInterface)
        XCTAssertNil(OceanSwiftUI.AmountDetailsParameters(amount: "R$ 1,00", tag: .init(label: "")).resolvedTag)
    }

    func testAmountFontSizes() {
        XCTAssertEqual(amount(.md).fontSize, Ocean.font.fontSizeXs)
        XCTAssertEqual(amount(.sm).fontSize, Ocean.font.fontSizeXxs)
        XCTAssertLessThan(measuredHeight(OceanSwiftUI.AmountDetails(parameters: amount(.sm))),
                          measuredHeight(OceanSwiftUI.AmountDetails(parameters: amount(.md))))
    }

    func testTagEditsRefreshTheAmount() {
        let parameters = amount()
        var notifications = 0
        let subscription = parameters.objectWillChange.sink { notifications += 1 }

        parameters.tag?.label = "Novo"

        XCTAssertEqual(notifications, 1)
        XCTAssertEqual(parameters.resolvedTag?.label, "Novo")
        subscription.cancel()
    }

    // MARK: - Rows

    func testDisabledRowUsesTheInactiveTypes() {
        let parameters = OceanSwiftUI.TransactionListReadOnlyParameters(state: .disabled,
                                                                        contentList: content(type: .positive),
                                                                        amountDetails: amount(type: .positive))

        XCTAssertEqual(parameters.resolvedContentList().type, .inactive)
        XCTAssertEqual(parameters.resolvedAmountDetails().type, .inactive)
        XCTAssertEqual(parameters.resolvedAmountDetails().resolvedTag?.status, .neutralInterface)
        XCTAssertFalse(parameters.isEnabled)
    }

    func testDefaultRowKeepsItsTypesAndUsesTheFamilyMetrics() {
        let parameters = OceanSwiftUI.TransactionListReadOnlyParameters(contentList: content(type: .warning),
                                                                        amountDetails: amount(type: .negative))

        XCTAssertEqual(parameters.resolvedContentList().type, .warning)
        XCTAssertTrue(parameters.resolvedContentList().usesFamilyMetrics)
        XCTAssertEqual(parameters.resolvedContentList().padding, .all(0))
        XCTAssertEqual(parameters.resolvedAmountDetails().type, .negative)
        XCTAssertTrue(parameters.isEnabled)
        XCTAssertFalse(OceanSwiftUI.TransactionListReadOnlyParameters(state: .loading).isEnabled)
    }

    func testContentAndAmountSizesAreIndependent() {
        let mixed = OceanSwiftUI.TransactionListReadOnlyParameters(contentList: content(.sm), amountDetails: amount(.md))

        XCTAssertEqual(mixed.resolvedContentList().size, .sm)
        XCTAssertEqual(mixed.resolvedAmountDetails().size, .md)

        func row(_ contentSize: OceanSwiftUI.ContentListParameters.Size,
                 _ amountSize: OceanSwiftUI.AmountDetailsParameters.Size) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(contentList: content(contentSize),
                                                                                  amountDetails: amount(amountSize),
                                                                                  showDivider: false)))
        }

        XCTAssertLessThan(row(.sm, .sm), row(.md, .md))
        XCTAssertLessThan(row(.sm, .sm), row(.sm, .md), "a bigger amount grows the row while the content stays small")
    }

    func testDividerAddsOnePoint() {
        let withDivider = measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(contentList: content(),
                                                                                                amountDetails: amount())))
        let withoutDivider = measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(contentList: content(),
                                                                                                   amountDetails: amount(),
                                                                                                   showDivider: false)))

        XCTAssertEqual(withDivider - withoutDivider, 1, accuracy: 0.5)
    }

    func testRowPaddingIsSpacingStackXs() {
        let row = measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(contentList: content(),
                                                                                        amountDetails: amount(),
                                                                                        showDivider: false)))
        let block = measuredHeight(HStack(spacing: Ocean.size.spacingStackXxs) {
            OceanSwiftUI.ContentList(parameters: content().resolved(padding: .all(0), usesFamilyMetrics: true))
            OceanSwiftUI.AmountDetails(parameters: amount())
        })

        XCTAssertEqual(row - block, Ocean.size.spacingStackXs * 2, accuracy: 0.5)
    }

    func testNestedChangesRefreshTheRow() {
        let parameters = OceanSwiftUI.TransactionListActionParameters(contentList: content(), amountDetails: amount())
        var notifications = 0
        let subscription = parameters.objectWillChange.sink { notifications += 1 }

        parameters.contentList.title = "Other"
        parameters.amountDetails.amount = "R$ 1,00"
        parameters.contentList = content()
        parameters.contentList.description = "Observed after replacing the block"

        XCTAssertGreaterThanOrEqual(notifications, 4)
        subscription.cancel()
    }

    func testActionKeepsItsCallback() {
        var touches = 0
        let parameters = OceanSwiftUI.TransactionListActionParameters(onTouch: { touches += 1 })

        parameters.onTouch()

        XCTAssertEqual(touches, 1)
        XCTAssertTrue(parameters.showDivider)
    }

    func testIconColorsAreClosedTokens() {
        typealias IconColor = OceanSwiftUI.TransactionListIconColor

        XCTAssertEqual(IconColor.default.color, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(IconColor.onColor.color, Ocean.color.colorInterfaceDarkDown)
        XCTAssertEqual(IconColor.highlight.color, Ocean.color.colorBrandPrimaryDown)
        XCTAssertEqual(OceanSwiftUI.TransactionListReadOnlyParameters().iconColor, .default)
    }

    func testChildIconDefaultsToLightDownAndAnExplicitColorOverridesIt() {
        let child = OceanSwiftUI.TransactionListChildActionParameters()
        XCTAssertEqual(child.resolvedIconColor, Ocean.color.colorInterfaceLightDown)

        for iconColor in [OceanSwiftUI.TransactionListIconColor.default, .onColor, .highlight] {
            XCTAssertEqual(OceanSwiftUI.TransactionListChildReadOnlyParameters(iconColor: iconColor).resolvedIconColor, iconColor.color)
        }

        XCTAssertEqual(OceanSwiftUI.TransactionListChildReadOnlyParameters(state: .disabled).resolvedIconColor,
                       Ocean.color.colorInterfaceLightDeep)
        XCTAssertEqual(OceanSwiftUI.TransactionListReadOnlyParameters().resolvedIconColor, Ocean.color.colorInterfaceDarkUp)
    }

    func testDisabledForcesTheIconToLightDeep() {
        for iconColor in [OceanSwiftUI.TransactionListIconColor.default, .onColor, .highlight] {
            let row = OceanSwiftUI.TransactionListActionParameters(state: .disabled, iconColor: iconColor)
            let child = OceanSwiftUI.TransactionListChildReadOnlyParameters(state: .disabled, iconColor: iconColor)

            XCTAssertEqual(row.resolvedIconColor, Ocean.color.colorInterfaceLightDeep)
            XCTAssertEqual(child.resolvedIconColor, Ocean.color.colorInterfaceLightDeep)
            XCTAssertEqual(OceanSwiftUI.TransactionListParameters(iconColor: iconColor).resolvedIconColor, iconColor.color)
        }
    }

    @MainActor
    func testRowsAreTransparentToSitOnColoredBackgrounds() throws {
        guard #available(iOS 16.0, *) else { throw XCTSkip("ImageRenderer requires iOS 16") }

        let renderer = ImageRenderer(content: OceanSwiftUI.TransactionListReadOnly(parameters: .init(iconColor: .onColor,
                                                                                                    showDivider: false))
            .frame(width: width, height: 80)
            .background(Color(Ocean.color.colorStatusWarningUp)))
        let image = try XCTUnwrap(renderer.uiImage?.cgImage)
        let corner = try XCTUnwrap(image.cropping(to: CGRect(x: image.width - 2, y: 2, width: 1, height: 1)))

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        UIImage(cgImage: corner).pixelColor().getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var expectedRed: CGFloat = 0, expectedGreen: CGFloat = 0, expectedBlue: CGFloat = 0, expectedAlpha: CGFloat = 0
        Ocean.color.colorStatusWarningUp.getRed(&expectedRed, green: &expectedGreen, blue: &expectedBlue, alpha: &expectedAlpha)

        XCTAssertEqual(red, expectedRed, accuracy: 0.03)
        XCTAssertEqual(green, expectedGreen, accuracy: 0.03)
        XCTAssertEqual(blue, expectedBlue, accuracy: 0.03, "the row must not paint white over the hero background")
    }

    func testDensityPaddingTokens() {
        let defaultRow = OceanSwiftUI.TransactionListReadOnlyParameters()
        let compactRow = OceanSwiftUI.TransactionListReadOnlyParameters(density: .compact)

        XCTAssertEqual(defaultRow.density, .default)
        XCTAssertEqual(defaultRow.rowVerticalPadding, Ocean.size.spacingStackXs)
        XCTAssertEqual(compactRow.rowVerticalPadding, Ocean.size.spacingStackXxs)
        XCTAssertEqual(OceanSwiftUI.TransactionListChildActionParameters().childVerticalPadding, Ocean.size.spacingStackXxsExtra)
        XCTAssertEqual(OceanSwiftUI.TransactionListChildReadOnlyParameters(density: .compact).childVerticalPadding,
                       Ocean.size.spacingStackXxs)
    }

    func testCompactRowsAreShorterByTheirPaddingDifference() {
        func row(_ density: OceanSwiftUI.TransactionListDensity, state: OceanSwiftUI.TransactionListState = .default) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListAction(parameters: .init(state: state,
                                                                                contentList: content(),
                                                                                amountDetails: amount(),
                                                                                showDivider: false,
                                                                                density: density)))
        }
        func selectable(_ density: OceanSwiftUI.TransactionListDensity) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListSelectable(parameters: .init(contentList: content(),
                                                                                    amountDetails: amount(),
                                                                                    showDivider: false,
                                                                                    density: density)))
        }
        func child(_ density: OceanSwiftUI.TransactionListDensity) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListChildReadOnly(parameters: .init(contentList: content(.sm),
                                                                                       amountDetails: amount(.sm),
                                                                                       density: density)))
        }

        let topLevelDelta = (Ocean.size.spacingStackXs - Ocean.size.spacingStackXxs) * 2
        XCTAssertEqual(row(.default) - row(.compact), topLevelDelta, accuracy: 0.5)
        XCTAssertEqual(row(.default, state: .loading) - row(.compact, state: .loading), topLevelDelta, accuracy: 0.5,
                       "the skeleton follows the density")
        XCTAssertEqual(selectable(.default) - selectable(.compact), topLevelDelta, accuracy: 0.5)
        XCTAssertEqual(child(.default) - child(.compact), (Ocean.size.spacingStackXxsExtra - Ocean.size.spacingStackXxs) * 2,
                       accuracy: 0.5)
    }

    func testCompactExpandableHeaderIsShorter() {
        func expandable(_ density: OceanSwiftUI.TransactionListDensity) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListExpandable(parameters: .init(hasDivider: false,
                                                                                    header: .init(contentList: content(),
                                                                                                  amountDetails: amount(),
                                                                                                  density: density))))
        }

        XCTAssertEqual(expandable(.default) - expandable(.compact),
                       (Ocean.size.spacingStackXs - Ocean.size.spacingStackXxs) * 2, accuracy: 0.5)
    }

    // MARK: - Figma heights (Read Only 26559:4449, density 26804:18127)

    private func readOnlyHeight(_ contentSize: OceanSwiftUI.ContentListParameters.Size,
                                _ amountSize: OceanSwiftUI.AmountDetailsParameters.Size,
                                density: OceanSwiftUI.TransactionListDensity = .default,
                                state: OceanSwiftUI.TransactionListState = .default) -> CGFloat {
        let amount = OceanSwiftUI.AmountDetailsParameters(amount: "R$ 0,00",
                                                          size: amountSize,
                                                          tag: .init(label: "Label", status: .positive),
                                                          additionalData: "Additional data")
        return measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(state: state,
                                                                                     icon: Ocean.icon.placeholderOutline,
                                                                                     contentList: content(contentSize),
                                                                                     amountDetails: amount,
                                                                                     density: density)))
    }

    func testReadOnlyHeightsMatchFigma() {
        XCTAssertEqual(readOnlyHeight(.md, .md), 100, accuracy: 0.5, "Figma State=Default/Disabled (md)")
        XCTAssertEqual(readOnlyHeight(.md, .md, state: .disabled), 100, accuracy: 0.5)
        XCTAssertEqual(readOnlyHeight(.sm, .sm), 94, accuracy: 0.5, "Figma density Default (sm)")
        XCTAssertEqual(readOnlyHeight(.sm, .sm, density: .compact), 78, accuracy: 0.5, "Figma density Compact (sm)")
        XCTAssertEqual(readOnlyHeight(.md, .md, state: .loading), 73, accuracy: 0.5, "Figma State=Loading")
    }

    func testBlocksUseTheFigmaLineHeight() {
        let amountMd = OceanSwiftUI.AmountDetailsParameters(amount: "R$ 0,00", size: .md,
                                                            tag: .init(label: "Label"), additionalData: "Additional data")
        let amountSm = OceanSwiftUI.AmountDetailsParameters(amount: "R$ 0,00", size: .sm,
                                                            tag: .init(label: "Label"), additionalData: "Additional data")

        // 24 value + 20 tag slot + 4 + 18 additional data / 21 + 16 + 4 + 18
        XCTAssertEqual(measuredHeight(OceanSwiftUI.AmountDetails(parameters: amountMd)), 66, accuracy: 0.5)
        XCTAssertEqual(measuredHeight(OceanSwiftUI.AmountDetails(parameters: amountSm)), 59, accuracy: 0.5)
        // 21 title + 24 description + 4 + 18 caption / 18 + 21 + 4 + 18
        XCTAssertEqual(measuredHeight(contentList(content().resolved(padding: .all(0), usesFamilyMetrics: true))), 67, accuracy: 0.5)
        XCTAssertEqual(measuredHeight(contentList(content(.sm).resolved(padding: .all(0), usesFamilyMetrics: true))), 61, accuracy: 0.5)
    }

    // MARK: - Tag (Figma Tag / Default 3594:34230)

    func testTagPillHeightsMatchFigma() {
        func tag(_ size: OceanSwiftUI.TagParameters.Size,
                 status: OceanSwiftUI.TagParameters.Status = .positive,
                 icon: UIImage? = nil) -> CGFloat {
            measuredHeight(OceanSwiftUI.Tag(parameters: .init(label: "Label", icon: icon, status: status, size: size)).fixedSize())
        }

        XCTAssertEqual(tag(.medium), 20, accuracy: 0.5)
        XCTAssertEqual(tag(.medium, icon: Ocean.icon.placeholderSolid), 20, accuracy: 0.5)
        XCTAssertEqual(tag(.medium, status: .highlightNeutral), 20, accuracy: 0.5)
        XCTAssertEqual(tag(.small), 16, accuracy: 0.5)
        XCTAssertEqual(tag(.small, status: .highlightImportant), 16, accuracy: 0.5)
    }

    func testTagPaddingsFollowFigma() {
        XCTAssertEqual(OceanSwiftUI.Tag(parameters: .init(label: "L", size: .medium)).leadingPadding, 8)
        XCTAssertEqual(OceanSwiftUI.Tag(parameters: .init(label: "L", icon: Ocean.icon.placeholderSolid, size: .medium)).leadingPadding, 6)
        XCTAssertEqual(OceanSwiftUI.Tag(parameters: .init(label: "L", size: .small)).leadingPadding, 4)
    }

    // MARK: - Selectable

    func testCheckboxTogglesAndIndeterminateBecomesSelected() {
        var selections: [Bool] = []
        let parameters = OceanSwiftUI.TransactionListSelectableParameters(isIndeterminate: true,
                                                                          hasError: true,
                                                                          onSelection: { selections.append($0) })

        parameters.toggleSelection()
        XCTAssertTrue(parameters.isSelected)
        XCTAssertFalse(parameters.isIndeterminate)
        XCTAssertFalse(parameters.hasError)

        parameters.toggleSelection()
        XCTAssertFalse(parameters.isSelected)
        XCTAssertEqual(selections, [true, false])
    }

    func testRadioOnlySelects() {
        let parameters = OceanSwiftUI.TransactionListSelectableParameters(controlType: .radio)

        parameters.toggleSelection()
        parameters.toggleSelection()

        XCTAssertTrue(parameters.isSelected)
    }

    func testSelectableDefaultsToTheAppVersion() {
        let parameters = OceanSwiftUI.TransactionListSelectableParameters()

        XCTAssertEqual(parameters.controlType, .checkbox)
        XCTAssertEqual(parameters.controlPosition, .trailing)
        XCTAssertNil(parameters.icon)
    }

    func testSelectableUsesSpacingStackXsBeforeTheControl() {
        func height(_ position: OceanSwiftUI.TransactionListSelectableParameters.ControlPosition) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListSelectable(parameters: .init(controlPosition: position,
                                                                                    contentList: content(),
                                                                                    amountDetails: amount())))
        }

        XCTAssertEqual(height(.trailing), height(.leading), accuracy: 0.5)
    }

    func testSelectionControlStates() {
        typealias Control = TransactionListSelectionControl

        func control(selected: Bool = false, indeterminate: Bool = false,
                     error: Bool = false, enabled: Bool = true) -> Control {
            Control(controlType: .checkbox, isSelected: selected, isIndeterminate: indeterminate,
                    hasError: error, isEnabled: enabled)
        }

        XCTAssertEqual(control().strokeColor, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(control().checkboxFillColor, Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(control(selected: true).checkboxFillColor, Ocean.color.colorComplementaryPure)
        XCTAssertEqual(control(indeterminate: true).checkboxFillColor, Ocean.color.colorComplementaryPure)
        XCTAssertEqual(control(error: true).strokeColor, Ocean.color.colorStatusNegativePure)
        XCTAssertEqual(control(enabled: false).strokeColor, Ocean.color.colorInterfaceLightDown)
        XCTAssertEqual(control(selected: true, enabled: false).checkboxFillColor, Ocean.color.colorInterfaceLightDeep)
        XCTAssertEqual(control(selected: true, enabled: false).strokeColor, Ocean.color.colorInterfaceLightDeep)
    }

    // MARK: - Action types

    func testActionDefaultsToChevron() {
        let parameters = OceanSwiftUI.TransactionListActionParameters()

        XCTAssertEqual(parameters.actionType, .chevron)
        XCTAssertFalse(parameters.isMenuActive)
    }

    func testMenuIconColors() {
        XCTAssertEqual(TransactionListMenuIcon(isActive: false, isDisabled: false).iconColor, Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(TransactionListMenuIcon(isActive: true, isDisabled: false).iconColor, Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(TransactionListMenuIcon(isActive: false, isDisabled: true).iconColor, Ocean.color.colorInterfaceLightDeep)
    }

    func testMenuBottomSheetReportsItsDismissal() {
        var dismissals: [Bool] = []
        let sheet = Ocean.ModalList(UIViewController())
            .withValues(["Ver detalhes", "Compartilhar comprovante", "Cancelar"].map { Ocean.CellModel(title: $0) })
            .withDismiss(true) { wasClosed in dismissals.append(wasClosed) }
            .build()

        XCTAssertTrue(sheet.swipeDismiss)
        sheet.viewWillDisappear(false)

        XCTAssertEqual(dismissals, [true], "the screen sets isMenuActive back to false when the sheet goes away")
    }

    func testModalListWithoutCompletionKeepsTheOldBehavior() {
        let sheet = Ocean.ModalList(UIViewController()).withDismiss(false).build()

        XCTAssertFalse(sheet.swipeDismiss)
        XCTAssertNil(sheet.onDismiss)
    }

    func testMenuActiveStateIsDrivenByTheScreen() {
        let parameters = OceanSwiftUI.TransactionListActionParameters(actionType: .menu)
        var notifications = 0
        let subscription = parameters.objectWillChange.sink { notifications += 1 }

        parameters.isMenuActive = true
        parameters.isMenuActive = false

        XCTAssertEqual(notifications, 2)
        subscription.cancel()
    }

    func testMenuKeepsTheRowHeightOfTheChevron() {
        func height(_ type: OceanSwiftUI.TransactionListActionParameters.ActionType) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListAction(parameters: .init(actionType: type,
                                                                                contentList: content(),
                                                                                amountDetails: amount())))
        }

        XCTAssertEqual(height(.menu), height(.chevron), accuracy: 0.5,
                       "the 32pt menu touch area fits inside the content height")
    }

    // MARK: - Children

    func testChildPositions() {
        typealias Position = OceanSwiftUI.TransactionListChildPosition

        XCTAssertEqual(Position.position(at: 0, count: 1), .standalone)
        XCTAssertEqual(Position.position(at: 0, count: 3), .first)
        XCTAssertEqual(Position.position(at: 1, count: 3), .middle)
        XCTAssertEqual(Position.position(at: 2, count: 3), .last)

        XCTAssertFalse(Position.standalone.hasLineAbove || Position.standalone.hasLineBelow)
        XCTAssertTrue(Position.first.hasLineBelow && !Position.first.hasLineAbove)
        XCTAssertTrue(Position.middle.hasLineAbove && Position.middle.hasLineBelow)
        XCTAssertTrue(Position.last.hasLineAbove && !Position.last.hasLineBelow)
    }

    func testChildrenDefaultToTheSmallSizesWithoutDivider() {
        let action = OceanSwiftUI.TransactionListChildActionParameters()
        let readOnly = OceanSwiftUI.TransactionListChildReadOnlyParameters()

        for parameters in [action as OceanSwiftUI.TransactionListParameters, readOnly] {
            XCTAssertEqual(parameters.contentList.size, .sm)
            XCTAssertEqual(parameters.amountDetails.size, .sm)
            XCTAssertFalse(parameters.showDivider)
            XCTAssertNil(parameters.iconColor)
            XCTAssertEqual(parameters.resolvedIconColor, Ocean.color.colorInterfaceLightDown)
        }
    }

    func testChildContentHasSpacingStackXxsExtraOfVerticalPadding() {
        let child = measuredHeight(OceanSwiftUI.TransactionListChildReadOnly(parameters: .init(contentList: content(.sm),
                                                                                               amountDetails: amount(.sm))))
        let block = measuredHeight(HStack(spacing: Ocean.size.spacingStackXxs) {
            OceanSwiftUI.ContentList(parameters: content(.sm).resolved(padding: .all(0), usesFamilyMetrics: true))
            OceanSwiftUI.AmountDetails(parameters: amount(.sm))
        })

        XCTAssertEqual(child - block, Ocean.size.spacingStackXxsExtra * 2, accuracy: 0.5)
    }

    func testChildPositionDoesNotChangeTheHeight() {
        func height(_ position: OceanSwiftUI.TransactionListChildPosition) -> CGFloat {
            measuredHeight(OceanSwiftUI.TransactionListChildAction(parameters: .init(position: position,
                                                                                     icon: Ocean.icon.placeholderSolid,
                                                                                     contentList: content(.sm),
                                                                                     amountDetails: amount(.sm))))
        }

        let standalone = height(.standalone)
        XCTAssertEqual(height(.first), standalone, accuracy: 0.5)
        XCTAssertEqual(height(.middle), standalone, accuracy: 0.5)
        XCTAssertEqual(height(.last), standalone, accuracy: 0.5)
    }

    // MARK: - Expandable

    func testExpandableWithoutHeaderKeepsTheLegacyApi() {
        let parameters = OceanSwiftUI.TransactionListExpandableParameters(parent: .init(level2: "Retenções", value1: -10),
                                                                          children: [.init(level1: "Filho")],
                                                                          bottomMessage: "Fim")

        XCTAssertNil(parameters.header)
        XCTAssertNil(parameters.slot)
        XCTAssertEqual(parameters.status, .collapsed)
        XCTAssertTrue(parameters.hasDivider)
        XCTAssertGreaterThan(measuredHeight(OceanSwiftUI.TransactionListExpandable(parameters: parameters)), 0)
    }

    func testHeaderChangesRefreshTheExpandable() {
        let header = OceanSwiftUI.TransactionListParameters(state: .loading)
        let parameters = OceanSwiftUI.TransactionListExpandableParameters(header: header)
        var notifications = 0
        let subscription = parameters.objectWillChange.sink { notifications += 1 }

        header.state = .default
        parameters.header = OceanSwiftUI.TransactionListParameters()
        parameters.header?.state = .disabled

        XCTAssertGreaterThanOrEqual(notifications, 3)
        subscription.cancel()
    }

    func testExpandableWithHeaderShowsTheSlotAndFooterOnlyWhenExpanded() {
        func expandable(_ status: OceanSwiftUI.TransactionListExpandableParameters.Status,
                        footer: String = "Additional information") -> CGFloat {
            let slot = OceanSwiftUI.TransactionListChildReadOnly(parameters: .init(contentList: content(.sm),
                                                                                   amountDetails: amount(.sm)))
            return measuredHeight(OceanSwiftUI.TransactionListExpandable(parameters: .init(bottomMessage: footer,
                                                                                           status: status,
                                                                                           header: .init(contentList: content(),
                                                                                                         amountDetails: amount()),
                                                                                           slot: AnyView(slot))))
        }

        let header = measuredHeight(OceanSwiftUI.TransactionListReadOnly(parameters: .init(contentList: content(),
                                                                                           amountDetails: amount())))

        XCTAssertEqual(expandable(.collapsed), header, accuracy: 0.5, "collapsed = header + divider, like the Read Only row")
        XCTAssertGreaterThan(expandable(.expanded), expandable(.expanded, footer: ""))
        XCTAssertGreaterThan(expandable(.expanded, footer: ""), header)
    }
}

private extension UIImage {
    /// Color of a 1×1 image.
    func pixelColor() -> UIColor {
        var pixel = [UInt8](repeating: 0, count: 4)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        return UIColor(red: CGFloat(pixel[0]) / 255, green: CGFloat(pixel[1]) / 255,
                       blue: CGFloat(pixel[2]) / 255, alpha: CGFloat(pixel[3]) / 255)
    }
}
