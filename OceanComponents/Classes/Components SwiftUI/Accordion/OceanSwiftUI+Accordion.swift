//
//  OceanSwiftUI+Accordion.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 21/12/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class AccordionParameters: ObservableObject {
        @Published public var items: [Item]
        @Published public var onUpdateUI: () -> Void

        public init(items: [Item] = [],
                    onUpdateUI: @escaping () -> Void = { }) {
            self.items = items
            self.onUpdateUI = onUpdateUI
        }

        public class Item: ObservableObject, Identifiable {
            @Published public var title: String
            @Published public var text: String
            @Published public var hasDivider: Bool
            @Published public var status: Status

            public enum Status {
                case expanded, collapsed
            }

            public init(title: String = "",
                        text: String = "",
                        hasDivider: Bool = true,
                        status: Status = .collapsed) {
                self.title = title
                self.text = text
                self.hasDivider = hasDivider
                self.status = status
            }
        }
    }

    public struct Accordion: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Accordion) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: AccordionParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: AccordionParameters = AccordionParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                ForEach(self.parameters.items) { item in
                    Row(item: item, onUpdateUI: self.parameters.onUpdateUI)
                }
            }
        }

        // MARK: Methods private
    }

    public struct Row: View {
        @ObservedObject public var item: AccordionParameters.Item
        public var onUpdateUI: () -> Void

        public var body: some View {
            VStack {
                HStack {
                    OceanSwiftUI.Typography.heading5 { label in
                        label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                        label.parameters.textColor = item.status == .collapsed ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown
                        label.parameters.text = item.title
                    }
                    Spacer()
                    Spacer().frame(width: Ocean.size.spacingStackXs)
                    Image(uiImage: Ocean.icon.chevronDownSolid!)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color(item.status == .collapsed ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown))
                        .rotation3DEffect(
                            Angle(degrees: item.status == .collapsed ? 0 : 180),
                            axis: (x: 1, y: 0, z: 0)
                        )
                }
                .padding(.vertical, Ocean.size.spacingStackXs)
                .onTapGesture {
                    if item.status == .collapsed {
                        item.status = .expanded
                    } else {
                        item.status = .collapsed
                    }
                    self.onUpdateUI()
                }

                if item.status == .expanded {
                    VStack {
                        OceanSwiftUI.Typography.caption { label in
                            label.parameters.text = item.text
                        }
                        Spacer().frame(width: Ocean.size.spacingStackXs)
                    }
                }

                if item.hasDivider {
                    OceanSwiftUI.Divider()
                }
            }
        }
    }
}
