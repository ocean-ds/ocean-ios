//
//  OceanSwiftUI+Carousel.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 09/05/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class CarouselParameters: ObservableObject {
        @Published public var items: [CarouselModel]
        @Published public var showSkeleton: Bool
        public var onTouch: (CarouselModel, Int) -> Void = { _, _ in }

        public init(items: [CarouselModel] = [],
                    showSkeleton: Bool = false,
                    onTouch: @escaping (CarouselModel, Int) -> Void = { _, _ in }) {
            self.items = items
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
    }

    public class CarouselModel: ObservableObject, Identifiable {
        @Published public var image: UIImage?
        @Published public var url: String?

        public init(image: UIImage? = nil,
                    url: String? = nil) {
            self.image = image
            self.url = url
        }
    }

    public struct Carousel: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Carousel) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CarouselParameters

        // MARK: Properties private
        
        private var animationTime = 0.3

        @State private var screenWidth: CGFloat = 0
        @State private var currentPage: Int = 0
        @State private var enableAnimation = false
        @GestureState private var dragOffset: CGSize = .zero

        // MARK: Constructors

        public init(parameters: CarouselParameters = CarouselParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if self.parameters.showSkeleton {
                OceanSwiftUI.Skeleton { skeleton in
                    skeleton.parameters.height = 168
                    skeleton.parameters.radius = Ocean.size.borderRadiusMd
                    skeleton.parameters.lines = 1
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
            } else {
                VStack(spacing: Ocean.size.spacingStackXs) {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            ForEach(0..<self.parameters.items.count, id: \.self) { index in
                                self.getItem(self.parameters.items[index], index: index)
                                    .padding(.horizontal, Ocean.size.spacingStackXxs)
                                    .frame(width: screenWidth)
                            }
                        }
                        .offset(x: -CGFloat(currentPage) * screenWidth + dragOffset.width)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                        .onAppear {
                            screenWidth = geometry.size.width - (Ocean.size.spacingStackXs * 2)
                        }
                        .animation(enableAnimation ? .linear(duration: animationTime) : .none)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, idealHeight: 168, maxHeight: .infinity)
                    .gesture(
                        DragGesture()
                            .updating(self.$dragOffset) { value, dragOffset, _ in
                                enableAnimation = true
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                let threshold = screenWidth * 0.2
                                if value.translation.width < -threshold && self.currentPage < parameters.items.count - 1 {
                                    self.currentPage += 1
                                } else if value.translation.width > threshold && self.currentPage > 0 {
                                    self.currentPage -= 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) {
                                    enableAnimation = false
                                }
                            })

                    if self.parameters.items.count > 1 {
                        OceanSwiftUI.PageIndicator { pageIndicator in
                            pageIndicator.parameters.currentPage = self.currentPage
                            pageIndicator.parameters.numberOfPages = self.parameters.items.count
                        }
                    }
                }
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getItem(_ item: CarouselModel, index: Int) -> some View {
            VStack(spacing: 0) {
                if let url = item.url {
                    OceanSwiftUI.ImageDownload(parameters: .init(url: url))
                } else {
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
            .clipped()
            .cornerRadius(Ocean.size.borderRadiusMd, corners: .allCorners)
            .onTapGesture {
                self.parameters.onTouch(item, index)
            }
        }
    }
}
