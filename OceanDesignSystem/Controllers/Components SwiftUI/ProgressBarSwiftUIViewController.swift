//
//  ProgressBarSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 21/05/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class ProgressBarSwiftUIViewController: UIViewController {

    private var timer: Timer?
    private var progress: Float = 0

    private lazy var progressBar: OceanSwiftUI.ProgressBar = {
        OceanSwiftUI.ProgressBar { view in

        }
    }()

    private lazy var hostingController = UIHostingController(rootView: ScrollView {
        VStack {
            progressBar
        }
    })

    private lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view, constant: Ocean.size.spacingStackXs)
            .make()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.125, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            self.progressBar.parameters.progress = progress

            if self.progress < 1 {
                self.progress += 0.01
            } else {
                self.progress = 1
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
}

@available(iOS 13.0, *)
struct ProgressBarSwiftUIViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ProgressBarSwiftUIViewController()
        }
    }
}
