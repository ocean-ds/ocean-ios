//
//  ButtonTextMDWithIcon.swift
//  Blu
//
//  Created by Lucas Silveira on 08/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

class ButtonTextMDWithIcon: UIControl {
    private var mainStackView: UIStackView!
    private var icon: UIImageView!
    private var label: UILabel!

    public var image: UIImage = (R.image.iconInfo()?.withRenderingMode(.alwaysTemplate))! {
        didSet {
            icon.image = image.withRenderingMode(.alwaysTemplate)
        }
    }

    public var title: String = "Botão texto médio com ícone" {
        didSet {
            label.text = title
        }
    }

    public var onTouch: (() -> Void)?
    public var disabled = false {
        didSet {
            toogleDisable()
        }
    }

    private let minWidth: CGFloat = 108
    private let height: CGFloat = 48
    private let iconSize: CGSize = CGSize(width: 24, height: 24)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createViews()
    }

    public convenience init(builder: ((ButtonTextMDWithIcon) -> Void)?) {
        self.init(frame: .zero)
        builder?(self)
    }

    @objc func touchDown() {
        updateBackgroundColor(Ocean.color.colorInterfaceLightDeep)
    }

    @objc func touchUpInside() {
        self.updateButtonState()
        onTouch?()
    }

    private func updateBackgroundColor(_ color: UIColor, time: Double = 0.3) {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: time) {
            self.backgroundColor = color
        }
    }

    fileprivate func addTouchActions() {
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }

    fileprivate func makeIcon() {
        self.icon = UIImageView(image: image)
        self.icon.tintColor = Ocean.color.colorBrandPrimaryPure
        self.icon.translatesAutoresizingMaskIntoConstraints = false

        self.icon.widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true
        self.icon.heightAnchor.constraint(equalToConstant: iconSize.height).isActive = true
    }

    fileprivate func toogleDisable() {
        if disabled {
            self.isUserInteractionEnabled = false
            self.label.textColor = Ocean.color.colorInterfaceDarkUp
            self.icon.tintColor = Ocean.color.colorInterfaceDarkUp
            self.updateBackgroundColor(Ocean.color.colorInterfaceLightDown)
        } else {
            self.isUserInteractionEnabled = true
            self.label.textColor = Ocean.color.colorBrandPrimaryPure
            self.icon.tintColor = Ocean.color.colorBrandPrimaryPure
            self.updateBackgroundColor(Ocean.color.colorInterfaceLightDeep)
        }
    }

    fileprivate func makeLabel() {
        self.label = UILabel()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold,
                                 size: Ocean.font.fontSizeXs)
        self.label.textColor = Ocean.color.colorBrandPrimaryPure
        self.label.text = self.title
    }

    fileprivate func configStyle() {
        self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func addConstraints() {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    func createViews() {
        mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.isUserInteractionEnabled = false
        self.addSubview(mainStackView)

        makeIcon()
        makeLabel()

        mainStackView.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))
        mainStackView.addArrangedSubview(self.icon)
        mainStackView.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXxs))
        mainStackView.addArrangedSubview(self.label)
        mainStackView.addArrangedSubview(Spacer(space: Ocean.size.spacingStackMd))

        addTouchActions()
        configStyle()
        addConstraints()
    }

    func updateButtonState() {
        updateBackgroundColor(.clear)
    }
}
