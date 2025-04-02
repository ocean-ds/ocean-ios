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
        @Published public var highlightCaption: String
        @Published public var highlightIcon: UIImage?
        @Published public var highlightIconColor: UIColor
        @Published public var highlightBackgroundColor: UIColor
        @Published public var highlightBorderColor: UIColor
        @Published public var highlightShadowColor: UIColor
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
                    highlightCaption: String = "",
                    highlightIcon: UIImage? = Ocean.icon.sparklesAltSolid,
                    highlightIconColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                    highlightBackgroundColor: UIColor = Ocean.color.colorStatusPositiveUp,
                    highlightBorderColor: UIColor = Ocean.color.colorStatusPositiveDeep,
                    highlightShadowColor: UIColor = Ocean.color.colorStatusPositiveDeep,
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
            self.highlightCaption = highlightCaption
            self.highlightIcon = highlightIcon
            self.highlightIconColor = highlightIconColor
            self.highlightBackgroundColor = highlightBackgroundColor
            self.highlightBorderColor = highlightBorderColor
            self.highlightShadowColor = highlightShadowColor
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

        @State private var borderColor: UIColor = Ocean.color.colorInterfaceLightDown
        @State private var shadowColor: UIColor = .clear

        private var captionHighlightView: some View {
            HStack(spacing: Ocean.size.spacingStackXxs) {
                Image(uiImage: parameters.highlightIcon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(parameters.highlightIconColor))
                    .frame(maxWidth: 24,
                           maxHeight: 24)

                OceanSwiftUI.Typography.caption { label in
                    label.parameters.text = parameters.highlightCaption
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Ocean.size.spacingStackXs)
            .background(Color(parameters.highlightBackgroundColor))
        }

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
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: Ocean.size.spacingStackXs) {
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

                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: Ocean.size.spacingStackXxxs) {
                                OceanSwiftUI.Typography.paragraph { label in
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
                                OceanSwiftUI.Typography.caption { label in
                                    label.parameters.text = parameters.caption
                                    label.parameters.lineLimit = parameters.captionLineLimit
                                }
                                .padding(.top, Ocean.size.spacingStackXxs)
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
                        }
                    }
                    .padding([.vertical, .leading], Ocean.size.spacingStackXs)
                    .padding(.trailing, Ocean.size.spacingStackXxsExtra)

                    if !parameters.highlightCaption.isEmpty {
                        captionHighlightView
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color(Ocean.color.colorInterfaceLightPure))
                .border(cornerRadius: Ocean.size.borderRadiusMd,
                        width: Ocean.size.borderWidthHairline,
                        color: borderColor)
                .shadow(color: Color(shadowColor), radius: 32, x: 0, y: 16)
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
                .onAppear {
                    guard !parameters.highlightCaption.isEmpty else { return }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            borderColor = parameters.highlightBorderColor
                            shadowColor = parameters.highlightShadowColor.withAlphaComponent(0.08)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                borderColor = Ocean.color.colorInterfaceLightDown
                                shadowColor = .clear
                            }
                        }
                    }
                }
            }
        }

        // MARK: Private methods
    }
}
