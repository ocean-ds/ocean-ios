//
//  ParentChildTextListViewController.swift
//  OceanDesignSystem
//
//  Created by Vinicius Romeiro on 21/03/22.
//  Copyright © 2022 Blu Pagamentos. All rights reserved.
//

import Foundation
import UIKit
import OceanTokens
import OceanComponents

final public class ParentChildTextListViewController : UIViewController {
    let parentChildTextList = Ocean.ParentChildTextList { parentChild in
        parentChild.parent = .init(title: "Title 1",
                                   subtitle: "Description 1",
                                   image: Ocean.icon.documentSolid)
        parentChild.children = [.init(title: "Item 1",
                                      subtitle: "",
                                      image: Ocean.icon.documentSolid,
                                      swipe: true,
                                      onTouch: { print("Tap Item 1") },
                                      buttonsSwipe: [.init(title: "Opcao 1",
                                                           image: Ocean.icon.documentSolid,
                                                           backgroundColor: .blue)]),
                                .init(title: "Item 2",
                                      subtitle: "Item Description",
                                      image: Ocean.icon.documentSolid,
                                      swipe: true,
                                      onTouch: { print("Tap Item 2") },
                                      buttonsLongpress: [.init(title: "Opcao 1",
                                                               image: Ocean.icon.documentSolid,
                                                               backgroundColor: .blue),
                                                        .init(title: "Opcao 2",
                                                              image: Ocean.icon.documentSolid,
                                                              backgroundColor: .gray)])]
    }

    public override func viewDidLoad() {
        self.view.backgroundColor = .white

        let stack = Ocean.StackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 0

        stack.addArrangedSubview(parentChildTextList)

        self.add(view: stack)
    }

    private func add(view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            parentChildTextList.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}
