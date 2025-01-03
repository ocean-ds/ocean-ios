//
//  OceanSwiftUI+CardOption.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 11/03/24.
//

import SwiftUI
import OceanTokens
import SkeletonUI

extension OceanSwiftUI {
    // MARK: Parameters

    public class CardOptionParameters: ObservableObject {
        @Published public var title: String
        @Published public var subtitle: String
        @Published public var icon: UIImage
        @Published public var isSelected: Bool
        @Published public var isDisabled: Bool
        @Published public var isError: Bool
        @Published public var recommend: Bool
        @Published public var showSkeleton: Bool

        public var onTouch: (() -> Void)

        public init(title: String = "",
                    subtitle: String = "",
                    icon: UIImage = Ocean.icon.placeholderOutline!,
                    isSelected: Bool = false,
                    isDisabled: Bool = false,
                    isError: Bool = false,
                    recommend: Bool = false,
                    showSkeleton: Bool = false,
                    onTouch: @escaping () -> Void = { }) {
            self.title = title
            self.subtitle = subtitle
            self.icon = icon
            self.isSelected = isSelected
            self.isDisabled = isDisabled
            self.isError = isError
            self.recommend = recommend
            self.showSkeleton = showSkeleton
            self.onTouch = onTouch
        }
    }

    public struct CardOption: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardOption) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardOptionParameters

        // MARK: Properties private

        @State private var disableAnimation = true

        // MARK: Constructors

        public init(parameters: CardOptionParameters = CardOptionParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            HStack(alignment: .center, spacing: Ocean.size.spacingStackXs) {
                RoundedIcon { roundedIcon in
                    roundedIcon.parameters.icon = self.parameters.icon
                    roundedIcon.parameters.color = self.getIconColor()
                    roundedIcon.parameters.backgroundColor = self.getIconBackgroundColor()
                    roundedIcon.parameters.showSkeleton = parameters.showSkeleton
                }

                VStack(alignment: .leading) {
                    OceanSwiftUI.Typography.heading4 { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.textColor = self.parameters.isDisabled ? Ocean.color.colorInterfaceDarkDown : Ocean.color.colorBrandPrimaryDown
                        label.parameters.showSkeleton = parameters.showSkeleton
                        label.parameters.skeletonSize = .large3x
                    }

                    if !self.parameters.subtitle.isEmpty {
                        OceanSwiftUI.Typography.description { label in
                            label.parameters.text = self.parameters.subtitle
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, self.parameters.subtitle.isEmpty ? Ocean.size.spacingStackXs : Ocean.size.spacingStackSm)
            .padding(.vertical, Ocean.size.spacingStackXs)
            .background(Color(Ocean.color.colorInterfaceLightPure))
            .overlay(self.parameters.isDisabled ? self.getLocked() : nil , alignment: .topTrailing)
            .border(cornerRadius: Ocean.size.borderRadiusMd,
                    width: Ocean.size.borderWidthHairline,
                    color: self.getBorderColor())
            .overlay(self.parameters.recommend ? self.getRecommend() : nil, alignment: .topTrailing)
            .offset(x: self.disableAnimation ? 0 : -3)
            .animation(self.parameters.isDisabled ? .interpolatingSpring(stiffness: 350, damping: 5, initialVelocity: 25) : nil)
            .onTapGesture {
                guard !self.parameters.showSkeleton else { return }
                
                self.parameters.onTouch()

                if self.parameters.isDisabled {
                    self.disableAnimation = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.disableAnimation = true
                    }
                    return
                }

                self.parameters.isError = false
                self.parameters.isSelected = true
            }
        }

        // MARK: Methods private

        private func getIconColor() -> UIColor {
            if self.parameters.isSelected {
                return Ocean.color.colorInterfaceLightPure
            } else if self.parameters.isDisabled {
                return Ocean.color.colorInterfaceDarkUp
            } else {
                return Ocean.color.colorBrandPrimaryDown
            }
        }

        private func getIconBackgroundColor() -> UIColor {
            if self.parameters.isSelected {
                return Ocean.color.colorBrandPrimaryDown
            } else {
                return Ocean.color.colorInterfaceLightUp
            }
        }

        private func getBorderColor() -> UIColor {
            if self.parameters.isError {
                return Ocean.color.colorStatusNegativePure
            } else if self.parameters.isSelected {
                return Ocean.color.colorBrandPrimaryDown
            } else {
                return Ocean.color.colorInterfaceLightDown
            }
        }

        private func getLocked() -> some View {
            HStack(alignment: .center, spacing: 0) {
                Image(uiImage: Ocean.icon.lockClosedSolid)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
            }
            .frame(minWidth: 32, maxWidth: 32, maxHeight: .infinity, alignment: .center)
            .background(Color(Ocean.color.colorInterfaceLightUp))
            .cornerRadius(Ocean.size.borderRadiusMd, corners: [.bottomRight, .topRight])
        }

        private func getRecommend() -> some View {
            HStack(alignment: .center, spacing: 0) {
                OceanSwiftUI.Typography.caption { label in
                    label.parameters.font = .baseBold(size: 10)
                    label.parameters.text = "Recomendado"
                    label.parameters.textColor = Ocean.color.colorInterfaceLightPure
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 0)
            .frame(height: 20, alignment: .center)
            .background(Color(Ocean.color.colorComplementaryPure))
            .cornerRadius(Ocean.size.borderRadiusMd, corners: [.bottomLeft, .topRight])
        }
    }
}
