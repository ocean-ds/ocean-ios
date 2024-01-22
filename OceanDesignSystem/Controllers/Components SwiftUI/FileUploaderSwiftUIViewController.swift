//
//  FileUploaderSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 22/01/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import Foundation
import SwiftUI
import OceanTokens
import OceanComponents

class FileUploaderSwiftUIViewController: UIViewController {
    lazy var fileUploader: OceanSwiftUI.FileUploader = {
        OceanSwiftUI.FileUploader { view in
            view.parameters.title = "Selecione um arquivo do seu celular"
            view.parameters.description = "O arquivo deve estar em formato PDF e ter no máximo 20MB."
            view.parameters.onTouch = {
                view.parameters.fileName = "arquivo.pdf"
            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            fileUploader
        }
    })

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }
}

@available(iOS 13.0, *)
struct FileUploaderSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            FileUploaderSwiftUIViewController()
        }
    }
}
