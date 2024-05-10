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
        @Published private(set) public var tabSelectedIndex: Int = 0
        @Published public var contentIdealHeight: CGFloat? = nil
        public var onTouch: ((Int) -> Void)

        public init(tabs: [TabModel] = [],
                    tabSelectedIndex: Int = 0,
                    contentIdealHeight: CGFloat? = nil,
                    onTouch: @escaping ((Int) -> Void) = { _ in }) {
            self.tabs = tabs
            self.tabSelectedIndex = tabSelectedIndex
            self.contentIdealHeight = contentIdealHeight
            self.onTouch = onTouch
        }

        public func setSelectedIndex(_ index: Int) {
            guard tabs.indices.contains(index) else { return }
            tabSelectedIndex = index
        }

        public func updateTab(tab: TabModel, index: Int) {
            guard tabs.indices.contains(index) else { return }
            tabs[index] = tab
        }

        fileprivate func selectTab(tab: TabModel, index: Int) {
            tabSelectedIndex = index
            onTouch(tabSelectedIndex)
        }
    }

    public class TabModel: ObservableObject, Identifiable {
        @Published public var title: String
        @Published public var view: any View
        @Published public var badgeNumber: Int?
        @Published public var badgeStatus: OceanSwiftUI.BadgeParameters.Status

        public init(title: String = "",
                    view: any View = EmptyView(),
                    badgeNumber: Int? = nil,
                    badgeStatus: OceanSwiftUI.BadgeParameters.Status = .primary) {
            self.title = title
            self.view = view
            self.badgeNumber = badgeNumber
            self.badgeStatus = badgeStatus
        }

        public var contentView: AnyView {
            AnyView(view)
        }
    }

    public struct Tab: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Tab) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: TabParameters

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
                HStack {
                    ForEach(0..<self.parameters.tabs.count, id: \.self) { index in
                        getTab(self.parameters.tabs[index], index: index)
                    }
                }

                Divider()

                getContent()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, idealHeight: self.parameters.contentIdealHeight, maxHeight: .infinity)
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getTab(_ tab: TabModel, index: Int) -> some View {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    OceanSwiftUI.Typography.heading4 { view in
                        view.parameters.text = tab.title
                        view.parameters.lineLimit = 2
                        view.parameters.multilineTextAlignment = .center
                        view.parameters.textColor = parameters.tabSelectedIndex == index ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkUp
                    }
                    if let badgeNumber = tab.badgeNumber {
                        OceanSwiftUI.Badge { badge in
                            badge.parameters.count = badgeNumber
                            badge.parameters.status = parameters.tabSelectedIndex == index ? tab.badgeStatus : .disabled
                            badge.parameters.size = .small
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .frame(height: 60)
            .overlay(parameters.tabSelectedIndex == index
                     ? Color(Ocean.color.colorBrandPrimaryPure).frame(height: 2)
                     : Color.clear.frame(height: 2),
                     alignment: .bottom)
            .animation(.default, value: parameters.tabSelectedIndex)
            .onTapGesture { parameters.selectTab(tab: tab, index: index) }
        }

        
        private func getContent() -> some View {
            Group {
                if let tab = parameters.tabs[safe: parameters.tabSelectedIndex] {
                    tab.contentView
                }
            }
        }
    }
}
