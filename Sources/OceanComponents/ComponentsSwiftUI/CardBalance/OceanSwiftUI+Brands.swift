//  OceanSwiftUI+Balance.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 08/10/25.

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters
    
    public final class BrandsParameters: ObservableObject {
        @Published public var acquirers: [String]
        @Published public var limit: Int
        @Published public var hasBorder: Bool
        @Published public var borderColor: UIColor
        @Published public var itemSize: CGFloat
        @Published public var overlapSpacing: CGFloat
        @Published public var badgeStatus: OceanSwiftUI.BadgeParameters.Status
        @Published public var badgeSize: OceanSwiftUI.BadgeParameters.Size
        @Published public var showFirstLetter: Bool

        public init(
            acquirers: [String] = [],
            limit: Int = 3,
            hasBorder: Bool = false,
            borderColor: UIColor = Ocean.color.colorInterfaceLightPure,
            itemSize: CGFloat = Ocean.size.spacingStackMd,
            overlapSpacing: CGFloat = Ocean.size.spacingStackXxs,
            badgeStatus: OceanSwiftUI.BadgeParameters.Status = .disabled,
            badgeSize: OceanSwiftUI.BadgeParameters.Size = .medium,
            showFirstLetter: Bool = true
        ) {
            self.acquirers = acquirers
            self.limit = max(0, limit)
            self.hasBorder = hasBorder
            self.borderColor = borderColor
            self.itemSize = itemSize
            self.overlapSpacing = overlapSpacing
            self.badgeStatus = badgeStatus
            self.badgeSize = badgeSize
            self.showFirstLetter = showFirstLetter
        }
    }

    // MARK: Brands View

    public struct Brands: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (Brands) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: BrandsParameters

        // MARK: Private properties

        // MARK: Constructors

        public init(parameters: BrandsParameters = BrandsParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            let acquirers = parameters.showFirstLetter ? parameters.acquirers : parameters.acquirers.filter { "acquirer\($0)".toOceanIcon() != nil }
            let limit = max(0, parameters.limit)
            let shownCount = min(acquirers.count, limit)
            let remaining = max(0, acquirers.count - shownCount)

            return HStack(spacing: -parameters.overlapSpacing) {
                ForEach(Array(0..<shownCount), id: \.self) { index in
                    brandItem(for: acquirers[index])
                        .zIndex(Double(-index))
                }

                if remaining > 0 {
                    OceanSwiftUI.Badge { view in
                        view.parameters.count = remaining
                        view.parameters.status = parameters.badgeStatus
                        view.parameters.size = parameters.badgeSize
                        view.parameters.style = .count
                        view.parameters.valuePrefix = "+"
                    }
                    .padding(.leading, max(0, parameters.overlapSpacing - Ocean.size.spacingStackXxxs))
                    .zIndex(Double(-limit-1))
                }
            }
        }

        // MARK: Methods private

        @ViewBuilder
        private func brandItem(for acquirer: String) -> some View {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: parameters.itemSize, height: parameters.itemSize)
                    .overlay(
                        Group {
                            if parameters.hasBorder {
                                Circle()
                                    .stroke(Color(parameters.borderColor), lineWidth: 1)
                            }
                        }
                    )

                if let icon = "acquirer\(acquirer)".toOceanIcon() {
                    Image(uiImage: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: parameters.itemSize, height: parameters.itemSize)
                } else if parameters.showFirstLetter {
                    OceanSwiftUI.Typography.eyebrow { view in
                        view.parameters.text = String(acquirer.prefix(1)).uppercased()
                        view.parameters.textColor = Ocean.color.colorBrandPrimaryDown
                    }
                }
            }
        }
    }
}
