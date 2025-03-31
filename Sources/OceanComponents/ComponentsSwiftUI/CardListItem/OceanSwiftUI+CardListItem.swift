//
//  OceanSwiftUI+CardListItem.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 22/12/23.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    // MARK: Parameters

    public class CardListItemParameters: ObservableObject {
        @Published public var leadingIcon: UIImage?
        @Published public var title: String
        @Published public var titleLineLimit: Int?
        @Published public var subtitle: String
        @Published public var subtitleLineLimit: Int?
        @Published public var caption: String
        @Published public var captionLineLimit: Int?
        @Published public var trailingIcon: UIImage?
        @Published public var tagLabel: String
        @Published public var tagIcon: UIImage?
        @Published public var tagStatus: OceanSwiftUI.TagParameters.Status
        @Published public var tagSize: OceanSwiftUI.TagParameters.Size
        @Published public var hasCheckbox: Bool
        @Published public var hasRadioButton: Bool
        @Published public var isChecked: Bool
        @Published public var isEnabled: Bool
        @Published public var hasError: Bool
        @Published public var showSkeleton: Bool

        public var onCheckboxSelect: (Bool) -> Void
        public var onTouch: (() -> Void)

        public init(title: String = "",
                    subtitle: String = "",
                    caption: String = "",
                    leadingIcon: UIImage? = nil,
                    trailingIcon: UIImage? = nil,
                    titleLineLimit: Int? = nil,
                    subtitleLineLimit: Int? = nil,
                    captionLineLimit: Int? = nil,
                    tagLabel: String = "",
                    tagIcon: UIImage? = nil,
                    tagStatus: OceanSwiftUI.TagParameters.Status = .neutralPrimary,
                    tagSize: OceanSwiftUI.TagParameters.Size = .small,
                    hasCheckbox: Bool = false,
                    hasRadioButton: Bool = false,
                    isChecked: Bool = false,
                    isEnabled: Bool = true,
                    hasError: Bool = false,
                    showSkeleton: Bool = false,
                    onCheckboxSelect: @escaping (Bool) -> Void = { _ in },
                    onTouch: @escaping (() -> Void) = {}) {
            self.title = title
            self.subtitle = subtitle
            self.caption = caption
            self.leadingIcon = leadingIcon
            self.trailingIcon = trailingIcon
            self.titleLineLimit = titleLineLimit
            self.subtitleLineLimit = subtitleLineLimit
            self.captionLineLimit = captionLineLimit
            self.tagLabel = tagLabel
            self.tagIcon = tagIcon
            self.tagStatus = tagStatus
            self.tagSize = tagSize
            self.hasCheckbox = hasCheckbox
            self.hasRadioButton = hasRadioButton
            self.isChecked = isChecked
            self.isEnabled = isEnabled
            self.hasError = hasError
            self.showSkeleton = showSkeleton
            self.onCheckboxSelect = onCheckboxSelect
            self.onTouch = onTouch
        }
    }

    private struct Constants {
        static let leadingIconSize: CGFloat = 40
        static let leadingIconImageMaxSize: CGFloat = 24
        static let trailingIconImageMaxSize: CGFloat = 20
    }

    public struct CardListItem: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (CardListItem) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: CardListItemParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: CardListItemParameters = CardListItemParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            if parameters.showSkeleton {
                VStack(spacing: 0) {
                    OceanSwiftUI.Skeleton { view in
                        view.parameters.withImage = true
                        view.parameters.lines = 2
                    }
                    .padding(.horizontal, Ocean.size.spacingStackXs)
                    .padding(.vertical, Ocean.size.spacingStackXxs)
                }
                .border(cornerRadius: Ocean.size.borderRadiusMd,
                        width: Ocean.size.borderWidthHairline,
                        color: Ocean.color.colorInterfaceLightDown)
            } else {
                HStack {
                    HStack {
                        if let image = parameters.leadingIcon {
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(Ocean.color.colorBrandPrimaryDown))
                                    .frame(maxWidth: Constants.leadingIconImageMaxSize,
                                           maxHeight: Constants.leadingIconImageMaxSize)
                            }
                            .frame(width: Constants.leadingIconSize, height: Constants.leadingIconSize)
                            .background(Color(Ocean.color.colorInterfaceLightUp))
                            .cornerRadius(Constants.leadingIconSize / 2)

                            Spacer().frame(width: Ocean.size.spacingInsetSm)
                        } else if parameters.hasCheckbox {
                            OceanSwiftUI.CheckboxGroup { group in
                                group.parameters.hasError = parameters.hasError
                                group.parameters.items = [ .init(isSelected: self.parameters.isChecked,
                                                                 isEnabled: self.parameters.isEnabled) ]
                            }
                        } else if parameters.hasRadioButton {
                            OceanSwiftUI.RadioButtonGroup { group in
                                group.parameters.hasError = parameters.hasError
                                group.parameters.items = [ .init() ]
                                group.parameters.isEnabled = self.parameters.isEnabled
                                group.parameters.setSelectedIndex(self.parameters.isChecked ? 0 : -1)
                            }
                        }

                        VStack(alignment: .leading) {
                            HStack {
                                OceanSwiftUI.Typography.heading4 { label in
                                    label.parameters.text = parameters.title
                                    label.parameters.lineLimit = parameters.titleLineLimit
                                }

                                if !parameters.tagLabel.isEmpty {
                                    OceanSwiftUI.Tag { tag in
                                        tag.parameters.icon = parameters.tagIcon
                                        tag.parameters.label = parameters.tagLabel
                                        tag.parameters.status = parameters.tagStatus
                                        tag.parameters.size = parameters.tagSize
                                    }
                                }
                            }

                            if !parameters.subtitle.isEmpty {
                                OceanSwiftUI.Typography.description { label in
                                    label.parameters.text = parameters.subtitle
                                    label.parameters.lineLimit = parameters.subtitleLineLimit
                                }
                            }

                            if !parameters.caption.isEmpty {
                                Spacer().frame(height: Ocean.size.spacingInsetXxs)

                                OceanSwiftUI.Typography.caption { label in
                                    label.parameters.text = parameters.caption
                                    label.parameters.lineLimit = parameters.captionLineLimit
                                }
                            }
                        }

                        Spacer()

                        if let image = parameters.trailingIcon {
                            Image(uiImage: image)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(Ocean.color.colorInterfaceDarkDown))
                                .frame(maxWidth: Constants.trailingIconImageMaxSize,
                                       maxHeight: Constants.trailingIconImageMaxSize)

                            Spacer().frame(width: Ocean.size.spacingInsetXxs)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, Ocean.size.spacingStackXs)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .border(cornerRadius: Ocean.size.borderRadiusMd,
                        width: Ocean.size.borderWidthHairline,
                        color: Ocean.color.colorInterfaceLightDown)
                .transform(condition: parameters.isEnabled, transform: { view in
                    view.onTapGesture {

                        if parameters.hasCheckbox {
                            parameters.isChecked.toggle()
                            parameters.onCheckboxSelect(parameters.isChecked)
                            parameters.onTouch()
                            return
                        }

                        if parameters.hasRadioButton {
                            guard !parameters.isChecked else { return }
                            parameters.isChecked = true
                            parameters.onTouch()
                            return
                        }

                        parameters.onTouch()
                    }
                })
            }
        }

        // MARK: Private methods
    }
}
