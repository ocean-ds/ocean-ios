//
//  OceanSwiftUI+Step.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 28/02/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class StepParameters: ObservableObject {
        @Published public var steps: Int
        @Published public var currentStep: Int

        public var stepFirst: Int {
            return 0
        }

        public var stepLast: Int {
            return self.steps - 1
        }

        public var currentStepInternal: Int {
            return self.currentStep - 1
        }

        public init(steps: Int = 2,
                    currentStep: Int = 1) {
            self.steps = steps
            self.currentStep = currentStep
        }
    }

    public struct Step: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Step) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: StepParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: StepParameters = StepParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(spacing: 0) {
                ForEach(0..<self.parameters.steps, id: \.self) { index in
                    getStep(index: index)
                }
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func getStep(index: Int) -> some View {
            if index == self.parameters.stepFirst {
                Image(uiImage: index == self.parameters.currentStepInternal ? Ocean.icon.stepInitCurrent : Ocean.icon.stepInitSelected)
            } else if index == self.parameters.stepLast {
                Image(uiImage: index == self.parameters.currentStepInternal ? Ocean.icon.stepEndCurrent : Ocean.icon.stepEnd)
            } else {
                Image(uiImage: index < self.parameters.currentStepInternal ? Ocean.icon.stepMiddleSelected :
                        index == self.parameters.currentStepInternal ? Ocean.icon.stepMiddleCurrent : Ocean.icon.stepMiddle)
            }
        }
    }
}
