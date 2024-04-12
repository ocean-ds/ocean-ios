//
//  OceanSwiftUI+Balance.swift
//  DGCharts
//
//  Created by Acassio Mendonça on 12/04/24.
//

import SwiftUI
import OceanTokens
import SkeletonUI

extension OceanSwiftUI {
    // MARK: Parameters

    public class BalanceParameters: ObservableObject {

        @Published public var groups: [FilterBarGroup]
        @Published public var marginLeft: CGFloat = Ocean.size.spacingStackXs
        @Published public var marginRight: CGFloat = Ocean.size.spacingStackXs
        @Published public var showSkeleton: Bool
        @Published public var onTouch: (([Ocean.ChipModel], FilterBarOption) -> Bool)
        @Published public var onSelectionChange: (([Ocean.ChipModel], [FilterBarGroup]) -> Void)

        weak public var rootViewController: UIViewController?

        public var options: [OceanSwiftUI.FilterBarOption] {
            get {
                groups.flatMap { $0.options }
            }
            set {
                groups = [.init(options: newValue)]
            }
        }

        public init(groups: [FilterBarGroup] = [],
                    showSkeleton: Bool = false,
                    onTouch: @escaping ([Ocean.ChipModel], FilterBarOption) -> Bool = { _, _ in return false },
                    onSelectionChange: @escaping ([Ocean.ChipModel], [FilterBarGroup]) -> Void = { _, _ in }) {
            self.groups = groups
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
            self.onSelectionChange = onSelectionChange
        }
    }

    public struct Balance: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Balance) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BalanceParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: BalanceParameters = BalanceParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            ScrollView(.horizontal) {

            }
        }
    }
}

