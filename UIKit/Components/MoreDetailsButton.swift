//
//  MoreDetailsButton.swift
//  Blu
//
//  Created by Victor C Tavernari on 29/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

class MoreDetailsButton: UIView {

    private var label: UILabel!

    let brandPrimaryPure = Ocean.color.colorComplementaryUp
    let labelColor = Ocean.color.colorInterfaceLightPure
    let height: CGFloat = 24
    let cornerRadius: CGFloat = 4

    var onTouch: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createView()
    }

    convenience init(label: String, onTouch: @escaping () -> Void) {
        self.init(frame: .zero)
        self.label.text = label
        self.onTouch = onTouch
    }

    @objc func onTouched() {
        onTouch?()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.topSuperview()
        self.leadingSuperview()
        self.trailingSuperview()
        self.bottomSuperview()
    }

    func createView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let control = UIControl()
        control.translatesAutoresizingMaskIntoConstraints = false

        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false

        control.addSubview(label)
        self.addSubview(line)

        label.leftAnchor.constraint(equalTo: control.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: control.rightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: control.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: control.bottomAnchor).isActive = true

        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.addSubview(control)

        control.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Ocean.size.spacingInlineXs).isActive = true
        control.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        control.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        control.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        control.addTarget(self, action: #selector(onTouched), for: .touchUpInside)

    }
}
