//
//  OceanSwiftUI+Tab.swift
//  Charts
//
//  Created by Acassio Mendonça on 15/01/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class TabParameters: ObservableObject {
        @Published public var tabs: [TabModel]
        public var onTouch: ((Int) -> Void)

        public var selectedIndex: Int {
            tabs.firstIndex(where: { $0.isSelected }) ?? -1
        }

        public init(tabs: [TabModel] = [],
                    onTouch: @escaping ((Int) -> Void) = { _ in }) {
            self.tabs = tabs
            self.onTouch = onTouch
        }

        public func selectTab(at index: Int) {
            tabs.indices.forEach { tabs[$0].isSelected = $0 == index }
        }
    }

    public class TabModel: ObservableObject, Identifiable {
        public let title: String
        public var view: any View
        @Published public var isSelected: Bool
        public let badgeNumber: Int?
        public var badgeStatus: OceanSwiftUI.BadgeParameters.Status

        public init(title: String,
                    view: any View = AnyView(EmptyView()),
                    isSelected: Bool,
                    badgeNumber: Int? = nil,
                    badgeStatus: OceanSwiftUI.BadgeParameters.Status = .primary) {
            self.title = title
            self.view = view
            self.isSelected = isSelected
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
        }

        fileprivate var anyView: AnyView {
            AnyView(view)
        }
    }

    public struct TabBar: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (TabBar) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TabParameters
        @State private var tabSelected: Int = 0

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: TabParameters = TabParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                VStack {
                    HStack {
                        ForEach(0..<self.parameters.tabs.count) { index in
                            VStack {
                                Tab(item: parameters.tabs[index])
                                    .onTapGesture {
                                        parameters.onTouch(index)
                                        parameters.selectTab(at: index)
                                        tabSelected = index
                                    }
                            }
                        }
                    }
                    Divider()
                }
                .frame(maxWidth: .infinity, idealHeight: 60)

//                AnyView(parameters.tabs[tabSelected].anyView)
                AnyView(parameters.tabs[tabSelected].anyView)
            }
        }


        // MARK: Methods private
    }

    public struct Tab: View {
        @ObservedObject public var item: TabModel

        public var body: some View {
            Group {
                VStack {
                    Spacer()
                    HStack {
                        HStack {
                            Spacer()
                            OceanSwiftUI.Typography.heading4 { view in
                                view.parameters.text = item.title
                                view.parameters.lineLimit = 0
                                view.parameters.textColor = item.isSelected ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkUp
                            }
                            if let badgeNumber = item.badgeNumber {
                                OceanSwiftUI.Badge { badge in
                                    badge.parameters.count = badgeNumber
                                    badge.parameters.status = item.isSelected ? item.badgeStatus : .disabled
                                    badge.parameters.size = .small
                                }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    if item.isSelected {
                        Color(Ocean.color.colorBrandPrimaryPure)
                            .frame(height: 2)
                    } else {
                        Color.clear.frame(height: 2)
                    }
                }
            }
            .animation(.default, value: item.isSelected)
        }
    }
}
