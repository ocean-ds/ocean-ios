//
//  OceanSwiftUI+ImageDownload.swift
//  Pods
//
//  Created by Vinicius Romeiro on 02/10/24.
//

import SwiftUI
import OceanTokens

extension OceanSwiftUI {
    public class ImageDownloadParameters: ObservableObject {

        @Published public var url: String?
        @Published public var contentMode: ContentMode

        public init(url: String? = nil,
                    contentMode: ContentMode = .fill) {
            self.url = url
            self.contentMode = contentMode
        }
    }

    public struct ImageDownload: View {

        // MARK: Properties for UIKit

        public lazy var hostingController = UIHostingController(rootView: self)
        public lazy var uiView = hostingController.getUIView()

        // MARK: Builder

        public typealias Builder = (ImageDownload) -> Void

        // MARK: Properties

        @ObservedObject public var parameters: ImageDownloadParameters

        // MARK: Private properties

        @State private var image: UIImage?

        // MARK: Constructors

        public init(parameters: ImageDownloadParameters = .init()) {
            self.parameters = parameters
        }

        public init(builder: Builder) {
            self.init()
            builder(self)
        }

        // MARK: View SwiftUI

        public var body: some View {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: parameters.contentMode)
                .onAppear {
                    self.loadImage()
                }
        }

        private func loadImage() {
            parameters.url?.getImage(completion: { result in
                do {
                    image = try result.get()
                } catch {
                    image = Ocean.icon.xOutline!
                }
            })
        }
    }
}
