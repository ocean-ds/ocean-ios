//
//  OceanSwiftUI+ScrollableTab.swift
//  Charts
//
//  Created by Renan Massaroto on 05/03/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameter

    public class ScrollableTabParameters: ObservableObject {
        @Published public var header: (any View)?
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
        public var onTouch: (Int) -> Void

        public init(header: (any View)? = nil,
                    tabs: [OceanSwiftUI.TabModel] = [],
                    selectedIndex: Int = -1,
                    padding: EdgeInsets = .init(top: 0,
                                                leading: 0,
                                                bottom: 0,
                                                trailing: 0),
                    onTouch: @escaping (Int) -> Void = { _ in }) {
            self.header = header
            self.tabs = tabs
            self.selectedIndex = selectedIndex
            self.padding = padding
            self.onTouch = onTouch
        }
    }

    public struct ScrollableTab: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ScrollableTab) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ScrollableTabParameters

        // MARK: Private properties

        @State private var showTabAtIndex: Int = 0
        @State private var showContentAtIndex: Int = -1
        @State private var contentOffset: CGPoint = .zero
        @State private var sectionsOffset: [Int] = []
        @State private var position: CGPoint = .zero
        @State private var debouncer: Timer?
        @State private var tabHeight: CGFloat = 60

        @State public private(set) var contentSize: CGFloat = .zero

        // MARK: Constructors

        public init(parameters: ScrollableTabParameters = ScrollableTabParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if #available(iOS 14.0, *) {
                VStack(spacing: 0) {
                    if position.y <= 0 || parameters.header == nil {
                        ScrollViewReader { scrollReader in
                            getTabs().onChange(of: showTabAtIndex) { _ in
                                withAnimation {
                                    scrollReader.scrollTo(showTabAtIndex, anchor: .leading)
                                }
                            }
                            .background(Color(Ocean.color.colorInterfaceLightPure))
                            .onChange(of: contentOffset) { offset in
                                debouncer?.invalidate()
                                debouncer = Timer.scheduledTimer(withTimeInterval: 0.16,
                                                                 repeats: false) { _ in
                                    updateSection()
                                }
                            }
                        }
                    }

                    ScrollViewReader { scrollReader in
                        OffsetObservingScrollView(offset: $contentOffset) { coordinateSpace in
                            VStack {
                                if let header = parameters.header {
                                    AnyView(header)
                                }

                                PositionObservingView(coordinateSpace: coordinateSpace,
                                                      position: $position) { coordinateSpace in
                                    Spacer()
                                        .frame(height: 0)
                                }

                                if parameters.header != nil {
                                    if position.y > 0 {
                                        getTabs(shouldUpdate: false)
                                    } else {
                                        Spacer()
                                            .frame(height: getSpacerHeight())
                                    }
                                }

                                ForEach(0..<parameters.tabs.count, id: \.self) { index in
                                    getView(index: index, coordinateSpace: coordinateSpace)
                                        .onTapGesture {
                                            parameters.selectedIndex = index
                                            showTabAtIndex = index
                                        }
                                }
                                .onChange(of: showContentAtIndex) { _ in
                                    if showContentAtIndex > -1 {
                                        withAnimation {
                                            scrollReader.scrollTo(showContentAtIndex, anchor: .top)
                                        }
                                    }
                                    showContentAtIndex = -1
                                }
                            }
                        }
                        .padding(parameters.padding)
                        .background(Color(Ocean.color.colorInterfaceLightPure))
                    }
                }
            } else {
                ScrollView {
                    VStack {
                        if let header = parameters.header {
                            AnyView(header)
                        }

                        getTabs(shouldUpdate: false)

                        ForEach(0..<parameters.tabs.count, id: \.self) { index in
                            getView(index: index, coordinateSpace: .global)
                        }
                    }
                }
                .padding(parameters.padding)
                .background(Color(Ocean.color.colorInterfaceLightPure))
            }
        }

        @ViewBuilder
        private func getTabs(shouldUpdate: Bool = true) -> some View {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 0) {
                    if !parameters.tabs.isEmpty {
                        HStack(spacing: 0) {
                            ForEach(0..<parameters.tabs.count, id: \.self) { index in
                                getTab(index: index, shouldUpdate: shouldUpdate)
                            }
                        }
                        .frame(height: 60)

                        Divider()
                    }
                }
                .background(GeometryReader { geometryReader in
                    Color.clear.onAppear {
                        tabHeight = geometryReader.size.height
                    }
                })
            }
        }

        @ViewBuilder
        private func getTab(index: Int, shouldUpdate: Bool = true) -> some View {
            VStack {
                Spacer()
                HStack {
                    OceanSwiftUI.Typography.heading4 { view in
                        view.parameters.text = parameters.tabs[index].title
                        view.parameters.lineLimit = 0
                        view.parameters.textColor = shouldUpdate && parameters.selectedIndex == index || !shouldUpdate && index == 0
                        ? Ocean.color.colorBrandPrimaryPure
                        : Ocean.color.colorInterfaceDarkUp
                    }
                    .fixedSize(horizontal: true, vertical: false)

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
            }
            .overlay(shouldUpdate && parameters.selectedIndex == index || !shouldUpdate && index == 0
                     ? Color(Ocean.color.colorBrandPrimaryPure).frame(height: 2)
                     : Color.clear.frame(height: 2),
                     alignment: .bottom)
            .animation(.default, value: parameters.selectedIndex)
            .onTapGesture {
                debouncer?.invalidate()
                showContentAtIndex = index
                parameters.selectedIndex = index
                parameters.onTouch(index)
            }
            .id(index)
        }

        @ViewBuilder
        private func getView(index: Int, coordinateSpace: CoordinateSpace) -> some View {
            parameters.tabs[index].contentView
                .id(index)
                .overlay(GeometryReader { geometryReader in
                    Color.clear.onAppear {
                        let value = Int(geometryReader.frame(in: coordinateSpace).minY)
                        sectionsOffset.append(value)
                        sectionsOffset.sort { $0 <= $1 }

                        if geometryReader.frame(in: coordinateSpace).maxY > contentSize {
                            contentSize = geometryReader.frame(in: coordinateSpace).maxY
                        }
                    }
                })
        }

        private func updateSection() {
            let offset = position.y > 0
            ? Int(contentOffset.y)
            : Int(contentOffset.y + tabHeight)

            var currentSection = -1
            sectionsOffset.forEach { section in
                if section <= offset {
                    currentSection += 1
                }
            }

            parameters.selectedIndex = currentSection > -1 ? currentSection : 0
            if currentSection > -1, currentSection != showTabAtIndex {
                showTabAtIndex = currentSection
            }
        }

        private func getSpacerHeight() -> CGFloat {
            let height = tabHeight - position.y

            if 0..<tabHeight ~= height {
                return height
            } else if height < 0 {
                return tabHeight
            } else {
                return 0
            }
        }
    }
}

private struct PositionObservingView<Content: View>: View {
    public var coordinateSpace: CoordinateSpace
    @Binding public var position: CGPoint
    @ViewBuilder public var content: (CoordinateSpace) -> Content

    public var body: some View {
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
        public static var defaultValue: CGPoint { .zero }

        public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
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
