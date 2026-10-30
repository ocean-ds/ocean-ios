//
//  OceanSwiftUI+ScrollableTab.swift
//  OceanDesignSystem
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
        @State private var sectionsOffset: [Int: Int] = [:]
        @State private var position: CGPoint = .zero
        @State private var debouncer: Timer?
        @State private var tabHeight: CGFloat = TabMetrics.barHeight
        @State private var viewport = TabBarViewport()
        @State private var tapLockIndex: Int?
        @State private var tapLockDate: Date = .distantPast
        @Environment(\.accessibilityReduceMotion) private var reduceMotion

        private let viewportSpace = "OceanSwiftUI.ScrollableTab.viewport"

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
            VStack(spacing: 0) {
                if position.y <= 0 || parameters.header == nil {
                    ScrollViewReader { scrollReader in
                        getTabs().onChange(of: showTabAtIndex) { _ in
                            guard viewport.needsScroll(to: showTabAtIndex) else { return }
                            withAnimation(TabMetrics.scrollAnimation(reduceMotion: reduceMotion)) {
                                scrollReader.scrollTo(showTabAtIndex, anchor: .center)
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
                                    .overlay(GeometryReader { geometryReader in
                                        Color.clear.onAppear {
                                            guard !sectionsOffset.isEmpty, let firstOffset = sectionsOffset[0] else { return }

                                            let height = Int(geometryReader.size.height)

                                            if firstOffset < height {
                                                sectionsOffset = sectionsOffset.mapValues({ value in
                                                    value - firstOffset + height + Int(tabHeight)
                                                })
                                            }
                                        }
                                    })
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
                                    withAnimation(reduceMotion ? nil : .default) {
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
        }

        @ViewBuilder
        private func getTabs(shouldUpdate: Bool = true) -> some View {
            VStack(spacing: 0) {
                if !parameters.tabs.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0..<parameters.tabs.count, id: \.self) { index in
                                getTab(index: index, shouldUpdate: shouldUpdate)
                            }
                        }
                        .frame(height: TabMetrics.itemHeight)
                        .modifier(TabIndicatorOverlay(selectedIndex: shouldUpdate ? parameters.selectedIndex : 0,
                                                      reduceMotion: reduceMotion))
                        // Margem da barra com rolagem (Figma: spacingStackMd) dentro do conteúdo:
                        // as abas são cortadas na borda da tela e a linha de baixo segue em toda a largura.
                        .padding(.horizontal, Ocean.size.spacingStackMd)
                    }
                    .coordinateSpace(name: viewportSpace)
                    .background(GeometryReader { proxy in
                        Color.clear.preference(key: TabViewportWidthKey.self, value: proxy.size.width)
                    })
                    .onPreferenceChange(TabItemFramesKey.self) { frames in
                        if shouldUpdate { viewport.itemFrames = frames }
                    }
                    .onPreferenceChange(TabViewportWidthKey.self) { width in
                        if shouldUpdate { viewport.width = width }
                    }

                    // Linha de baixo em toda a largura da barra, não só sob as abas.
                    OceanSwiftUI.Divider()
                }
            }
            .background(GeometryReader { geometryReader in
                Color.clear.onAppear {
                    tabHeight = geometryReader.size.height
                }
            })
        }

        @ViewBuilder
        private func getTab(index: Int, shouldUpdate: Bool = true) -> some View {
            let tab = parameters.tabs[index]
            let isSelected = shouldUpdate && parameters.selectedIndex == index || !shouldUpdate && index == 0

            TabItem(title: tab.title,
                    badgeNumber: tab.badgeNumber,
                    badgeStatus: tab.badgeStatus,
                    isSelected: isSelected,
                    index: index,
                    viewportSpace: shouldUpdate ? viewportSpace : nil) {
                debouncer?.invalidate()
                // A rolagem do conteúdo disparada pelo toque não deixa o scroll-spy marcar as abas do caminho.
                tapLockIndex = index
                tapLockDate = Date()
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
                        sectionsOffset[index] = value

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

            let currentSection = sectionsOffset.filter { $0.value <= offset }.max { value1, value2 in
                value1.value <= value2.value
            }?.key ?? -1

            let resolution = ScrollableTabSpy.resolve(currentSection: currentSection,
                                                      lockedIndex: tapLockIndex,
                                                      elapsed: Date().timeIntervalSince(tapLockDate))
            tapLockIndex = resolution.keepLock ? tapLockIndex : nil
            parameters.selectedIndex = resolution.selectedIndex
            guard !resolution.keepLock else { return }

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

/// Decisão do scroll-spy do `ScrollableTab`.
enum ScrollableTabSpy {
    /// Tempo máximo que o toque numa aba segura o scroll-spy (cobre a rolagem animada do conteúdo).
    static let tapLockTimeout: TimeInterval = 1.0

    /// Depois de um toque, a seleção fica na aba tocada enquanto o conteúdo rola até ela: as seções do
    /// caminho são ignoradas. O bloqueio acaba quando a seção tocada chega ao topo ou depois de
    /// `tapLockTimeout`; aí o scroll-spy volta a valer.
    static func resolve(currentSection: Int,
                        lockedIndex: Int?,
                        elapsed: TimeInterval,
                        timeout: TimeInterval = tapLockTimeout) -> (selectedIndex: Int, keepLock: Bool) {
        let spied = currentSection > -1 ? currentSection : 0
        guard let lockedIndex, elapsed < timeout else { return (spied, false) }
        return (lockedIndex, currentSection != lockedIndex)
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
