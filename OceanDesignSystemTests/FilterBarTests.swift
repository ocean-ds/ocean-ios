//
//  FilterBarTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// `FilterBar` with the optional Segmented Control (Figma Filter Bar 1.1.0, mobile; MR-999): `nil` by default and
/// nothing changes; with it, no dividers between groups, 8 between groups, 16 of breathing room at the end of the
/// scroll, divider · 8 · Segmented · 16 fixed on the right, text-only options and the same 64 of bar height.
final class FilterBarTests: XCTestCase {

    private typealias Option = OceanSwiftUI.SegmentedControlOptionModel
    private typealias Metrics = OceanSwiftUI.FilterBarMetrics

    private let storeNetwork = [Option(title: "Loja"), Option(title: "Rede")]

    private func groups() -> [OceanSwiftUI.FilterBarGroup] {
        [
            .init(options: [.init(chips: [.init(title: "Pagos")]),
                            .init(chips: [.init(title: "Vencidos")])]),
            .init(options: [.init(leadingIcon: Ocean.icon.adjustmentsOutline,
                                  chip: .init(number: 2, title: "Todos os filtros"))])
        ]
    }

    private func size(of view: some View, width: CGFloat) -> CGSize {
        UIHostingController(rootView: view)
            .sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude))
    }

    // MARK: - Default (nil): nothing changes

    func testSegmentedControlIsNilByDefault() {
        XCTAssertNil(OceanSwiftUI.FilterBarParameters().segmentedControl)
        XCTAssertNil(OceanSwiftUI.FilterBarParameters(groups: groups()).segmentedControl)
    }

    func testWithoutSegmentedControlGroupDividersStay() {
        let parameters = OceanSwiftUI.FilterBarParameters(groups: groups())

        XCTAssertFalse(parameters.showsSegmentedControl)
        XCTAssertTrue(parameters.showsGroupDividers)
    }

    func testWithoutSegmentedControlBarIs64High() {
        let bar = OceanSwiftUI.FilterBar(parameters: .init(groups: groups()))

        XCTAssertEqual(size(of: bar, width: 393).height, 64)
    }

    func testOtherDefaultsAreUnchanged() {
        let parameters = OceanSwiftUI.FilterBarParameters()

        XCTAssertEqual(parameters.marginLeft, Ocean.size.spacingStackXs)
        XCTAssertEqual(parameters.marginRight, Ocean.size.spacingStackXs)
        XCTAssertFalse(parameters.showSkeleton)
        XCTAssertEqual(parameters.primaryButtonTitle, "Filtrar")
        XCTAssertEqual(parameters.secondaryButtonTitle, "Limpar")
    }

    // MARK: - With Segmented Control

    func testSegmentedControlIsKeptFromInitAndProperty() {
        let segmented = OceanSwiftUI.SegmentedControlParameters(options: storeNetwork)
        let fromInit = OceanSwiftUI.FilterBarParameters(groups: groups(), segmentedControl: segmented)
        let fromProperty = OceanSwiftUI.FilterBarParameters(groups: groups())
        fromProperty.segmentedControl = segmented

        XCTAssertTrue(fromInit.segmentedControl === segmented)
        XCTAssertTrue(fromProperty.segmentedControl === segmented)
        XCTAssertTrue(fromInit.showsSegmentedControl)
    }

    func testWithSegmentedControlGroupDividersAreRemoved() {
        let parameters = OceanSwiftUI.FilterBarParameters(
            groups: groups(),
            segmentedControl: .init(options: storeNetwork))

        XCTAssertFalse(parameters.showsGroupDividers)
    }

    func testSkeletonHidesSegmentedControlAndKeepsTheOldBar() {
        let parameters = OceanSwiftUI.FilterBarParameters(
            groups: groups(),
            showSkeleton: true,
            segmentedControl: .init(options: storeNetwork))

        XCTAssertFalse(parameters.showsSegmentedControl)
        XCTAssertTrue(parameters.showsGroupDividers)
    }

    func testMetricsMatchFigma() {
        XCTAssertEqual(Metrics.itemSpacing, 8)
        XCTAssertEqual(Metrics.scrollEndPadding, 16)
        XCTAssertEqual(Metrics.dividerToSegmentedSpacing, 8)
        XCTAssertEqual(Metrics.dividerWidth, 1)
        // 64 of bar - 2 × 16 = 32 of divider height.
        XCTAssertEqual(64 - 2 * Metrics.dividerVerticalPadding, 32)
    }

    func testWithSegmentedControlBarIs64HighAndFillsTheWidth() {
        let bar = OceanSwiftUI.FilterBar(parameters: .init(groups: groups(),
                                                           segmentedControl: .init(options: storeNetwork)))
        let barSize = size(of: bar, width: 393)

        XCTAssertEqual(barSize.height, 64)
        XCTAssertEqual(barSize.width, 393)
    }

    // MARK: - Text-only options

    func testSegmentedOptionsLoseIconAndCounter() {
        let options = [Option(title: "Loja", icon: UIImage(), badgeNumber: 2),
                       Option(title: "Rede", icon: UIImage(), badgeNumber: 5)]

        let textOnly = Metrics.textOnly(options)

        XCTAssertEqual(textOnly.map(\.title), ["Loja", "Rede"])
        XCTAssertTrue(textOnly.allSatisfy { $0.icon == nil && $0.badgeNumber == nil })
    }

    func testDrawnParametersKeepSelectionStateAndBackgroundButNotIconOrCounter() {
        let source = OceanSwiftUI.SegmentedControlParameters(
            options: [Option(title: "Loja", icon: UIImage(), badgeNumber: 2), Option(title: "Rede")],
            selectedIndex: 1,
            isDisabled: true,
            background: .white)

        let drawn = Metrics.textOnlyParameters(from: source)

        XCTAssertEqual(drawn.selectedIndex, 1)
        XCTAssertTrue(drawn.isDisabled)
        XCTAssertEqual(drawn.background, .white)
        XCTAssertNil(drawn.options[0].icon)
        XCTAssertNil(drawn.options[0].badgeNumber)
        // The screen's object keeps its own options.
        XCTAssertNotNil(source.options[0].icon)
        XCTAssertEqual(source.options[0].badgeNumber, 2)
    }

    func testTouchOnDrawnControlSelectsOnTheScreenObjectAndCallsItsOnTouch() {
        var touched: [Int] = []
        let source = OceanSwiftUI.SegmentedControlParameters(options: storeNetwork,
                                                             onTouch: { touched.append($0) })

        Metrics.textOnlyParameters(from: source).select(index: 1)

        XCTAssertEqual(source.selectedIndex, 1)
        XCTAssertEqual(touched, [1])
    }

    func testDisabledDrawnControlDoesNothing() {
        var touched: [Int] = []
        let source = OceanSwiftUI.SegmentedControlParameters(options: storeNetwork,
                                                             isDisabled: true,
                                                             onTouch: { touched.append($0) })

        Metrics.textOnlyParameters(from: source).select(index: 1)

        XCTAssertEqual(source.selectedIndex, 0)
        XCTAssertTrue(touched.isEmpty)
    }

    // MARK: - Long text

    func testLongSegmentedTitleNeverLeavesTheBar() {
        let longTitle = String(repeating: "Lançamentos futuros detalhados por loja ", count: 6)
        let bar = OceanSwiftUI.FilterBar(parameters: .init(
            groups: groups(),
            segmentedControl: .init(options: [Option(title: longTitle), Option(title: "Rede")])))

        for width: CGFloat in [320, 360, 393] {
            let barSize = size(of: bar, width: width)
            XCTAssertEqual(barSize.width, width, "width \(width)")
            XCTAssertEqual(barSize.height, 64, "width \(width)")
        }
    }

    /// Long Segmented text is cut with "…" instead of hiding the chips: the scroll area keeps at least
    /// 40% of the bar.
    func testLongSegmentedTitleKeepsTheChipsVisible() {
        let longTitle = "Lançamentos futuros detalhados por loja e por período"
        let bar = OceanSwiftUI.FilterBar(parameters: .init(
            groups: groups(),
            segmentedControl: .init(options: [Option(title: longTitle), Option(title: "Rede")])))

        let scrollWidth = scrollAreaWidth(of: bar, width: 393)

        XCTAssertGreaterThanOrEqual(scrollWidth, 393 * 0.4)
    }

    /// Short Segmented text keeps its natural width: the scroll area is the rest of the bar.
    func testShortSegmentedTitleKeepsItsNaturalWidth() {
        let bar = OceanSwiftUI.FilterBar(parameters: .init(groups: groups(),
                                                           segmentedControl: .init(options: storeNetwork)))
        let segmentedWidth = size(of: OceanSwiftUI.SegmentedControl(parameters: .init(options: storeNetwork)),
                                  width: .greatestFiniteMagnitude).width

        let scrollWidth = scrollAreaWidth(of: bar, width: 393)

        // 393 = scroll area + divider (1) + 8 + Segmented + 16.
        XCTAssertEqual(scrollWidth + 1 + 8 + segmentedWidth + 16, 393, accuracy: 0.5)
    }

    private func scrollAreaWidth(of bar: OceanSwiftUI.FilterBar, width: CGFloat) -> CGFloat {
        let host = UIHostingController(rootView: bar.frame(width: width))
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 300))
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.layoutIfNeeded()
        RunLoop.main.run(until: Date().addingTimeInterval(0.2))
        defer { window.isHidden = true }
        return firstScrollView(in: host.view)?.frame.width ?? 0
    }

    private func firstScrollView(in view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView { return scrollView }
        for subview in view.subviews {
            if let scrollView = firstScrollView(in: subview) { return scrollView }
        }
        return nil
    }

    func testLongChipTitleKeepsTheBarHeight() {
        let longTitle = String(repeating: "Filtro com nome muito comprido ", count: 6)
        let bar = OceanSwiftUI.FilterBar(parameters: .init(
            groups: [.init(options: [.init(chips: [.init(title: longTitle)])])],
            segmentedControl: .init(options: storeNetwork)))

        let barSize = size(of: bar, width: 360)

        XCTAssertEqual(barSize.width, 360)
        XCTAssertEqual(barSize.height, 64)
    }
}
