//
//  OceanSwiftUI+RadioButtonGroup.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 01/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    
    // MARK: Parameters
    
    public class RadioButtonGroupParameters: ObservableObject {
        @Published public var items: [String]
        @Published public var axis: Axis
        @Published private(set) var itemSelectedIndex: Int?
        @Published public var isEnabled: Bool
        @Published public var hasError: Bool
        @Published public var errorMessage: String {
            didSet {
                hasError = !errorMessage.isEmpty
            }
        }
        public var onTouch: ((Int, String) -> Void)
        
        public init(items: [String] = [],
                    axis: Axis = .vertical,
                    itemSelectedIndex: Int? = nil,
                    isEnabled: Bool = true,
                    hasError: Bool = false,
                    errorMessage: String = "",
                    onTouch: @escaping ((Int, String) -> Void) = { _, _ in }) {
            self.items = items
            self.axis = axis
            self.itemSelectedIndex = itemSelectedIndex
            self.isEnabled = isEnabled
            self.hasError = hasError
            self.errorMessage = errorMessage
            self.onTouch = onTouch
        }
        
        public func setSelectedIndex(_ index: Int) {
            guard items.indices.contains(index) else { return }
            itemSelectedIndex = index
        }
        
        fileprivate func selectItem(item: String, index: Int) {
            errorMessage = ""
            itemSelectedIndex = index
            onTouch(index, item)
        }
    }
    
    public struct RadioButtonGroup: View {
        
        // MARK: Properties for UIKit
        
        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()
        
        // MARK: Builder
        
        public typealias Builder = (RadioButtonGroup) -> Void
        
        // MARK: Properties
        
        @ObservedObject public var parameters: RadioButtonGroupParameters
        
        // MARK: Properties private
        
        // MARK: Constructors
        
        public init(parameters: RadioButtonGroupParameters = RadioButtonGroupParameters()) {
            self.parameters = parameters
        }
        
        public init(builder: Builder) {
            self.init()
            builder(self)
        }
        
        // MARK: View SwiftUI
        
        public var body: some View {
            VStack(alignment: .leading) {
                
                HStack(spacing: 0) {
                    if parameters.axis == .vertical {
                        VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxs) {
                            ForEach(0..<self.parameters.items.count, id: \.self) { index in
                                getItem(self.parameters.items[index], index: index)
                            }
                        }
                    } else {
                        HStack(spacing: Ocean.size.spacingStackXxs) {
                            ForEach(0..<self.parameters.items.count, id: \.self) { index in
                                getItem(self.parameters.items[index], index: index)
                            }
                        }
                    }
                }
                
                if !self.parameters.errorMessage.isEmpty {
                    OceanSwiftUI.Typography.caption { label in
                        label.parameters.text = self.parameters.errorMessage
                        label.parameters.textColor = Ocean.color.colorStatusNegativePure
                    }
                }
            }
        }
        
        // MARK: Methods private
        
        @ViewBuilder
        private func getItem(_ item: String, index: Int) -> some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    Circle()
                        .fill(Color(Ocean.color.colorInterfaceLightPure))
                        .frame(width: 20, height: 20)
                        .overlay(
                            getItemOverlay(index: index)
                        )
                        .padding(.all, 6)
                    
                    if !item.isEmpty {
                        OceanSwiftUI.Typography.description { view in
                            view.parameters.text = item
                            view.parameters.lineLimit = 20
                        }
                        
                        Spacer()
                    }
                }
            }
            .animation(.default, value: parameters.itemSelectedIndex)
            .transform(condition: parameters.isEnabled, transform: { view in
                view.onTapGesture {
                    parameters.selectItem(item: item, index: index)
                }
            })
        }
        
        private func getItemOverlay(index: Int) -> some View {
            let size: CGFloat = !self.parameters.errorMessage.isEmpty ? 20 : self.parameters.itemSelectedIndex == index ? 14 : 20
            return Group {
                if !self.parameters.errorMessage.isEmpty || self.parameters.hasError {
                    Circle()
                        .stroke(Color(Ocean.color.colorStatusNegativePure), lineWidth: 1)
                    
                } else if !self.parameters.isEnabled {
                    Circle()
                        .stroke(Color(Ocean.color.colorInterfaceLightDeep), lineWidth: 1)
                } else if self.parameters.itemSelectedIndex == index {
                    Circle()
                        .stroke(Color(Ocean.color.colorComplementaryPure), lineWidth: 6)
                } else {
                    Circle()
                        .stroke(Color(Ocean.color.colorInterfaceDarkUp), lineWidth: 1)
                }
            }
            .frame(width: size,
                   height: size)
        }
    }
}
