//
//  DetailedCardViewController.swift
//  OceanDesignSystem
//
//  Created by Renan Massaroto on 22/05/23.
//  Copyright © 2023 Blu Pagamentos. All rights reserved.
//

import UIKit
import OceanComponents
import OceanTokens

class DetailedCardViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.oceanConstraints
            .fill(to: view, safeArea: true)
            .make()
        
        let contentStack = Ocean.StackView { stackView in
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = Ocean.size.spacingStackXxs
            stackView.setMargins(allMargins: Ocean.size.spacingStackXs)
//            stackView.backgroundColor = .magenta
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: self.view)
            .make()
        
        let icon = Ocean.icon.placeholderSolid!
        let model = DetailedCardItemModel(iconImage: icon,
                                          titleText: "TitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitleTitle",
                                          tooltipMessage: "Tooltip",
                                          valueText: "R$ 0,00",
                                          progress: 0.3,
                                          descriptionText: "Description")
        
        let detailedCard = DetailedCardValueListItem(frame: .zero, model: model)
        
        contentStack.addArrangedSubview(detailedCard)
    }
}

public struct DetailedCardItemModel {
    var iconImage: UIImage
    var titleText: String
    var tooltipMessage: String?
    var valueText: String
    var progress: Float?
    var descriptionText: String
}

public class DetailedCardValueListItem: UIView {
    
    // MARK: Private properties
    
    var model: DetailedCardItemModel
    
    // MARK: Views
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        Ocean.Typography.description { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = -1
            label.textAlignment = .left
        }
    }()
    
    private lazy var infoIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
        imageView.addTapGesture(target: self, selector: #selector(showTooltip))
        
        return imageView
    }()
    
    private lazy var valueLabel: UILabel = {
        Ocean.Typography.lead { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.numberOfLines = -1
            label.textAlignment = .left
        }
    }()
    
    private lazy var progressBar: Ocean.ProgressBar = {
        let progressBar = Ocean.ProgressBar()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        return progressBar
    }()
    
//    private lazy var progressStack: Ocean.StackView = {
//        Ocean.StackView { stackView in
//            stackView.axis = .vertical
//            stackView.alignment = .fill
//            stackView.distribution = .fill
//
//            stackView.add([progressBar])
//        }
//    }()
    
    private lazy var descriptionLabel: UILabel = {
        Ocean.Typography.caption { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.numberOfLines = -1
            label.textAlignment = .left
        }
    }()
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stackView in
            stackView.axis = .vertical
            stackView.alignment = .leading
            stackView.distribution = .fill
            
            stackView.add([
                iconImageView,
                Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                titleLabel,
                Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                valueLabel,
                progressBar,
                Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                descriptionLabel
            ])
        }
    }()
    
    private lazy var tooltip: Ocean.Tooltip = {
        Ocean.Tooltip { tooltip in
            tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
        }
    }()
    
    // MARK: Constructors
    
    public init(frame: CGRect, model: DetailedCardItemModel) {
        self.model = model
        super.init(frame: frame)
        
        setupUI()
        updateUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupUI() {
//        addSubviews(iconImageView,
//                    titleLabel,
//                    infoIconImageView,
//                    valueLabel,
//                    progressStack,
//                    descriptionLabel)
        addSubviews(contentStack)
        
        iconImageView.oceanConstraints
//            .topToTop(to: self)
//            .leadingToLeading(to: self)
            .width(constant: 24)
            .height(constant: 24)
            .make()
        
//        titleLabel.oceanConstraints
//            .topToBottom(to: iconImageView, constant: Ocean.size.spacingStackXxs)
//            .leadingToLeading(to: self)
//            .trailingToLeading(to: infoIconImageView, constant: -Ocean.size.spacingInlineXxxs)
//            .make()
        
        infoIconImageView.oceanConstraints
//            .centerY(to: titleLabel)
//            .trailingToTrailing(to: self, type: .lessThanOrEqualTo)
            .width(constant: 20)
            .height(constant: 20)
            .make()
        
//        valueLabel.oceanConstraints
//            .topToBottom(to: titleLabel, constant: Ocean.size.spacingStackXxxs)
//            .leadingToLeading(to: self)
//            .trailingToTrailing(to: self)
//            .make()
        
//        progressStack.oceanConstraints
//            .topToBottom(to: valueLabel)
//            .leadingToLeading(to: self)
//            .trailingToTrailing(to: self)
//            .make()
        
//        descriptionLabel.oceanConstraints
//            .topToBottom(to: progressStack, constant: Ocean.size.spacingStackXxxs)
//            .bottomToBottom(to: self)
//            .leadingToLeading(to: self)
//            .trailingToTrailing(to: self)
//            .make()
        
        progressBar.oceanConstraints
            .width(to: contentStack)
            .make()
        
        contentStack.oceanConstraints
            .fill(to: self)
            .make()
    }
    
    private func updateUI() {
        iconImageView.image = model.iconImage.withRenderingMode(.alwaysTemplate)
        titleLabel.text = model.titleText
        tooltip.message = model.tooltipMessage ?? ""
        valueLabel.text = model.valueText
        if let progress = model.progress {
            progressBar.setProgress(progress)
        }
        descriptionLabel.text = model.descriptionText
        
        infoIconImageView.isHidden = model.tooltipMessage == nil || model.tooltipMessage?.isEmpty == true
        progressBar.isHidden = model.progress == nil
    }
    
    // MARK: Public methods
    
    @objc
    public func showTooltip() {
        tooltip.show(target: iconImageView, position: .bottom, presenter: getRootSuperview())
    }
    
    public func update(_ model: DetailedCardItemModel) {
        self.model = model
        updateUI()
    }
    
    // MARK: Private methods
}
