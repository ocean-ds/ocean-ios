//
//  OceanSwiftUI+Divider.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 22/12/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class DividerParameters: ObservableObject {
        @Published public var axis: Axis
        @Published public var size: CGFloat
        @Published public var color: UIColor

        public init(axis: Axis = .horizontal,
                    size: CGFloat = 1,
                    color: UIColor = Ocean.color.colorInterfaceLightDown) {
            self.axis = axis
            self.size = size
            self.color = color
        }
    }

    public struct Divider: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Divider) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: DividerParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: DividerParameters = DividerParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack {
                Spacer()
                    .frame(minWidth: self.parameters.size,
                           maxWidth: self.parameters.axis == .horizontal ? .infinity : self.parameters.size,
                           minHeight: self.parameters.size,
                           maxHeight: self.parameters.axis == .vertical ? .infinity : self.parameters.size)
            }
            .background(Color(self.parameters.color))
        }

        // MARK: Methods private
    }
}
