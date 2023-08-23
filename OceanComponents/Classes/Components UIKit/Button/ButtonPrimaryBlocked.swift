//
//  ButtonPrimaryBlockedNormal.swift
//  Blu
//
//  Created by Victor C Tavernari on 26/06/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

class ButtonPrimaryBlocked: UIControl {

    var onTouch: (() -> Void)?

    var activityIndicator: UIActivityIndicatorView!
    var titleLabel: UILabel!

    override var isUserInteractionEnabled: Bool {
        didSet {
            self.updateButtonState()
        }
    }

    var isLoading = false {
        didSet {
            self.updateButtonState()
        }
    }

    var label: String = "" {
        didSet {
            titleLabel.text = label
        }
    }

    let height: CGFloat = 48

    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createViews()
    }

    convenience init(builder: ((ButtonPrimaryBlocked) -> Void)?) {
        self.init(frame: .zero)
        builder?(self)
    }

    @objc func touchDown() {
        updateBackgroundColor(Ocean.color.colorBrandPrimaryDeep, time: 0)
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

    fileprivate func addTitleConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    fileprivate func addActivityIndicatorConstraints() {
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    fileprivate func configStyle() {
        self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true

        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: Ocean.font.fontSizeXs)
    }

    fileprivate func makeActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(activityIndicator)
        addActivityIndicatorConstraints()
    }

    fileprivate func makeTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        addTitleConstraints()
    }

    func createViews() {
        makeActivityIndicator()
        makeTitleLabel()
        addTouchActions()
        configStyle()
        updateButtonState()
    }

    func updateButtonState() {
        if isUserInteractionEnabled {
            updateBackgroundColor(Ocean.color.colorBrandPrimaryPure)
            self.titleLabel?.textColor = Ocean.color.colorInterfaceLightPure
        } else {
            updateBackgroundColor(Ocean.color.colorInterfaceLightDown)
            self.titleLabel.textColor = Ocean.color.colorInterfaceDarkUp
        }

        if isLoading {
            self.titleLabel.isHidden = true
            self.activityIndicator.startAnimating()
        } else {
            self.titleLabel.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
}
