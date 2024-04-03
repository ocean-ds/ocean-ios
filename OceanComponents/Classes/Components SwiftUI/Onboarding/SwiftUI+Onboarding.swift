//
//  SwiftUI+Onboarding.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 01/04/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class OnboardingParameters: ObservableObject {
        @Published public var pages: [PageModel] = []
        @Published public var titleButton: String = ""
        @Published public var titleButtonLastPage: String = ""
        @Published public var actionLastPage: () -> Void

        public init(pages: [PageModel] = [],
                    titleButton: String = "Avançar",
                    titleButtonLastPage: String = "Entendi",
                    actionLastPage: @escaping () -> Void = { }) {
            self.pages = pages
            self.titleButton = titleButton
            self.titleButtonLastPage = titleButtonLastPage
            self.actionLastPage = actionLastPage
        }

        public class PageModel: ObservableObject, Identifiable {
            @Published public var image: UIImage?
            @Published public var title: String
            @Published public var subtitle: String
            @Published public var linkText: String
            @Published public var linkAction: (() -> Void)?

            public init(image: UIImage? = nil,
                        title: String = "",
                        subtitle: String = "",
                        linkText: String = "",
                        linkAction: (() -> Void)? = nil) {
                self.image = image
                self.title = title
                self.subtitle = subtitle
                self.linkText = linkText
                self.linkAction = linkAction
            }
        }
    }

    public struct Onboarding: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Onboarding) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: OnboardingParameters

        // MARK: Properties private

        @State private var currentPageIndex: Int = 0
        @State private var pagesOffset: [Int] = []
        @State private var contentOffset: CGPoint = .zero
        @State private var isGrowing: Bool = true
        @State private var debounce: Timer?
        @State private var shouldHandleScroll: Bool = false

        // MARK: Constructors

        public init(parameters: OnboardingParameters = OnboardingParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                Text("\(contentOffset.x)")
                GeometryReader { geometry in
                    if #available(iOS 14.0, *) {
                        ScrollViewReader { scrollViewReader in
                            OffsetObservingScrollView(axes: .horizontal, showsIndicators: false, offset: $contentOffset, isGrowing: $isGrowing) { coordinateSpace in
                                HStack {
                                    ForEach(0..<self.parameters.pages.count, id: \.self) { index in
                                        Page(page: self.parameters.pages[index])
                                            .frame(width: geometry.size.width)
                                            .id(index)
                                            .background(
                                                GeometryReader { geometryReader in
                                                    Color.green
                                                        .onAppear {
                                                            let value = Int(geometryReader.frame(in: coordinateSpace).minX)
                                                            pagesOffset.append(value)
                                                            pagesOffset.sort { $0 <= $1 }
                                                        }
                                                }
                                            )
                                    }
                                }
                            }
                            .onChange(of: currentPageIndex) { offset in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    scrollViewReader.scrollTo(currentPageIndex, anchor: .leading)
                                }
                            }
                            .onChange(of: contentOffset) { offset in
                                updateSection()
//                                if shouldHandleScroll {
//                                    updateSection()
//                                } else {
//                                    debounce?.invalidate()
//                                    debounce = Timer.scheduledTimer(withTimeInterval: 0.16,
//                                                                    repeats: false) { _ in
//                                        shouldHandleScroll = true
//                                    }
//                                }
                            }
                        }

                    } else {
                        OffsetObservingScrollView(axes: .horizontal, showsIndicators: false, offset: $contentOffset, isGrowing: $isGrowing) { _ in
                            HStack {
                                ForEach(0..<self.parameters.pages.count, id: \.self) { index in
                                    Page(page: self.parameters.pages[index])
                                        .frame(width: geometry.size.width)
                                        .background(Color.green)
                                }
                            }
                        }
                    }
                }

                PageIndicator(numberOfPages: self.parameters.pages.count, currentPage: CGFloat(currentPageIndex))

                Button.primaryMD { button in
                    button.parameters.text = self.currentPageIndex == self.parameters.pages.count - 1
                    ? self.parameters.titleButtonLastPage
                    : self.parameters.titleButton
                    button.parameters.onTouch = nextPage
                }
            }
        }

        // MARK: Methods private

        private func nextPage() {
            shouldHandleScroll = false
            if self.currentPageIndex == self.parameters.pages.count - 1 {
                self.parameters.actionLastPage()
            } else {
                self.currentPageIndex += 1
            }
        }

        private func updateSection() {
            let pageWidth = UIScreen.main.bounds.width
            let threshold = pageWidth * 0.3

            let nextPageIndex: Int

            if isGrowing {
                nextPageIndex = Int((contentOffset.x + threshold) / pageWidth)
            } else {
                nextPageIndex = Int((contentOffset.x - threshold) / pageWidth)
            }

            if nextPageIndex >= 0 && nextPageIndex < parameters.pages.count {
                currentPageIndex = nextPageIndex
            }

            print("QWERT ----------------------------------")
            print("QWERT - pageWidth: \(pageWidth)")
            print("QWERT - threshold: \(threshold)")
            print("QWERT - isGrowing: \(isGrowing)")
            print("QWERT - nextPageIndex: \(nextPageIndex)")
            print("QWERT - currentPageIndex: \(currentPageIndex)")
        }
    }

    public struct PageIndicator: View {
        public var numberOfPages: Int
        public var currentPage: CGFloat = 0
        public var currentPageIndicatorColor: Color = Color.blue
        public var pageIndicatorColor: Color = Color.gray

        var indicatorSize: CGSize = CGSize(width: 6, height: 6)
        var selectedIndicatorSize: CGSize = CGSize(width: 12, height: 6)

        public var body: some View {
            HStack(spacing: 8) {
                ForEach(0..<numberOfPages, id: \.self) { index in
                    Rectangle()
                        .cornerRadius(50)
                        .foregroundColor(index == Int(self.currentPage)
                                         ? self.currentPageIndicatorColor
                                         : self.pageIndicatorColor)
                        .frame(width: index == Int(self.currentPage)
                               ? self.selectedIndicatorSize.width
                               : self.indicatorSize.width,
                               height: index == Int(self.currentPage)
                               ? self.selectedIndicatorSize.height
                               : self.indicatorSize.height)
                        .animation(.default)
                }
            }
            .frame(height: indicatorSize.height)
        }
    }

    public struct Page: View {
        @ObservedObject public var page: OnboardingParameters.PageModel

        public var body: some View {
            VStack(alignment: .center) {

                Spacer()

                if let image = page.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 140,
                               height: 140,
                               alignment: .center)
                    Spacer()
                        .frame(height: Ocean.size.spacingStackSm)
                }

                if !page.title.isEmpty {
                    Typography.heading3 { label in
                        label.parameters.text = page.title
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }

                if !page.subtitle.isEmpty {
                    Typography.description { label in
                        label.parameters.text = page.subtitle
                    }

                    Spacer()
                        .frame(height: Ocean.size.spacingStackXs)
                }

                if !page.linkText.isEmpty {
                    Link.primaryMedium { link in
                        link.parameters.text = page.linkText
                        link.parameters.onTouch = page.linkAction ?? { }
                    }
                }

                Spacer()
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
    var axes: Axis.Set = [.horizontal]
    var showsIndicators = true
    @Binding var offset: CGPoint {
        didSet {
            if axes == .horizontal {
                isGrowing = offset.x > oldValue.x
            }
            if axes == .vertical {
                isGrowing = offset.y > oldValue.y
            }
        }
    }
    @Binding var isGrowing: Bool
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
