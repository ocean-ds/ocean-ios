//
//  OceanSwiftUI+TransactionListExpandable.swift
//  Ocean
//
//  Created by Vinicius  Consulmagnos Romeiro on 02/03/26.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    
    // MARK: Parameters
    
    public class TransactionListExpandableParameters: ObservableObject {
        @Published public var parent: TransactionListItemParameters
        @Published public var children: [TransactionListItemParameters]
        @Published public var bottomMessage: String
        @Published public var status: Status
        @Published public var isEnabled: Bool
        
        public init(parent: TransactionListItemParameters = .init(),
                    children: [TransactionListItemParameters] = [],
                    bottomMessage: String = "",
                    status: Status = .collapsed,
                    isEnabled: Bool = true) {
            self.parent = parent
            self.children = children
            self.bottomMessage = bottomMessage
            self.status = status
            self.isEnabled = isEnabled
        }
        
        public enum Status {
            case expanded, collapsed
        }
    }
    
    public struct TransactionListExpandable: View {
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (TransactionListExpandable) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: TransactionListExpandableParameters
        
        // MARK: Private properties
        
        @State private var rotation: Double = 0.0
        
        private let animationDuration: Double = 0.3
        
        // MARK: Constructors
        
        public init(parameters: TransactionListExpandableParameters = TransactionListExpandableParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    getParentTransactionItem()
                    
                    Image(uiImage: Ocean.icon.chevronDownSolid)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        .rotationEffect(.degrees(rotation))
                        .padding(.trailing, Ocean.size.spacingStackXxs)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .contentShape(Rectangle())
                .transform(condition: parameters.isEnabled, transform: { view in
                    view.onTapGesture {
                        toggleStatus()
                    }
                })
                .animation(.easeInOut(duration: animationDuration), value: parameters.status)
                
                if parameters.status == .expanded {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(parameters.children.indices, id: \.self) { index in
                            getChildTransactionItem(for: parameters.children[index], index: index)
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            Spacer()
                            
                            OceanSwiftUI.Typography.captionBold { label in
                                label.parameters.text = parameters.bottomMessage
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.multilineTextAlignment = .center
                            }
                            
                            Spacer()
                        }
                        .padding(.top, Ocean.size.spacingStackXxxs)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                        .padding(.bottom, Ocean.size.spacingStackSm)
                        .hideIfEmpty(parameters.bottomMessage)
                    }
                }
                
                OceanSwiftUI.Divider()
            }
        }
        
        @ViewBuilder
        public func getParentTransactionItem() -> OceanSwiftUI.TransactionListItem {
            let item = parameters.parent
            item.padding = .init(top: Ocean.size.spacingStackXs,
                                 leading: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXs,
                                 trailing: Ocean.size.spacingStackXxsExtra)
            item.onTouch = { toggleStatus() }
            return OceanSwiftUI.TransactionListItem(parameters: item)
        }
        
        @ViewBuilder
        private func getChildTransactionItem(for item: TransactionListItemParameters, index: Int) -> OceanSwiftUI.TransactionListItem {
            item.iconColor = Ocean.color.colorInterfaceLightDown
            item.iconLineTop = index != 0
            item.iconLineBottom = index != parameters.children.count - 1
            item.level1Style = .captionBold
            item.level2Style = .description
            item.level3Style = .captionBold
            item.value1Style = .heading5
            item.padding = .init(top: Ocean.size.spacingStackXxsExtra,
                                 leading: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXxsExtra,
                                 trailing: Ocean.size.spacingStackXxs)
            
            return OceanSwiftUI.TransactionListItem(parameters: item)
        }
        
        private func toggleStatus() {
            parameters.status = parameters.status == .collapsed ? .expanded : .collapsed
            withAnimation(.linear(duration: animationDuration)) {
                rotation = parameters.status == .collapsed ? 0 : -180
            }
        }
    }
}
