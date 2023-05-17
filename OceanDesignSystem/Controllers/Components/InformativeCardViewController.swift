//
//  InformativeCardViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 17/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanComponents
import OceanTokens

class InformativeCardViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let informativeCard = InformativeCardView()
        informativeCard.titleText = "Title"
        informativeCard.valueText = "R$ 0,00"
        informativeCard.descriptionText = nil
        
        view.addSubview(informativeCard)
        
        informativeCard.oceanConstraints
            .leadingToLeading(to: view, constant: 16, safeArea: true)
            .trailingToTrailing(to: view, constant: -16, safeArea: true)
            .topToTop(to: view, constant: 16, safeArea: true)
            .make()
    }
}

public enum InformativeCardViewState: String {
    case defaultState
    case sellState
    case emptyState
    case loadingState
}

public class InformativeCardView: UIView {
    
    var isDebug: Bool = false
    
    var titleText: String? {
        didSet {
            defaultView.titleText = titleText
        }
    }
    
    var valueText: String? {
        didSet {
            defaultView.valueText = valueText
        }
    }
    
    var descriptionText: String? {
        didSet {
            defaultView.descriptionText = descriptionText
        }
    }
    
    // MARK: Default
    
    private lazy var defaultView: InformativeCardDefaultView = {
        let view = InformativeCardDefaultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: Common
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stack in
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 0
//            stack.isLayoutMarginsRelativeArrangement = true
//            stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
//                                        left: Ocean.size.spacingStackXs,
//                                        bottom: Ocean.size.spacingStackXs,
//                                        right: Ocean.size.spacingStackXs)
            stack.backgroundColor = isDebug ? .red : Ocean.color.colorInterfaceLightPure
            
            stack.add([
                defaultView
            ])
        }
    }()
    
    // MARK: Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(contentStack)
        
        self.ocean.radius.applyMd()
        self.ocean.borderWidth.applyHairline(color: Ocean.color.colorInterfaceLightDown)
        
        contentStack.oceanConstraints
            .fill(to: self)
            .make()
    }
}

fileprivate class InformativeCardDefaultView: UIView {
    
    var isDebug: Bool = true
    
    var leftIconImage: UIImage? = nil {
        didSet {
            leftIconImageView.image = leftIconImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var rightIconImage: UIImage? = Ocean.icon.infoSolid {
        didSet {
            rightIconImageView.image = rightIconImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var tooltipMessage: String? {
        didSet {
            tooltip.message = tooltipMessage ?? ""
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var valueText: String? {
        didSet {
            valueLabel.text = valueText
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
            descriptionLabel.isHidden = descriptionText == nil
        }
    }
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = leftIconImage?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = isDebug ? .green : .clear
        
        return imageView
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = rightIconImage?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = isDebug ? .green : .clear
        imageView.addTapGesture(target: self, selector: #selector(showTooltip))
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        Ocean.Typography.description { [weak self] label in
            guard let self = self else { return }
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.textAlignment = .left
            label.text = self.titleText
        }
    }()
    
    private lazy var valueLabel: UILabel = {
        Ocean.Typography.lead { [weak self] label in
            guard let self = self else { return }
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.textAlignment = .left
            label.text = self.valueText
        }
    }()
    
    private lazy var descriptionLabel: UILabel = {
        Ocean.Typography.description { [weak self] label in
            guard let self = self else { return }
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.textAlignment = .left
            label.text = descriptionText
            label.isHidden = descriptionText == nil
        }
    }()
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stack in
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 0
            stack.backgroundColor = isDebug ? .yellow : Ocean.color.colorInterfaceLightPure
            
            stack.add([
                titleLabel,
                valueLabel,
                descriptionLabel
            ])
        }
    }()
    
    private lazy var tooltip: Ocean.Tooltip = {
        Ocean.Tooltip { component in
            component.message = tooltipMessage ?? ""
        }
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    public func showTooltip() {
        tooltip.show(target: rightIconImageView, position: .bottom, presenter: self)
    }
    
    private func setupUI() {
        addSubviews(leftIconImageView, rightIconImageView, contentStack)
        
        leftIconImageView.oceanConstraints
            .topToTop(to: self, constant: Ocean.size.spacingInsetSm)
            .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
            .width(constant: 24)
            .height(constant: 24)
            .make()
        
        rightIconImageView.oceanConstraints
            .centerY(to: leftIconImageView)
            .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
            .width(constant: 20)
            .height(constant: 20)
            .make()
        
        contentStack.oceanConstraints
            .topToBottom(to: leftIconImageView, constant: Ocean.size.spacingStackXxs)
            .leadingToLeading(to: self, constant: Ocean.size.spacingInsetSm)
            .trailingToTrailing(to: self, constant: -Ocean.size.spacingInsetSm)
            .bottomToBottom(to: self, constant: -Ocean.size.spacingInsetSm)
            .make()
    }
}
