//
//  OceanSwiftUI+ScrollableTabView.swift
//  Charts
//
//  Created by Renan Massaroto on 05/03/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class ScrollableTabViewParameters: ObservableObject {
        @Published public var tabs: [OceanSwiftUI.TabModel] {
            didSet {
                if !tabs.isEmpty {
                    selectedIndex = 0
                } else {
                    selectedIndex = -1
                }
            }
        }
        @Published public var selectedIndex: Int
        @Published public var padding: EdgeInsets

        public init(tabs: [OceanSwiftUI.TabModel] = [],
                    selectedIndex: Int = -1,
                    padding: EdgeInsets = .init(top: 0,
                                                leading: 0,
                                                bottom: 0,
                                                trailing: 0)) {
            self.tabs = tabs
            self.selectedIndex = selectedIndex
            self.padding = padding
        }
    }

    public struct ScrollableTabView: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ScrollableTabView) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ScrollableTabViewParameters

        // MARK: Private properties

        @State private var showTabAtIndex: Int = 0
        @State private var showContentAtIndex: Int = 0
        @State private var contentOffset: CGPoint = .zero
        @State private var sectionsOffset: [Int] = []
        @State private var debouncer: Timer?
        @State private var shouldHandleScroll = true

        // MARK: Constructors

        public init(parameters: ScrollableTabViewParameters = ScrollableTabViewParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        private var tabs: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0..<parameters.tabs.count, id: \.self) { index in
                            getTab(index: index)
                        }
                    }
                    .frame(height: 60)

                    Divider()
                }
            }
        }

        private var content: some View {
            OffsetObservingScrollView(offset: $contentOffset) { coordinateSpace in
                ForEach(0..<parameters.tabs.count, id: \.self) { index in
                    getView(index: index, coordinateSpace: coordinateSpace)
                        .onTapGesture {
                            parameters.selectedIndex = index
                            showTabAtIndex = index
                        }
                }
            }
        }

        public var body: some View {
            VStack {
                if #available(iOS 14.0, *) {
                    ScrollViewReader { scrollReader in
                        tabs.onChange(of: showTabAtIndex) { _ in
                            withAnimation {
                                scrollReader.scrollTo(showTabAtIndex, anchor: .leading)
                            }
                        }
                        .onChange(of: contentOffset) { offset in
                            if shouldHandleScroll {
                                updateSection()
                            } else {
                                debouncer?.invalidate()
                                debouncer = Timer.scheduledTimer(withTimeInterval: 0.16,
                                                                 repeats: false) { _ in
                                    shouldHandleScroll = true
                                }
                            }
                        }
                    }

                    ScrollViewReader { scrollReader in
                        content
                            .onChange(of: showContentAtIndex) { _ in
                                withAnimation {
                                    scrollReader.scrollTo(showContentAtIndex, anchor: .top)
                                }
                            }
                    }
                } else {
                    tabs
                    content
                }
            }
            .padding(parameters.padding)
            .background(Color(Ocean.color.colorInterfaceLightPure))
        }

        @ViewBuilder
        private func getTab(index: Int) -> some View {
            VStack {
                Spacer()
                HStack {
                    OceanSwiftUI.Typography.heading4 { view in
                        view.parameters.text = parameters.tabs[index].title
                        view.parameters.lineLimit = 0
                        view.parameters.textColor = parameters.selectedIndex == index
                        ? Ocean.color.colorBrandPrimaryPure
                        : Ocean.color.colorInterfaceDarkUp
                    }

                    if let badgeNumber = parameters.tabs[index].badgeNumber {
                        OceanSwiftUI.Badge { badge in
                            badge.parameters.count = badgeNumber
                            badge.parameters.status = parameters.selectedIndex == index
                            ? parameters.tabs[index].badgeStatus
                            : .disabled
                            badge.parameters.size = .small
                        }
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
                Spacer()

                if parameters.selectedIndex == index {
                    Color(Ocean.color.colorBrandPrimaryPure).frame(height: 2)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.default, value: parameters.selectedIndex)
            .onTapGesture {
                shouldHandleScroll = false
                showContentAtIndex = index
                parameters.selectedIndex = index
            }
            .id(index)
        }

        @ViewBuilder
        private func getView(index: Int, coordinateSpace: CoordinateSpace) -> some View {
            parameters.tabs[index].contentView
                .id(index)
                .background(GeometryReader { geometryReader in
                    Color.clear.onAppear {
                        let value = Int(geometryReader.frame(in: coordinateSpace).minY)
                        sectionsOffset.append(value)
                        sectionsOffset.sort { $0 <= $1 }
                    }
                })
        }

        private func updateSection() {
            let offset = Int(contentOffset.y)
            var currentSection = -1

            sectionsOffset.forEach { section in
                if section <= offset {
                    currentSection += 1
                }
            }

            if currentSection > -1, currentSection != showTabAtIndex {
                showTabAtIndex = currentSection
                parameters.selectedIndex = currentSection
            }
        }
    }
}

private struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: (CoordinateSpace) -> Content

    var body: some View {
        content(coordinateSpace)
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}

private struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: (CoordinateSpace) -> Content

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}
