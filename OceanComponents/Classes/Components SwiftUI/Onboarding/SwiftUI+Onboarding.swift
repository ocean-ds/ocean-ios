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
            @Published public var backgroundColor: UIColor
            @Published public var linkText: String
            @Published public var linkAction: (() -> Void)?

            public init(image: UIImage? = nil,
                        title: String = "",
                        subtitle: String = "",
                        backgroundColor: UIColor = .white,
                        linkText: String = "",
                        linkAction: (() -> Void)? = nil) {
                self.image = image
                self.title = title
                self.subtitle = subtitle
                self.backgroundColor = backgroundColor
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

        @State private var screenWidth: CGFloat = 0
        @State private var currentPage: Int = 0
        @GestureState private var dragOffset: CGSize = .zero

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
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(0..<self.parameters.pages.count, id: \.self) { index in
                        Page(page: self.parameters.pages[index])
                            .frame(width: geometry.size.width)
                            .background(Color(parameters.pages[index].backgroundColor))
                    }
                }
                .offset(x: -CGFloat(currentPage) * geometry.size.width + dragOffset.width)
                .onAppear {
                    screenWidth = geometry.size.width
                }
                .animation(.default)

            }
            .gesture(DragGesture()
                .updating(self.$dragOffset) { value, dragOffset, _ in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    let threshold = screenWidth * 0.2
                    if value.translation.width < -threshold && self.currentPage < parameters.pages.count - 1 {
                        self.currentPage += 1
                    } else if value.translation.width > threshold && self.currentPage > 0 {
                        self.currentPage -= 1
                    }
                })

            PageIndicator(numberOfPages: parameters.pages.count, currentPage: CGFloat(currentPage))

            Button.primaryMD { button in
                button.parameters.text = currentPage == parameters.pages.count - 1
                    ? parameters.titleButtonLastPage
                    : parameters.titleButton
                button.parameters.onTouch = nextPage
            }
        }

        // MARK: Methods private

        private func nextPage() {
            if currentPage == parameters.pages.count - 1 {
                parameters.actionLastPage()
            } else {
                if currentPage < parameters.pages.count - 1 {
                    currentPage += 1
                }
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
}
