//
//  OceanSwiftUI+FileUploader.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 22/01/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {

    // MARK: Parameters

    public class FileUploaderParameters: ObservableObject {
        @Published public var title: String
        @Published public var description: String
        @Published public var fileName: String
        @Published public var errorMessage: String
        public var onTouch: () -> Void
        public var onRemoveTouch: () -> Void

        public init(title: String = "",
                    description: String = "",
                    fileName: String = "",
                    errorMessage: String = "",
                    onTouch: @escaping (() -> Void) = { },
                    onRemoveTouch: @escaping (() -> Void) = { }) {
            self.title = title
            self.description = description
            self.fileName = fileName
            self.errorMessage = errorMessage
            self.onTouch = onTouch
            self.onRemoveTouch = onRemoveTouch
        }
    }

    public struct FileUploader: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = self.hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (FileUploader) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: FileUploaderParameters

        // MARK: Properties private

        // MARK: Constructors

        public init(parameters: FileUploaderParameters = FileUploaderParameters()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            VStack(spacing: Ocean.size.spacingStackXs) {
                getContentUpload()

                if !self.parameters.fileName.isEmpty {
                    getItem()
                }
            }
        }

        // MARK: Methods private

        private func getContentUpload() -> some View {
            VStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                Image(uiImage: Ocean.icon.uploadOutline!)
                    .renderingMode(.template)
                    .foregroundColor(Color(Ocean.color.colorBrandPrimaryPure))

                if !self.parameters.title.isEmpty {
                    Typography.heading5 { label in
                        label.parameters.text = self.parameters.title
                        label.parameters.textColor = Ocean.color.colorBrandPrimaryPure
                        label.parameters.multilineTextAlignment = .center
                    }
                }

                if !self.parameters.description.isEmpty {
                    Typography.caption { label in
                        label.parameters.text = self.parameters.description
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkUp
                        label.parameters.multilineTextAlignment = .center
                    }
                }
            }
            .padding(.horizontal, Ocean.size.spacingStackXs)
            .padding(.vertical, Ocean.size.spacingStackSm)
            .frame(maxWidth: .infinity, minHeight: 112, maxHeight: 112, alignment: .center)
            .cornerRadius(Ocean.size.borderRadiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                    .inset(by: 0.5)
                    .stroke(Color(Ocean.color.colorInterfaceLightDeep), style: StrokeStyle(lineWidth: 1, dash: [4, 2]))

            )
            .onTapGesture {
                self.parameters.onTouch()
            }
        }

        private func getItem() -> some View {
            VStack(alignment: .leading, spacing: Ocean.size.spacingStackXxxs) {
                HStack(alignment: .center, spacing: Ocean.size.spacingStackXxs) {
                    Image(uiImage: self.parameters.errorMessage.isEmpty ? Ocean.icon.checkCircleSolid! : Ocean.icon.xCircleSolid!)
                        .renderingMode(.template)
                        .foregroundColor(Color(self.parameters.errorMessage.isEmpty ? Ocean.color.colorStatusPositivePure : Ocean.color.colorStatusNegativePure))

                    Typography.description { label in
                        label.parameters.text = self.parameters.fileName
                        label.parameters.textColor = Ocean.color.colorInterfaceDarkDeep
                    }

                    Spacer()

                    VStack {
                        Spacer()
                        Image(uiImage: Ocean.icon.xSolid!)
                            .renderingMode(.template)
                            .foregroundColor(Color(Ocean.color.colorInterfaceDarkUp))
                        Spacer()
                    }
                    .onTapGesture {
                        self.parameters.fileName = ""
                        self.parameters.onRemoveTouch()
                    }
                }
                .padding(.horizontal, Ocean.size.spacingStackXs)
                .padding(.vertical, Ocean.size.spacingStackXxs)
                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .leading)
                .cornerRadius(Ocean.size.borderRadiusMd)
                .overlay(
                    RoundedRectangle(cornerRadius: Ocean.size.borderRadiusMd)
                        .inset(by: 0.5)
                        .stroke(Color(self.parameters.errorMessage.isEmpty ? Ocean.color.colorBrandPrimaryUp : Ocean.color.colorStatusNegativePure), lineWidth: 1)

                )

                if !self.parameters.errorMessage.isEmpty {
                    Typography.caption { label in
                        label.parameters.text = self.parameters.errorMessage
                        label.parameters.textColor = Ocean.color.colorStatusNegativePure
                    }
                }
            }
        }
    }
}
