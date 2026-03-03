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
        @Published public var item: TransactionListItemParameters
        @Published public var items: [TransactionListItemParameters]
        @Published public var bottomMessage: String
        @Published public var status: Status
        @Published public var isEnabled: Bool
        
        public init(item: TransactionListItemParameters = .init(),
                    items: [TransactionListItemParameters] = [],
                    bottomMessage: String = "",
                    status: Status = .collapsed,
                    isEnabled: Bool = true) {
            self.item = item
            self.items = items
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
                    OceanSwiftUI.TransactionListItem(parameters: parameters.item) { view in
                        view.parameters.padding = .init(top: Ocean.size.spacingStackXs,
                                                        leading: Ocean.size.spacingStackXs,
                                                        bottom: Ocean.size.spacingStackXs,
                                                        trailing: Ocean.size.spacingStackXxsExtra)
                        view.parameters.onTouch = {
                            toggleStatus()
                        }
                    }
                    
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
                        ForEach(parameters.items.indices, id: \.self) { index in
                            OceanSwiftUI.TransactionListItem(parameters: parameters.items[index]) { view in
                                view.parameters.iconColor = Ocean.color.colorInterfaceLightDown
                                view.parameters.iconLineTop = index != 0
                                view.parameters.iconLineBottom = index != parameters.items.count - 1
                                view.parameters.padding = .init(top: Ocean.size.spacingStackXxsExtra,
                                                                leading: Ocean.size.spacingStackXs,
                                                                bottom: Ocean.size.spacingStackXxsExtra,
                                                                trailing: Ocean.size.spacingStackXxs)
                            }
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
                    .padding(.bottom, Ocean.size.spacingStackXxs)
                }
                
                
                OceanSwiftUI.Divider()
            }
        }
        
        private func toggleStatus() {
            parameters.status = parameters.status == .collapsed ? .expanded : .collapsed
            withAnimation(.linear(duration: animationDuration)) {
                rotation = parameters.status == .collapsed ? 0 : -180
            }
        }
    }
}
