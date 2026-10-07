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
        @Published public var hasDivider: Bool
        /// Figma structure (MR-615): when set, the row is drawn by the Transaction List family —
        /// icon, Content List, Amount Details and the chevron — and `parent`/`children` are ignored.
        /// `nil` keeps the legacy rendering from `parent`/`children`.
        @Published public var header: TransactionListParameters?
        /// Figma `Slot`: content shown when expanded, usually `TransactionListChildAction`/
        /// `TransactionListChildReadOnly` rows. Used with `header`; `bottomMessage` is the footer.
        @Published public var slot: AnyView?
        
        public var onStatusChange: (Status) -> Void
        
        public init(parent: TransactionListItemParameters = .init(),
                    children: [TransactionListItemParameters] = [],
                    bottomMessage: String = "",
                    status: Status = .collapsed,
                    isEnabled: Bool = true,
                    hasDivider: Bool = true,
                    header: TransactionListParameters? = nil,
                    slot: AnyView? = nil,
                    onStatusChange: @escaping (Status) -> Void = { _ in }) {
            self.parent = parent
            self.children = children
            self.bottomMessage = bottomMessage
            self.status = status
            self.isEnabled = isEnabled
            self.hasDivider = hasDivider
            self.header = header
            self.slot = slot
            self.onStatusChange = onStatusChange
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
            if let header = parameters.header {
                familyBody(header: header)
            } else {
                legacyBody
            }
        }

        // MARK: Figma structure (header + slot)

        private func familyBody(header: TransactionListParameters) -> some View {
            let isEnabled = parameters.isEnabled && header.isEnabled

            return VStack(alignment: .leading, spacing: 0) {
                SwiftUI.Button {
                    toggleStatus()
                } label: {
                    TransactionListRow(parameters: header, showsDivider: false) {
                        TransactionListLeadingIcon(parameters: header)
                    } trailing: {
                        if header.state != .loading {
                            TransactionListActionIcon(image: Ocean.icon.chevronDownSolid,
                                                      isDisabled: !isEnabled)
                                .rotationEffect(.degrees(rotation))
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(TransactionListPressableStyle())
                .disabled(!isEnabled)

                if parameters.status == .expanded && header.state != .loading {
                    VStack(alignment: .leading, spacing: 0) {
                        parameters.slot

                        if !parameters.bottomMessage.isEmpty {
                            OceanSwiftUI.Typography.captionBold { label in
                                label.parameters.text = parameters.bottomMessage
                                label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                                label.parameters.multilineTextAlignment = .center
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, Ocean.size.spacingStackXxxs)
                            .padding(.bottom, Ocean.size.spacingStackSm)
                            .padding(.horizontal, Ocean.size.spacingStackXs)
                        }
                    }
                    .padding(.vertical, Ocean.size.spacingStackXxs)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(Ocean.color.colorInterfaceLightPure))
                }

                if parameters.hasDivider {
                    TransactionListDivider()
                }
            }
            .onAppear {
                rotation = parameters.status == .collapsed ? 0 : -180
            }
        }

        // MARK: Legacy rendering (parent + children)

        private var legacyBody: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    parentTransactionItemContent()
                    
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
                        .padding(.top, Ocean.size.spacingStackXxsExtra)
                        .padding(.horizontal, Ocean.size.spacingStackXs)
                        .padding(.bottom, Ocean.size.spacingStackSm)
                        .hideIfEmpty(parameters.bottomMessage)
                    }
                }
                
                if parameters.hasDivider {
                    OceanSwiftUI.Divider()
                }
            }
        }
        
        @available(*, deprecated, message: "Legacy parent row. Use `header` (Transaction List family) for the Figma structure.")
        public func getParentTransactionItem() -> OceanSwiftUI.TransactionListItem {
            OceanSwiftUI.TransactionListItem(parameters: parentTransactionItemParameters())
        }

        private func parentTransactionItemContent() -> OceanSwiftUI.TransactionListItemContent {
            OceanSwiftUI.TransactionListItemContent(parameters: parentTransactionItemParameters())
        }

        private func parentTransactionItemParameters() -> TransactionListItemParameters {
            let parent = parameters.parent.duplicate()
            parent.padding = .init(top: Ocean.size.spacingStackXs,
                                 leading: Ocean.size.spacingStackXs,
                                 bottom: Ocean.size.spacingStackXs,
                                 trailing: 0)
            parent.hasDivider = false
            parent.onTouch = { toggleStatus() }
            return parent
        }
        
        @ViewBuilder
        private func getChildTransactionItem(for item: TransactionListItemParameters, index: Int) -> OceanSwiftUI.TransactionListItemContent {
            let newItem = item.duplicate()
            newItem.iconColor = Ocean.color.colorInterfaceLightDown
            newItem.iconSize = CGSize(width: 16, height: 16)
            newItem.iconLineTop = index != 0
            newItem.iconLineBottom = index != parameters.children.count - 1
            newItem.level1Style = .captionBold
            newItem.level2Style = .description
            newItem.level3Style = .captionBold
            newItem.value1Style = .heading5
            newItem.hasDivider = false
            newItem.value1Color = newItem.value1Status == .neutral ? Ocean.color.colorInterfaceDarkDown : nil
            newItem.padding = .init(top: Ocean.size.spacingStackXxsExtra,
                                    leading: Ocean.size.spacingStackXs,
                                    bottom: Ocean.size.spacingStackXxsExtra,
                                    trailing: Ocean.size.spacingStackXxs)
            
            return OceanSwiftUI.TransactionListItemContent(parameters: newItem)
        }
        
        private func toggleStatus() {
            parameters.status = parameters.status == .collapsed ? .expanded : .collapsed
            withAnimation(.linear(duration: animationDuration)) {
                rotation = parameters.status == .collapsed ? 0 : -180
                parameters.onStatusChange(parameters.status)
            }
        }
    }
}
