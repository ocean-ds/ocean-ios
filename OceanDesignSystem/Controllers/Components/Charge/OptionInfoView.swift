//
//  OptionInfoView.swift
//  OceanDesignSystem
//
//  Created by Pedro Azevedo on 31/08/21.
//  Copyright © 2021 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanTokens

class OptionInfoView: UIView {
    
    struct Constants {
        static let roundedViewHeightWidthLg: CGFloat = 40
    }

    public var title: String = "" {
        didSet {
            updateUI()
        }
    }
    
    public var subtitle: String = "" {
        didSet {
            updateUI()
        }
    }
    
    public var image: UIImage? {
        didSet {
            updateUI()
        }
    }
    
    public lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = Ocean.size.spacingStackXs
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(roundedIconView)
        stack.addArrangedSubview(textStack)
        return stack
    }()
    
    public lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        return stack
    }()
    
    public lazy var titleLabel: UILabel = {
        Ocean.Typography.heading4 { label in
            label.textColor = Ocean.color.colorInterfaceDarkDown
        }
    }()
    
    public lazy var subtitleLabel: UILabel = {
        Ocean.Typography.description { label in
            label.numberOfLines = 0
        }
    }()
    
    public lazy var roundedIconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
        view.backgroundColor = Ocean.color.colorInterfaceLightUp
        view.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg),
            view.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidthLg),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    public lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Ocean.color.colorBrandPrimaryDown
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        add(view: contentStack)
    }
    
    private func updateUI() {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle.isEmpty
        iconView.image = image?.withRenderingMode(.alwaysTemplate)
    }
}
