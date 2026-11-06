//
//  SegmentedControlTests.swift
//  OceanDesignSystemTests
//
//  Copyright © 2026 Blu Pagamentos. All rights reserved.
//

import XCTest
import SwiftUI
import OceanTokens
@testable import OceanComponents

/// `SegmentedControl` against the Figma Segmented Control 1.1.0 (MR-990): exactly two options, 40 of control
/// height and 32 of option, 4 of padding and gap, 12 of horizontal option padding, label in one line
/// truncated with an ellipsis, no border, solid `colorBrandPrimaryPure` selection with white content,
/// `colorInterfaceLightDown` control while pressed, `.default`/`.white` backgrounds and a disabled state.
final class SegmentedControlTests: XCTestCase {

    private typealias Option = OceanSwiftUI.SegmentedControlOptionModel
    private typealias Metrics = OceanSwiftUI.SegmentedControlMetrics

    private let twoOptions = [Option(title: "Loja"), Option(title: "Rede")]

    private func size(of view: some View, width: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        UIHostingController(rootView: view)
            .sizeThatFits(in: CGSize(width: width, height: .greatestFiniteMagnitude))
    }

    private func control(_ options: [Option]) -> OceanSwiftUI.SegmentedControl {
        OceanSwiftUI.SegmentedControl(parameters: .init(options: options))
    }

    // MARK: - Defaults

    func testParametersDefaults() {
        let parameters = OceanSwiftUI.SegmentedControlParameters()

        XCTAssertTrue(parameters.options.isEmpty)
        XCTAssertEqual(parameters.selectedIndex, 0)
        XCTAssertFalse(parameters.isDisabled)
        XCTAssertEqual(parameters.background, .default)
    }

