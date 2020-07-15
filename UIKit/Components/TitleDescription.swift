//
//  TitleDescription.swift
//  Blu
//
//  Created by Victor C Tavernari on 26/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

public class TitleDescription: UIView, Renderable {
    var mainStack: UIStackView!

    let labelTitle: UILabel! = {
        let label = UILabel()
        label.textColor = Ocean.color.colorInterfaceDarkDown
        label.font.withSize(Ocean.font.fontSizeXs)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelDescription: UILabel! = {
        let label = UILabel()
        label.textColor = Ocean.color.colorInterfaceDarkDeep
        label.font.withSize(Ocean.font.fontSizeSm)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate func createView() {
        mainStack = UIStackView(arrangedSubviews: [
            labelTitle,
            labelDescription
        ])

        mainStack.translatesAutoresizingMaskIntoConstraints = false

        mainStack.alignment = .leading
        mainStack.axis = .vertical
        mainStack.distribution = .equalSpacing

        self.addSubview(mainStack)

        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.createView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createView()
    }

    public var itemTitle: String = "" {
        didSet {
            labelTitle.text = itemTitle
        }
    }
    public var itemDescription: String = "" {
        didSet {
            labelDescription.text = itemDescription
        }
    }

    convenience init(builder: ((TitleDescription) -> Void)? = nil) {
        self.init(frame: .zero)
        builder?(self)
    }
}
