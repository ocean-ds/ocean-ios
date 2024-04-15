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
        @Published public var title: String
        @Published public var value: Double?
        @Published public var item1Title: String
        @Published public var item1Value: Double
        @Published public var item2Title: String
        @Published public var item2Value: Double
        @Published public var description: String
        @Published public var actionCTA: String
        @Published public var actionCTACollapsed: String
        @Published public var action: (() -> Void)?
        @Published public var cellType: BalanceCellType

        weak public var rootViewController: UIViewController?

        public init(
            title: String = "",
            value: Double? = nil,
            item1Title: String = "",
            item1Value: Double = 0.0,
            item2Title: String = "",
            item2Value: Double = 0.0,
            description: String = "",
            actionCTA: String = "",
            actionCTACollapsed: String = "",
            action: (() -> Void)? = nil,
            cellType: BalanceCellType = .withValue,
            rootViewController: UIViewController? = nil
        ) {
            self.title = title
            self.value = value
            self.item1Title = item1Title
            self.item1Value = item1Value
            self.item2Title = item2Title
            self.item2Value = item2Value
            self.description = description
            self.actionCTA = actionCTA
            self.actionCTACollapsed = actionCTACollapsed
            self.action = action
            self.cellType = cellType
            self.rootViewController = rootViewController
        }

        public enum BalanceState {
            case expanded, collapsed, scroll
        }

        public enum BalanceCellType {
            case withValue, withoutValue
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

        @State private var isVisibility: Bool = true

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
            VStack {
                balanceBluView
                    .background(Color(Ocean.color.colorBrandPrimaryDown.withAlphaComponent(0.4)))
                    .cornerRadius(Ocean.size.borderRadiusMd)
                    .frame(height: 230)

                PageIndicator { pageIndicator in
                    pageIndicator.parameters.numberOfPages = 2
                    pageIndicator.parameters.currentPage = 0
                    pageIndicator.parameters.pageIndicatorColor = Ocean.color.colorBrandPrimaryDown
                    pageIndicator.parameters.currentPageIndicatorColor = Ocean.color.colorInterfaceLightPure
                }
            }
        }

        @ViewBuilder
        private var balanceBluView: some View {
            VStack(alignment: .leading) {
                HStack {
                    //olho aberto/fechado
                    eyesIconView

                    VStack(alignment: .leading) {
                        //saldo total na blu
                        Typography { label in
                            label.parameters.text = parameters.title
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxxs)
                            label.parameters.textColor = Ocean.color.colorBrandPrimaryUp
                        }

                        //saldo
                        Typography { label in
                            label.parameters.text = isVisibility
                                ? parameters.value?.toCurrency() ?? ""
                                : "R$ ••••••"
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeSm)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                    }

                    Spacer()

                    //icone chevron para baixo
                    Image(uiImage: Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16, alignment: .center)
                        .foregroundColor(Color(Ocean.color.colorInterfaceLightPure))
                    // ajustar animacao
                    //                        .foregroundColor(Color(item.status == .collapsed ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown))
                    //                        .rotation3DEffect(
                    //                            Angle(degrees: item.status == .collapsed ? 0 : 180),
                    //                            axis: (x: 1, y: 0, z: 0)
                    //                        )
                }

                // if expansive
                Group {
                    HStack {
                        // saldo atual
                        Typography { label in
                            label.parameters.text = parameters.item1Title
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }

                        Spacer()

                        // R$ 50,00
                        Typography { label in
                            label.parameters.text = isVisibility
                                ? parameters.item1Value.toCurrency() ?? ""
                                : "R$ ••••••"
                            label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                    }

                    // diveder
                    Divider { divider in
                        divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                    }
                    .padding(.vertical, Ocean.size.spacingStackXxs)

                    HStack {
                        // Agenda
                        Typography { label in
                            label.parameters.text = parameters.item2Title
                            label.parameters.font = .baseBold(size: Ocean.font.fontSizeXxs)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }

                        Spacer()

                        // R$ 50,00
                        Typography { label in
                            label.parameters.text = isVisibility
                                ? parameters.item2Value.toCurrency() ?? ""
                                : "R$ ••••••"
                            label.parameters.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                            label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                        }
                    }
                    //fim do if expansive
                }

                Divider { divider in
                    divider.parameters.color = Ocean.color.colorBrandPrimaryUp.withAlphaComponent(0.4)
                }
                .padding(.vertical, Ocean.size.spacingStackXxs)

                HStack {
                    //description
                    Typography.description { label in
                        label.parameters.text = parameters.description
                        label.parameters.textColor = Ocean.color.colorInterfaceLightDown
                    }
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    //small secondary button
                    Button.secondarySM { button in
                        button.parameters.text = parameters.actionCTA
                    }
                    .frame(maxWidth: 100)
                }
            }
            .padding(Ocean.size.spacingStackXs)

            // if scroll
            // nao possui margim (view encosta nas laterais)
            //            HStack {
            //                //olho aberto/fechado
            //                VStack {
            //                    //description
            //                    //saldo
            //                }
            //                //icone chevron para baixo
            //            }
        }

        @ViewBuilder
        private var balanceOthersAcquirersView: some View {
            VStack(alignment: .leading) {
                // caption
                // description
                // small button secondary
            }
        }

        @ViewBuilder
        private var eyesIconView: some View {
            Image(uiImage: isVisibility
                  ? Ocean.icon.eyeOutline?.withRenderingMode(.alwaysTemplate)
                  : Ocean.icon.eyeOffOutline?.withRenderingMode(.alwaysTemplate))
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(Color(Ocean.color.colorBrandPrimaryUp))
                .padding(.trailing, 16)
                .onTapGesture {
                    isVisibility.toggle()
                }
        }
    }
}

struct HorizontalScrollView<Content: View>: View {
    let content: [Content]
    @State private var currentPage = 0
    @GestureState private var dragOffset = CGSize.zero
    @State private var screenWidth: CGFloat = 0

    init(@ViewBuilder content: () -> [Content]) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(content.indices, id: \.self) { index in
                    content[index]
                        .frame(width: geometry.size.width)
                }
            }
            .offset(x: -CGFloat(currentPage) * geometry.size.width + dragOffset.width)
            .onAppear {
                screenWidth = geometry.size.width
            }
            .animation(.default)
        }
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, dragOffset, _ in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    let threshold = screenWidth * 0.2
                    if value.translation.width < -threshold && currentPage < content.count - 1 {
                        currentPage += 1
                    } else if value.translation.width > threshold && currentPage > 0 {
                        currentPage -= 1
                    }
                }
        )
    }
}
