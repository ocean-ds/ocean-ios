//
//  ScrollableTabSwiftUIViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 04/03/24.
//  Copyright © 2024 Blu Pagamentos. All rights reserved.
//

import OceanTokens
import OceanComponents
import SwiftUI

class ScrollableTabSwiftUIViewController: UIViewController {
    private lazy var scrollableTab: OceanSwiftUI.ScrollableTabView = {
        OceanSwiftUI.ScrollableTabView { scrollView in
            scrollView.parameters.tabs = [
                .init(title: "Tab 1",
                      view: Text("1 Beatae non nostrum voluptates molestiae ut sunt. Repudiandae laborum et explicabo. Earum quos quos sint ut provident dolorem eveniet et.")),
                .init(title: "Tab 2",
                      view: Text("2 Aut beatae dicta molestiae. Omnis voluptatem enim consectetur dolorem eum alias. Quibusdam quas fugiat culpa aperiam suscipit laborum commodi dignissimos.")),
                .init(title: "Tab 3",
                      view: Text("3 Est animi debitis consequatur. Nostrum provident rerum deserunt fugit. Quod molestiae eius est enim delectus blanditiis.")),
                .init(title: "Tab 4",
                      view: Text("4 Porro quos laborum dolores est debitis minus. Corrupti blanditiis est voluptatem. Nihil qui sint amet sed saepe. Laborum ad amet voluptatibus culpa aut qui consequatur.")),
                .init(title: "Tab 5",
                      view: Text("5 Doloremque harum in dolores itaque libero. Magnam quo cumque dolor non delectus aut tenetur. Sit fugiat repellat quo error. Voluptatibus placeat a ex quis molestias consequatur omnis. Dolores aut voluptate quam eum molestiae non.")),
                .init(title: "Tab 6",
                      view: Text("6 Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?")),
                .init(title: "Tab 7",
                      view: Text("7 Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"))
            ]
            scrollView.parameters.onTabSelected = { index, tabModel in

            }
        }
    }()

    public lazy var hostingController = UIHostingController(rootView: scrollableTab)

    public lazy var uiView = self.hostingController.getUIView()

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(uiView)

        uiView.oceanConstraints
            .fill(to: self.view)
            .make()
    }
}

@available(iOS 13.0, *)
struct ScrollableTabSwiftUIViewController_Preview: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            ScrollableTabSwiftUIViewController()
        }
    }
}
