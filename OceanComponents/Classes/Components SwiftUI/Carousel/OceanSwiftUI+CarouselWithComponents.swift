//
//  OceanSwiftUI+CarouselWithComponents.swift
//  Pods
//
//  Created by Vinicius Romeiro on 17/12/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class CarouselWithComponentsParameters<Content>: ObservableObject where Content: View {
        @Published public var items: [Content]
        @Published public var showSkeleton: Bool
        
        public init(items: [Content] = [],
                    showSkeleton: Bool = false) {
            self.items = items
            self.showSkeleton = showSkeleton
        }
    }
    
    public struct CarouselWithComponents<Content>: View where Content: View {
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (CarouselWithComponents) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: CarouselWithComponentsParameters<Content>
        
        // MARK: Properties private
        
        @State private var screenWidth: CGFloat = 0
        @State private var currentPage: Int = 0
        
        // MARK: Constructors
        
        public init(parameters: CarouselWithComponentsParameters<Content> = CarouselWithComponentsParameters<Content>()) {
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
                    skeleton.parameters.height = 140
                    skeleton.parameters.radius = Ocean.size.borderRadiusMd
                    skeleton.parameters.lines = 1
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
            } else {
                VStack(spacing: Ocean.size.spacingStackSm) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(0..<self.parameters.items.count, id: \.self) { index in
                                self.parameters.items[index]
                                    .padding(.horizontal, Ocean.size.spacingStackXxs)
                                    .frame(width: screenWidth)
                            }
                        }
                        .padding(.horizontal, self.parameters.items.count > 1 ?
                                 Ocean.size.spacingStackXs : Ocean.size.spacingStackXxs)
                        .onAppear {
                            let spacing = self.parameters.items.count > 1 ?
                                (Ocean.size.spacingStackXs * 2) : Ocean.size.spacingStackXs
                            screenWidth = UIScreen.main.bounds.width - spacing
                        }
                    }
                    .animation(.none)
                    .simultaneousGesture(
                        DragGesture()
                            .onEnded { value in
                                let threshold = screenWidth * 0.2
                                if value.translation.width < -threshold && self.currentPage < parameters.items.count - 1 {
                                    self.currentPage += 1
                                } else if value.translation.width > threshold && self.currentPage > 0 {
                                    self.currentPage -= 1
                                }
                            }
                    )
                    
                    if self.parameters.items.count > 1 {
                        OceanSwiftUI.PageIndicator { pageIndicator in
                            pageIndicator.parameters.currentPage = self.currentPage
                            pageIndicator.parameters.numberOfPages = self.parameters.items.count
                            pageIndicator.parameters.showAnimation = false
                        }
                    }
                }
            }
        }
        
        // MARK: Methods private
    }
}
