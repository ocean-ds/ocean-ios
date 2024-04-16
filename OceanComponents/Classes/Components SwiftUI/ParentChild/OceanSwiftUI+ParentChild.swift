//
//  OceanSwiftUI+ParentChild.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 15/04/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class ParentChildParameters<T>: ObservableObject where T: View {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var items: [T]
        @Published public var padding: EdgeInsets

        public init(title: String = "",
                    subtitle: String = "",
                    items: [T] = [],
                    padding: EdgeInsets = .all(Ocean.size.spacingStackXs)) {
            self.title = title
            self.subtitle = subtitle
            self.items = items
            self.padding = padding
        }
    }

    public struct ParentChild<T>: View where T: View {
        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ParentChild) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ParentChildParameters<T>

        // MARK: Private properties

        @State private var isExpanded: Bool = false

        // MARK: Constructors

        public init(parameters: ParentChildParameters<T> = ParentChildParameters()) {
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
                    VStack(alignment: .leading, spacing: 0) {
                        OceanSwiftUI.Typography.heading4 { view in
                            view.parameters.text = parameters.title
                            view.parameters.lineLimit = 1
                            view.parameters.textColor = Ocean.color.colorInterfaceDarkPure
                        }

                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = parameters.subtitle
                            view.parameters.lineLimit = 1
                            view.parameters.textColor = Ocean.color.colorBrandPrimaryDown
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image(uiImage: Ocean.icon.chevronUpOutline)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)
                        .rotation3DEffect(
                            Angle(degrees: isExpanded ? 0 : 180),
                            axis: (x: 1, y: 0, z: 0)
                        )
                }
                .padding(.all, Ocean.size.spacingInsetSm)

                if isExpanded {
                    OceanSwiftUI.Divider()

                    ForEach(0..<parameters.items.count, id: \.self) { index in
                        parameters.items[index]

                        if index < parameters.items.count - 1 {
                            OceanSwiftUI.Divider()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .border(cornerRadius: Ocean.size.borderRadiusMd,
                    width: 1,
                    color: Ocean.color.colorInterfaceLightDown)
            .padding(parameters.padding)
            .animation(.smooth)
            .onTapGesture {
                isExpanded.toggle()
            }
        }
    }
}