    func testNewParametersAreKept() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 isDisabled: true,
                                                                 background: .white)

        XCTAssertTrue(parameters.isDisabled)
        XCTAssertEqual(parameters.background, .white)
    }

    func testOptionDefaultsHaveNoIconAndNoCounter() {
        let option = Option()

        XCTAssertEqual(option.title, "")
        XCTAssertNil(option.icon)
        XCTAssertNil(option.badgeNumber)
    }

    func testOptionalIconAndCounterAreKept() {
        let icon = UIImage()
        let option = Option(title: "Loja", icon: icon, badgeNumber: 3)

        XCTAssertTrue(option.icon === icon)
        XCTAssertEqual(option.badgeNumber, 3)
    }

    // MARK: - Selection

    func testInitialSelectedIndex() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions, selectedIndex: 1)

        XCTAssertEqual(parameters.selectedIndex, 1)
    }

    func testInitialSelectedIndexOutOfRangeFallsBackToZero() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions, selectedIndex: 2)

        XCTAssertEqual(parameters.selectedIndex, 0)
    }

    func testSetSelectedIndexChangesSelectionWithoutCallingOnTouch() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 onTouch: { touched.append($0) })

        parameters.setSelectedIndex(1)

        XCTAssertEqual(parameters.selectedIndex, 1)
        XCTAssertTrue(touched.isEmpty)
    }

    func testSetSelectedIndexOutOfRangeIsIgnored() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions + [Option(title: "C")])

        parameters.setSelectedIndex(2)
        parameters.setSelectedIndex(-1)
        parameters.setSelectedIndex(9)

        XCTAssertEqual(parameters.selectedIndex, 0)
    }

    func testTouchSelectsOptionAndCallsOnTouchWithIndex() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 onTouch: { touched.append($0) })

        parameters.select(index: 1)
        parameters.select(index: 0)

        XCTAssertEqual(parameters.selectedIndex, 0)
        XCTAssertEqual(touched, [1, 0])
    }

    func testTouchOnSelectedOptionDoesNotCallOnTouch() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 onTouch: { touched.append($0) })

        parameters.select(index: 0)

        XCTAssertEqual(parameters.selectedIndex, 0)
        XCTAssertTrue(touched.isEmpty)
    }

    func testTouchOutOfRangeIsIgnored() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 onTouch: { touched.append($0) })

        parameters.select(index: 2)

        XCTAssertEqual(parameters.selectedIndex, 0)
        XCTAssertTrue(touched.isEmpty)
    }

    func testDisabledTouchDoesNothing() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 isDisabled: true,
                                                                 onTouch: { touched.append($0) })

        parameters.select(index: 1)

        XCTAssertEqual(parameters.selectedIndex, 0)
        XCTAssertTrue(touched.isEmpty)
    }

    func testDisabledStillAcceptsSetSelectedIndex() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 isDisabled: true,
                                                                 onTouch: { touched.append($0) })

        parameters.setSelectedIndex(1)

        XCTAssertEqual(parameters.selectedIndex, 1)
        XCTAssertTrue(touched.isEmpty)
    }

    func testReEnabledTouchWorksAgain() {
        var touched: [Int] = []
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions,
                                                                 isDisabled: true,
                                                                 onTouch: { touched.append($0) })

        parameters.isDisabled = false
        parameters.select(index: 1)

        XCTAssertEqual(parameters.selectedIndex, 1)
        XCTAssertEqual(touched, [1])
    }

    func testOnlyTheFirstTwoOptionsAreDrawn() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: twoOptions + [Option(title: "C")])

        XCTAssertEqual(parameters.visibleOptions.map(\.title), ["Loja", "Rede"])
    }

    func testFewerThanTwoOptionsDrawWhatExists() {
        let parameters = OceanSwiftUI.SegmentedControlParameters(options: [Option(title: "Loja")])

        XCTAssertEqual(parameters.visibleOptions.count, 1)
        parameters.setSelectedIndex(1)
        XCTAssertEqual(parameters.selectedIndex, 0)
    }

    // MARK: - Metrics and tokens

    func testMetricsMatchFigma() {
        XCTAssertEqual(Metrics.optionHeight, 32)
        XCTAssertEqual(Metrics.controlHeight, 40)
        XCTAssertEqual(Metrics.iconSize, 16)
        XCTAssertEqual(Metrics.containerPadding, 4)
        XCTAssertEqual(Metrics.optionsSpacing, 4)
        XCTAssertEqual(Metrics.contentSpacing, 4)
        XCTAssertEqual(Metrics.optionHorizontalPadding, 12)
        XCTAssertEqual(Metrics.optionVerticalPadding, 4)
        XCTAssertEqual(Metrics.cornerRadius(height: 40), 20)
    }

    func testContainerColorPerBackgroundAndState() {
        let color = Metrics.containerColor(background:isPressed:isDisabled:)

        XCTAssertEqual(color(.default, false, false), Ocean.color.colorInterfaceLightUp)
        XCTAssertEqual(color(.white, false, false), Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(color(.default, true, false), Ocean.color.colorInterfaceLightDown)
        XCTAssertEqual(color(.white, true, false), Ocean.color.colorInterfaceLightDown)
        XCTAssertEqual(color(.default, false, true), Ocean.color.colorInterfaceLightUp)
        XCTAssertEqual(color(.white, false, true), Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(color(.default, true, true), Ocean.color.colorInterfaceLightUp)
        XCTAssertEqual(color(.white, true, true), Ocean.color.colorInterfaceLightPure)
    }

    func testSelectionColorIsSolid() {
        XCTAssertEqual(Metrics.selectionColor(isDisabled: false), Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(Metrics.selectionColor(isDisabled: true), Ocean.color.colorInterfaceLightDown)
    }

    func testContentColorPerState() {
        let color = Metrics.contentColor(isSelected:isDisabled:)

        XCTAssertEqual(color(true, false), Ocean.color.colorInterfaceLightPure)
        XCTAssertEqual(color(false, false), Ocean.color.colorBrandPrimaryPure)
        XCTAssertEqual(color(true, true), Ocean.color.colorInterfaceDarkUp)
        XCTAssertEqual(color(false, true), Ocean.color.colorInterfaceDarkUp)
    }

    func testBadgeStatusPerState() {
        XCTAssertEqual(Metrics.badgeStatus(isSelected: true, isDisabled: false), .primaryInverted)
        XCTAssertEqual(Metrics.badgeStatus(isSelected: false, isDisabled: false), .primary)
        XCTAssertEqual(Metrics.badgeStatus(isSelected: true, isDisabled: true), .disabled)
        XCTAssertEqual(Metrics.badgeStatus(isSelected: false, isDisabled: true), .disabled)
    }

    func testReduceMotionRemovesAnimations() {
        XCTAssertNil(Metrics.selectionAnimation(reduceMotion: true))
        XCTAssertNil(Metrics.contentAnimation(reduceMotion: true))
        XCTAssertNil(Metrics.colorAnimation(reduceMotion: true))
        XCTAssertNotNil(Metrics.selectionAnimation(reduceMotion: false))
        XCTAssertNotNil(Metrics.contentAnimation(reduceMotion: false))
        XCTAssertNotNil(Metrics.colorAnimation(reduceMotion: false))
    }

    /// Text, icon and counter colors change with the selection pill: same 0.30s and (0.65, 0, 0.35, 1) curve.
    func testContentColorAnimationMatchesTheSelectionPill() {
        let pill = Animation.timingCurve(0.65, 0, 0.35, 1, duration: 0.30)

        XCTAssertEqual(Metrics.selectionAnimation(reduceMotion: false), pill)
        XCTAssertEqual(Metrics.contentAnimation(reduceMotion: false), pill)
        XCTAssertEqual(Metrics.contentAnimation(reduceMotion: false), Metrics.selectionAnimation(reduceMotion: false))
    }

    /// The short 0.15s transition stays only on the control background (pressed) and is not the content's.
    func testShortColorAnimationIsOnlyForTheControlBackground() {
        XCTAssertEqual(Metrics.colorAnimation(reduceMotion: false), .easeInOut(duration: 0.15))
        XCTAssertNotEqual(Metrics.contentAnimation(reduceMotion: false), Metrics.colorAnimation(reduceMotion: false))
    }

    func testAccessibilityLabelIncludesCounter() {
        XCTAssertEqual(Metrics.accessibilityLabel(title: "Loja", badgeNumber: nil), "Loja")
        XCTAssertEqual(Metrics.accessibilityLabel(title: "Loja", badgeNumber: 3), "Loja, 3")
    }

    // MARK: - Layout

    func testRenderedControlIs40High() {
        XCTAssertEqual(size(of: control(twoOptions)).height, 40, accuracy: 0.5)
    }

    func testNewStatesDoNotChangeTheSize() {
        let options = [Option(title: "Loja", icon: UIImage(), badgeNumber: 2), Option(title: "Rede", badgeNumber: 5)]
        let base = size(of: control(options))
        let white = size(of: OceanSwiftUI.SegmentedControl(parameters: .init(options: options, background: .white)))
        let disabled = size(of: OceanSwiftUI.SegmentedControl(parameters: .init(options: options, isDisabled: true)))

        XCTAssertEqual(white.width, base.width, accuracy: 0.5)
        XCTAssertEqual(disabled.width, base.width, accuracy: 0.5)
        XCTAssertEqual(white.height, 40, accuracy: 0.5)
        XCTAssertEqual(disabled.height, 40, accuracy: 0.5)
    }

    func testRenderedOptionIs32High() {
        let label = OceanSwiftUI.SegmentedControlOptionLabel(option: Option(title: "Loja",
                                                                            icon: UIImage(),
                                                                            badgeNumber: 3))

        XCTAssertEqual(size(of: label).height, 32, accuracy: 0.5)
    }

    func testControlHugsItsOptions() {
        let natural = size(of: control(twoOptions)).width

        XCTAssertLessThan(natural, 320)
        XCTAssertEqual(size(of: control(twoOptions), width: 320).width, natural, accuracy: 0.5)
    }

    func testIconAndCounterWidenTheOption() {
        let plain = size(of: OceanSwiftUI.SegmentedControlOptionLabel(option: Option(title: "Loja"))).width
        let withIcon = size(of: OceanSwiftUI.SegmentedControlOptionLabel(option: Option(title: "Loja",
                                                                                        icon: UIImage()))).width
        let withCounter = size(of: OceanSwiftUI.SegmentedControlOptionLabel(option: Option(title: "Loja",
                                                                                           badgeNumber: 3))).width

        XCTAssertEqual(withIcon, plain + Metrics.iconSize + Metrics.contentSpacing, accuracy: 0.5)
        XCTAssertGreaterThan(withCounter, plain + Metrics.contentSpacing)
    }

    func testLongTitleStaysInOneLineAndFitsTheWidth() {
        let long = [Option(title: "Lançamentos futuros detalhados por loja e por período"), Option(title: "Rede")]
        let natural = size(of: control(long))
        let constrained = size(of: control(long), width: 240)

        XCTAssertGreaterThan(natural.width, 240)
        XCTAssertLessThanOrEqual(constrained.width, 240.5)
        XCTAssertEqual(constrained.height, 40, accuracy: 0.5)
    }
}
