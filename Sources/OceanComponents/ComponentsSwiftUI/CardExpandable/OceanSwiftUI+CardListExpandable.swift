//
//  OceanSwiftUI+CardListExpandable.swift
//  OceanDesignSystem
//
//  Created by Celso Farias on 24/09/25.
//

import OceanTokens
import SwiftUI

extension OceanSwiftUI {

    // MARK: Parameter

    public class CardListExpandableParameters: ObservableObject {
        @Published public var contentList: OceanSwiftUI.ContentListParameters
        @Published public var backgroundColor: UIColor
        @Published public var cornerRadius: CGFloat
        @Published public var borderColor: UIColor
        @Published public var borderWidth: CGFloat
        @Published public var padding: EdgeInsets
        @Published public var paddingContent: EdgeInsets
        @Published public var status: Status
        @Published public var showChevron: Bool
        @Published public var content: () -> any View

        public enum Status {
            case expanded, collapsed
        }

        public init(contentList: OceanSwiftUI.ContentListParameters = OceanSwiftUI.ContentListParameters(),
                    backgroundColor: UIColor = Ocean.color.colorInterfaceLightPure,
                    cornerRadius: CGFloat = Ocean.size.borderRadiusSm,
                    borderColor: UIColor = Ocean.color.colorInterfaceLightDown,
                    borderWidth: CGFloat = Ocean.size.borderWidthHairline,
                    padding: EdgeInsets = .all(0),
                    paddingContent: EdgeInsets = .all(0),
                    status: Status = .collapsed,
                    showChevron: Bool = true,
                    content: @escaping () -> any View = { return EmptyView() } ) {
            self.contentList = contentList
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.padding = padding
            self.paddingContent = paddingContent
            self.status = status
            self.showChevron = showChevron
            self.content = content
        }
    }

    public struct CardListExpandable: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardListExpandable) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardListExpandableParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: CardListExpandableParameters = CardListExpandableParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: 0) {
                HStack {
                    ContentList(parameters: parameters.contentList)

                    Spacer()

                    if parameters.showChevron {
                        Spacer().frame(width: Ocean.size.spacingStackXs)
                        Image(uiImage: Ocean.icon.chevronDownSolid!)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 16, height: 16, alignment: .center)
                            .rotationEffect(Angle(degrees: self.parameters.status == .expanded ? -180.0 : 0.0))
                            .animation(.easeInOut, value: parameters.status)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                    }
                }
                .padding(.trailing, Ocean.size.spacingStackXs)

                if parameters.status == .expanded {
                    VStack(spacing: 0) {
                        AnyView(parameters.content())
                            .padding(parameters.paddingContent)
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                }
            }
            .background(Color(parameters.backgroundColor))
            .border(cornerRadius: parameters.cornerRadius,
                    width: parameters.borderWidth,
                    color: parameters.borderColor)
            .padding(parameters.padding)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if parameters.status == .collapsed {
                        parameters.status = .expanded
                    } else {
                        parameters.status = .collapsed
                    }
                }
            }
        }
    }
}
