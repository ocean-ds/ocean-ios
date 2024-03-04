//
//  ScrollableTabSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 04/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class ScrollableTabSwiftUIViewController: UIViewController {
    private lazy var scrollableTab: OceanSwiftUI.ScrollableTabView = {
        OceanSwiftUI.ScrollableTabView { scrollView in
            scrollView.parameters.tabs = [
                .init(title: "Tab 1",
                      view: Text("1 Beatae non nostrum voluptates molestiae ut sunt. Repudiandae laborum et explicabo. Earum quos quos sint ut provident dolorem eveniet et.")),
                .init(title: "Tab 2",
                      view: Text("2 Aut beatae dicta molestiae. Omnis voluptatem enim consectetur dolorem eum alias. Quibusdam quas fugiat culpa aperiam suscipit laborum commodi dignissimos.")),
                .init(title: "Tab 3",
                      view: Text("3 Est animi debitis consequatur. Nostrum provident rerum deserunt fugit. Quod molestiae eius est enim delectus blanditiis.")),
                .init(title: "Tab 4",
                      view: Text("4 Porro quos laborum dolores est debitis minus. Corrupti blanditiis est voluptatem. Nihil qui sint amet sed saepe. Laborum ad amet voluptatibus culpa aut qui consequatur.")),
                .init(title: "Tab 5",
                      view: Text("5 Doloremque harum in dolores itaque libero. Magnam quo cumque dolor non delectus aut tenetur. Sit fugiat repellat quo error. Voluptatibus placeat a ex quis molestias consequatur omnis. Dolores aut voluptate quam eum molestiae non.")),
                .init(title: "Tab 6",
                      view: Text("6 Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")),
                .init(title: "Tab 7",
                      view: Text("7 Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"))
            ]
            scrollView.parameters.onTabSelected = { index, tabModel in

            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: scrollableTab)

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct ScrollableTabSwiftUIViewController_Preview: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            ScrollableTabSwiftUIViewController()
        }
    }
}

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
        @Published public var selectedIndex: Int {
            didSet {

            }
        }
        @Published public var padding: EdgeInsets
        public var onTabSelected: (Int, OceanSwiftUI.TabModel) -> Void

        public var topPositions: [CGFloat] = []

        public init(tabs: [OceanSwiftUI.TabModel] = [],
                    selectedIndex: Int = -1,
                    padding: EdgeInsets = .init(top: 0,
                                                leading: 0,
                                                bottom: 0,
                                                trailing: 0),
                    onTabSelected: @escaping (Int, OceanSwiftUI.TabModel) -> Void = { _, _ in }) {
            self.tabs = tabs
            self.selectedIndex = selectedIndex
            self.padding = padding
            self.onTabSelected = onTabSelected
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

//        @State private var showIndex: Int = 0
        @State private var contentOffset: CGPoint = .zero

        // MARK: Constructors

        public init(parameters: ScrollableTabViewParameters = ScrollableTabViewParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                if #available(iOS 14.0, *) {
                    ScrollViewReader { scrollReader in
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
                        .onChange(of: showTabAtIndex) { _ in
                            withAnimation {
                                scrollReader.scrollTo(showTabAtIndex, anchor: .leading)
                            }
                        }
                        .onChange(of: contentOffset) { offset in
                            var lastIndex = -1
                            parameters.topPositions.forEach { position in
                                if position < offset.y {
                                    lastIndex += 1
                                }
                            }

                            if lastIndex > -1, lastIndex != showTabAtIndex {
                                showTabAtIndex = lastIndex
                                parameters.selectedIndex = lastIndex
                            }
                        }
                    }

                    ScrollViewReader { scrollReader in
                        OffsetObservingScrollView(offset: $contentOffset) {
                            ForEach(0..<parameters.tabs.count, id: \.self) { index in
                                getView(index: index)
                                    .onTapGesture {
                                        parameters.selectedIndex = index
                                        showTabAtIndex = index
                                    }
                            }
                        }
                        .onChange(of: showContentAtIndex) { _ in
                            withAnimation {
                                scrollReader.scrollTo(showContentAtIndex, anchor: .top)
                            }
                        }
                    }
                }
            }
            .padding(parameters.padding)
            .background(Color(Ocean.color.colorInterfaceLightPure))
        }

        @available(iOS 14.0, *)
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
                showContentAtIndex = index
                parameters.selectedIndex = index
                parameters.onTabSelected(index, parameters.tabs[index])
            }
            .id(index)
        }

        @ViewBuilder
        private func getView(index: Int) -> some View {
            VStack(spacing: 0) {
                GeometryReader { geometryReader in
                    Rectangle()
                        .frame(height: 0)
                        .onAppear {
                            let frame = geometryReader.frame(in: .named(UUID())).minY
                            print("SWPOCAS -> Index: \(frame)")
                            parameters.topPositions.append(frame - 138)
                        }
                }
                .frame(height: 0)

                parameters.tabs[index].contentView
                    .id(index)
            }
        }


    }
}

struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
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

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

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
