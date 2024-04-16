//
//  OceanSwiftUI+PageIndicator.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 04/04/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    public class PageIndicatorParameters: ObservableObject {
        @Published public var numberOfPages: Int
        @Published public var currentPage: Int
        @Published public var currentPageIndicatorColor: UIColor
        @Published public var pageIndicatorColor: UIColor

        public init(numberOfPages: Int = 0,
                    currentPage: Int = 0,
                    currentPageIndicatorColor: UIColor = Ocean.color.colorBrandPrimaryPure,
                    pageIndicatorColor: UIColor = Ocean.color.colorInterfaceLightDeep) {
            self.numberOfPages = numberOfPages
            self.currentPage = currentPage
            self.currentPageIndicatorColor = currentPageIndicatorColor
            self.pageIndicatorColor = pageIndicatorColor
        }
    }

    public struct PageIndicator: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (PageIndicator) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: PageIndicatorParameters

        private var indicatorSize: CGSize = CGSize(width: 6, height: 6)
        private var selectedIndicatorSize: CGSize = CGSize(width: 12, height: 6)

        // MARK: Constructors

        public init(parameters: PageIndicatorParameters = PageIndicatorParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: 8) {
                ForEach(0..<parameters.numberOfPages, id: \.self) { index in
                    Rectangle()
                        .cornerRadius(50)
                        .foregroundColor(index == Int(parameters.currentPage)
                                         ? Color(parameters.currentPageIndicatorColor)
                                         : Color(parameters.pageIndicatorColor))
                        .frame(width: index == Int(parameters.currentPage)
                               ? selectedIndicatorSize.width
                               : indicatorSize.width,
                               height: index == Int(parameters.currentPage)
                               ? selectedIndicatorSize.height
                               : indicatorSize.height)
                        .animation(.default)
                }
            }
            .frame(height: indicatorSize.height)
        }
    }
}
