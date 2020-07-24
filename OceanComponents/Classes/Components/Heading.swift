//
//  TitleDescription.swift
//  Blu
//
//  Created by Victor C Tavernari on 26/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

public class Heading: UIView, OceanRenderable {
    var mainStack: UIStackView!

    let labelTitle: UILabel! = {
        let label = UILabel()
        label.textColor = Ocean.color.colorInterfaceLightPure
        label.font = UIFont(name: Ocean.font.fontFamilyHighlightWeightExtraBold, size:Ocean.font.fontSizeLg)
        label.setLineHeight(lineHeight: Ocean.font.lineHeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    

    fileprivate func createView() {
        mainStack = UIStackView(arrangedSubviews: [
            labelTitle
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
    

    convenience init(builder: ((Heading) -> Void)? = nil) {
        self.init(frame: .zero)
        builder?(self)
    }
}
