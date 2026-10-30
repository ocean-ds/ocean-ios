//
//  TabTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// `Tab` and `ScrollableTab` against the Figma Tab Bar / _Tab Item (MR-980): 56 of item height,
/// 2 of selection line, 1 of bottom line, label in one line that never wraps or truncates (in the
/// fixed layout, a label that does not fit its equal share makes the bar scroll), blue label on the
/// selected or pressed tab and a neutral counter on the inactive ones.
final class TabTests: XCTestCase {

    // MARK: - Helpers

    private func naturalWidth(title: String, badgeNumber: Int? = nil) -> CGFloat {
        let label = OceanSwiftUI.TabItemLabel(title: title,
                                              badgeNumber: badgeNumber,
                                              badgeStatus: .primary,
                                              isSelected: false)
        let controller = UIHostingController(rootView: label.fixedSize())
        return controller.sizeThatFits(in: CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                  height: CGFloat.greatestFiniteMagnitude)).width
    }

    // MARK: - Defaults

    func testParametersDefaultsKeepCurrentBehavior() {
        let parameters = OceanSwiftUI.TabParameters()

        XCTAssertTrue(parameters.tabs.isEmpty)
        XCTAssertEqual(parameters.tabSelectedIndex, 0)
        XCTAssertNil(parameters.contentIdealHeight)
        XCTAssertFalse(parameters.isScrollable)
    }

    func testModelDefaultsHaveNoCounterAndPrimaryStatus() {
        let model = OceanSwiftUI.TabModel()

        XCTAssertEqual(model.title, "")
        XCTAssertNil(model.badgeNumber)
        XCTAssertEqual(model.badgeStatus, .primary)
    }

    // MARK: - Selection

    func testSetSelectedIndexChangesSelectionWithoutCallingOnTouch() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.TabParameters(tabs: [.init(title: "A"), .init(title: "B")],
                                                    onTouch: { touched.append($0) })

        parameters.setSelectedIndex(1)

        XCTAssertEqual(parameters.tabSelectedIndex, 1)
        XCTAssertTrue(touched.isEmpty)
    }

    func testSetSelectedIndexOutOfRangeIsIgnored() {
        let parameters = OceanSwiftUI.TabParameters(tabs: [.init(title: "A"), .init(title: "B")])

        parameters.setSelectedIndex(5)
        parameters.setSelectedIndex(-1)

        XCTAssertEqual(parameters.tabSelectedIndex, 0)
    }

    func testTouchSelectsTabAndCallsOnTouch() {
        var touched: [Int] = []
        let tabs: [OceanSwiftUI.TabModel] = [.init(title: "A"), .init(title: "B"), .init(title: "C")]
        let parameters = OceanSwiftUI.TabParameters(tabs: tabs, onTouch: { touched.append($0) })

        parameters.selectTab(tab: tabs[2], index: 2)

        XCTAssertEqual(parameters.tabSelectedIndex, 2)
        XCTAssertEqual(touched, [2])
    }

    func testUpdateTabReplacesOnlyIndexInRange() {
        let parameters = OceanSwiftUI.TabParameters(tabs: [.init(title: "A"), .init(title: "B")])

        parameters.updateTab(tab: .init(title: "Nova", badgeNumber: 3), index: 1)
        parameters.updateTab(tab: .init(title: "Fora"), index: 9)

        XCTAssertEqual(parameters.tabs.map(\.title), ["A", "Nova"])
        XCTAssertEqual(parameters.tabs[1].badgeNumber, 3)
    }

    // MARK: - Metrics

    func testItemHeightIs56AndLinesMatchFigma() {
        XCTAssertEqual(OceanSwiftUI.TabMetrics.itemHeight, 56)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.indicatorHeight, 2)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.dividerHeight, 1)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.barHeight, 57)
    }

    func testRenderedItemIs56High() {
        let item = OceanSwiftUI.TabItem(title: "Aba",
                                        badgeNumber: 10,
                                        badgeStatus: .primary,
                                        isSelected: true,
                                        action: {})
        let controller = UIHostingController(rootView: item)
        let size = controller.sizeThatFits(in: CGSize(width: 320, height: 1000))

        XCTAssertEqual(size.height, 56, accuracy: 0.5)
    }

    func testItemWidthIsLabelPlusHorizontalPadding() {
        let label = OceanSwiftUI.Typography.heading4 { $0.parameters.text = "Aba"; $0.parameters.lineLimit = 1 }
        let textWidth = UIHostingController(rootView: label.fixedSize())
            .sizeThatFits(in: CGSize(width: 1000, height: 1000)).width

        XCTAssertEqual(naturalWidth(title: "Aba"), textWidth + 2 * Ocean.size.spacingStackXs, accuracy: 0.5)
    }

    // MARK: - Long text

    func testFixedLayoutFitsWhenEveryItemFitsItsEqualShare() {
        XCTAssertTrue(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: [80, 100, 106], availableWidth: 320))
    }

    func testFixedLayoutFallsBackToScrollWhenOneItemDoesNotFit() {
        XCTAssertFalse(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: [80, 140, 90], availableWidth: 320))
    }

    func testFixedLayoutWithoutMeasurementsStaysFixed() {
        XCTAssertTrue(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: [], availableWidth: 320))
        XCTAssertTrue(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: [500], availableWidth: 0))
    }

    func testLongLabelDoesNotFitThreeFixedTabsOnAPhone() {
        let widths = ["Resumo", "Lançamentos futuros detalhados", "Extrato"].map { naturalWidth(title: $0) }

        XCTAssertFalse(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: widths, availableWidth: 375))
    }

    func testShortLabelsFitThreeFixedTabsOnAPhone() {
        let widths = ["Todas", "Abertas", "Pagas"].map { naturalWidth(title: $0) }

        XCTAssertTrue(OceanSwiftUI.TabMetrics.fitsEqually(itemWidths: widths, availableWidth: 375))
    }

    func testLongLabelKeepsItsFullWidthInOneLine() {
        let long = "Lançamentos futuros detalhados"
        let single = naturalWidth(title: long)
        let label = OceanSwiftUI.TabItemLabel(title: long, badgeNumber: nil, badgeStatus: .primary, isSelected: false)
        let height = UIHostingController(rootView: label.fixedSize())
            .sizeThatFits(in: CGSize(width: 100, height: 1000)).height
        let shortHeight = UIHostingController(rootView: OceanSwiftUI.TabItemLabel(title: "A",
                                                                                   badgeNumber: nil,
                                                                                   badgeStatus: .primary,
                                                                                   isSelected: false).fixedSize())
            .sizeThatFits(in: CGSize(width: 100, height: 1000)).height

        XCTAssertGreaterThan(single, 100)
        XCTAssertEqual(height, shortHeight, accuracy: 0.5)
    }

    // MARK: - States

    func testLabelColorIsBlueWhenSelectedOrPressedAndGreyOtherwise() {
        XCTAssertEqual(OceanSwiftUI.TabMetrics.labelColor(isSelected: true, isPressed: false), Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.labelColor(isSelected: false, isPressed: true), Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.labelColor(isSelected: false, isPressed: false), Ocean.color.colorInterfaceDarkUp)
    }

    func testCounterUsesTabStatusWhenHighlightedAndNeutralWhenInactive() {
        XCTAssertEqual(OceanSwiftUI.TabMetrics.badgeStatus(.warning, isSelected: true, isPressed: false), .warning)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.badgeStatus(.primary, isSelected: false, isPressed: true), .primary)
        XCTAssertEqual(OceanSwiftUI.TabMetrics.badgeStatus(.primary, isSelected: false, isPressed: false), .disabled)
    }

    func testAccessibilityLabelIncludesCounter() {
        XCTAssertEqual(OceanSwiftUI.TabMetrics.accessibilityLabel(title: "Pendentes", badgeNumber: 3), "Pendentes, 3")
        XCTAssertEqual(OceanSwiftUI.TabMetrics.accessibilityLabel(title: "Pendentes", badgeNumber: nil), "Pendentes")
    }

    // MARK: - Motion

    func testMotionMatchesApprovedWebCurves() {
        XCTAssertEqual(OceanSwiftUI.TabMetrics.indicatorAnimation(reduceMotion: false),
                       .timingCurve(0.65, 0, 0.35, 1, duration: 0.30))
        XCTAssertEqual(OceanSwiftUI.TabMetrics.colorAnimation(reduceMotion: false), .easeInOut(duration: 0.15))
        XCTAssertEqual(OceanSwiftUI.TabMetrics.scrollAnimation(reduceMotion: false),
                       .timingCurve(0.65, 0, 0.35, 1, duration: 0.40))
    }

    func testReduceMotionDisablesEveryAnimation() {
        XCTAssertNil(OceanSwiftUI.TabMetrics.indicatorAnimation(reduceMotion: true))
        XCTAssertNil(OceanSwiftUI.TabMetrics.colorAnimation(reduceMotion: true))
        XCTAssertNil(OceanSwiftUI.TabMetrics.scrollAnimation(reduceMotion: true))
    }

    func testFullyVisibleTabAwayFromEdgesDoesNotScroll() {
        let frame = CGRect(x: 120, y: 0, width: 80, height: 56)

        XCTAssertFalse(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: frame, viewportWidth: 375))
    }

    func testTabWithin24OfAnEdgeScrolls() {
        XCTAssertTrue(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: CGRect(x: 10, y: 0, width: 80, height: 56),
                                                          viewportWidth: 375))
        XCTAssertTrue(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: CGRect(x: 280, y: 0, width: 80, height: 56),
                                                          viewportWidth: 375))
    }

    func testTabExactly24FromEdgesDoesNotScroll() {
        let frame = CGRect(x: 24, y: 0, width: 327, height: 56)

        XCTAssertFalse(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: frame, viewportWidth: 375))
    }

    func testHiddenOrUnmeasuredTabScrolls() {
        XCTAssertTrue(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: CGRect(x: -90, y: 0, width: 80, height: 56),
                                                          viewportWidth: 375))
        XCTAssertTrue(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: CGRect(x: 400, y: 0, width: 80, height: 56),
                                                          viewportWidth: 375))
        XCTAssertTrue(OceanSwiftUI.TabMetrics.needsScroll(itemFrame: nil, viewportWidth: 375))
    }

    func testViewportUsesMeasuredFramePerIndex() {
        let viewport = OceanSwiftUI.TabBarViewport()
        viewport.width = 375
        viewport.itemFrames = [0: CGRect(x: 32, y: 0, width: 80, height: 56),
                               4: CGRect(x: 360, y: 0, width: 80, height: 56)]

        XCTAssertFalse(viewport.needsScroll(to: 0))
        XCTAssertTrue(viewport.needsScroll(to: 4))
    }

    // MARK: - ScrollableTab scroll-spy

    func testSpyFollowsContentWhenNotLocked() {
        let result = ScrollableTabSpy.resolve(currentSection: 2, lockedIndex: nil, elapsed: 0)

        XCTAssertEqual(result.selectedIndex, 2)
        XCTAssertFalse(result.keepLock)
    }

    func testSpyIgnoresSectionsOnTheWayToTheTappedTab() {
        let result = ScrollableTabSpy.resolve(currentSection: 2, lockedIndex: 3, elapsed: 0.2)

        XCTAssertEqual(result.selectedIndex, 3)
        XCTAssertTrue(result.keepLock)
    }

    func testSpyReleasesLockWhenTappedSectionArrives() {
        let result = ScrollableTabSpy.resolve(currentSection: 3, lockedIndex: 3, elapsed: 0.3)

        XCTAssertEqual(result.selectedIndex, 3)
        XCTAssertFalse(result.keepLock)
    }

    func testSpyResumesAfterTimeout() {
        let result = ScrollableTabSpy.resolve(currentSection: 1, lockedIndex: 4,
                                                           elapsed: ScrollableTabSpy.tapLockTimeout)

        XCTAssertEqual(result.selectedIndex, 1)
        XCTAssertFalse(result.keepLock)
    }
}
