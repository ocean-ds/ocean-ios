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
        informativeCard.descriptionText = "Description"
//        informativeCard.setTooltipMessage(message: "Tooltip 1", presenter: view)
        informativeCard.setTooltipMessage(message: "Tooltip 1")
//        informativeCard.addSubItem(labelText: "Label 1", valueText: "R$ 1,00", tooltipMessage: "Tooltip 2", tooltipPresenter: view)
        informativeCard.addSubItem(labelText: "Label 1", valueText: "R$ 1,00", tooltipMessage: "Tooltip 2")
        informativeCard.addSubItem(labelText: "Label 2", valueText: "R$ 2,00")
//        informativeCard.addSubItem(labelText: "Label 3", valueText: "R$ 3,00", tooltipMessage: "Tooltip 3", tooltipPresenter: view)
        informativeCard.addSubItem(labelText: "Label 3", valueText: "R$ 3,00", tooltipMessage: "Tooltip 3")
        
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
    
    // MARK: Properties
    
    var titleText: String = "" {
        didSet {
            defaultView.titleText = titleText
        }
    }
    
    var valueText: String = "" {
        didSet {
            defaultView.valueText = valueText
        }
    }
    
    var descriptionText: String? = nil {
        didSet {
            defaultView.descriptionText = descriptionText
        }
    }
    
    // MARK: Private properties
    
//    private weak var tooltipPresenter: UIView?
    
    // MARK: Views
    
    private lazy var defaultView: InformativeCardDefaultView = {
        let view = InformativeCardDefaultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: Common
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stack in
            
            stack.alignment = .fill
            stack.axis = .vertical
            stack.backgroundColor = Ocean.color.colorInterfaceLightPure
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            
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
        
        ocean.radius.applyMd()
        ocean.borderWidth.applyHairline(color: Ocean.color.colorInterfaceLightDown)
        
        contentStack.oceanConstraints
            .fill(to: self)
            .make()
    }
    
//    func setTooltipMessage(message: String, presenter: UIView) {
    func setTooltipMessage(message: String) {
//        defaultView.setTooltipMessage(message: message, presenter: tooltipPresenter ?? self)
        defaultView.setTooltipMessage(message: message, presenter: getRootSuperview())
    }
    
//    func addSubItem(labelText: String, valueText: String, tooltipMessage: String? = nil, tooltipPresenter: UIView? = nil) {
    func addSubItem(labelText: String, valueText: String, tooltipMessage: String? = nil) {
        defaultView.addSubItem(labelText: labelText,
                               valueText: valueText,
                               tooltipMessage: tooltipMessage)
//                               tooltipMessage: tooltipMessage,
//                               tooltipPresenter: tooltipPresenter)
    }
    
    func removeSubItem(at index: Int) {
        defaultView.removeSubItem(at: index)
    }
    
    func removeSubItems() {
        defaultView.removeSubItems()
    }
}

fileprivate class InformativeCardDefaultView: UIView {
    
    // MARK: Properties
    
    var iconImage: UIImage = Ocean.icon.placeholderOutline! {
        didSet {
            leftIconImageView.image = iconImage.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var valueText: String = "" {
        didSet {
            valueLabel.text = valueText
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
            descriptionLabel.isHidden = descriptionText == nil || descriptionText?.isEmpty == true
        }
    }
    
    // MARK: Private properties
    
//    private weak var tooltipPresenter: UIView?
    
    // MARK: Views
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = iconImage.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
        imageView.isHidden = true
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addTapGesture(target: self, selector: #selector(showTooltip))
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        Ocean.Typography.description { [weak self] label in
            guard let self = self else { return }
            
            label.numberOfLines = 0
            label.text = titleText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    private lazy var valueLabel: UILabel = {
        Ocean.Typography.lead { [weak self] label in
            guard let self = self else { return }
            
            label.numberOfLines = 0
            label.text = valueText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    private lazy var descriptionLabel: UILabel = {
        Ocean.Typography.description { [weak self] label in
            guard let self = self else { return }
            
            label.numberOfLines = 0
            label.isHidden = descriptionText == nil || descriptionText?.isEmpty == true
            label.text = descriptionText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    private lazy var subItemsStack: Ocean.StackView = {
        Ocean.StackView { [weak self] stack in
            guard let self = self else { return }
            
            stack.alignment = .fill
            stack.axis = .vertical
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { [weak self] stack in
            guard let self = self else { return }
            
            stack.alignment = .fill
            stack.axis = .vertical
            stack.backgroundColor = Ocean.color.colorInterfaceLightPure
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                titleLabel,
                valueLabel,
                descriptionLabel,
                subItemsStack
            ])
        }
    }()
    
    private lazy var tooltip: Ocean.Tooltip = {
        Ocean.Tooltip { tooltip in
            tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
        }
    }()
    
    // MARK: Constructors
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
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
    
    // MARK: Public methods
    
    @objc
    public func showTooltip() {
//        tooltip.show(target: rightIconImageView, position: .bottom, presenter: tooltipPresenter ?? self)
        tooltip.show(target: rightIconImageView, position: .bottom, presenter: getRootSuperview())
    }
    
    func setTooltipMessage(message: String, presenter: UIView) {
        tooltip.message = message
//        tooltipPresenter = presenter
        rightIconImageView.isHidden = message.isEmpty
    }
    
//    func addSubItem(labelText: String, valueText: String, tooltipMessage: String? = nil, tooltipPresenter: UIView? = nil) {
    func addSubItem(labelText: String, valueText: String, tooltipMessage: String? = nil) {
        let itemView = InfoListItemView()
        itemView.labelText = labelText
        itemView.valueText = valueText
//        if let message = tooltipMessage, let presenter = tooltipPresenter {
        if let message = tooltipMessage {
//            itemView.setTooltipMessage(message: message, presenter: presenter)
            itemView.setTooltipMessage(message: message)
        }
        
        subItemsStack.addArrangedSubview(itemView)
    }
    
    func removeSubItem(at index: Int) {
        guard subItemsStack.arrangedSubviews.indices.contains(index) else {
            return
        }
        
        subItemsStack.removeArrangedSubview(subItemsStack.arrangedSubviews[index])
    }
    
    func removeSubItems() {
        subItemsStack.removeAllArrangedSubviews()
    }
    
    // MARK: Private methods
    
}

fileprivate class InfoListItemView: UIView {
    
    // MARK: Properties
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var valueText: String = "" {
        didSet {
            valueLabel.text = valueText
        }
    }
    
    // MARK: Private properties
    
//    private weak var tooltipPresenter: UIView?
    
    // MARK: Views
    
    private lazy var label: UILabel = {
        Ocean.Typography.caption { [weak self] label in
            guard let self = self else { return }
            
            label.text = labelText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
        }
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
        imageView.isHidden = true
        imageView.tintColor = Ocean.color.colorInterfaceLightDeep
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addTapGesture(target: self, selector: #selector(showTooltip))

        return imageView
    }()
    
    private lazy var tooltip: Ocean.Tooltip = {
        Ocean.Tooltip { tooltip in
            tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
        }
    }()
    
    private lazy var valueLabel: UILabel = {
        Ocean.Typography.description { [weak self] label in
            guard let self = self else { return }
            
            label.text = valueText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkDeep
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
        }
    }()
    
    // MARK: Constructors
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupUI() {
        addSubviews(
            label,
            iconImageView,
            valueLabel
        )
        
        label.oceanConstraints
            .topToTop(to: self, constant: Ocean.size.spacingStackXxs)
            .leadingToLeading(to: self)
            .make()
        
        iconImageView.oceanConstraints
            .topToTop(to: label)
            .leadingToTrailing(to: label, constant: Ocean.size.spacingInlineXxxs)
            .trailingToTrailing(to: self, type: .lessThanOrEqualTo)
            .width(constant: 16)
            .height(constant: 16)
            .make()
        
        valueLabel.oceanConstraints
            .topToBottom(to: label)
            .leadingToLeading(to: self)
            .trailingToTrailing(to: self)
            .bottomToBottom(to: self)
            .make()
    }
    
    // MARK: Public methods
    
    @objc
    public func showTooltip() {
//        tooltip.show(target: iconImageView, position: .bottom, presenter: tooltipPresenter ?? self)
        tooltip.show(target: iconImageView, position: .bottom, presenter: getRootSuperview())
    }
    
//    func setTooltipMessage(message: String, presenter: UIView) {
    func setTooltipMessage(message: String) {
        tooltip.message = message
//        tooltipPresenter = presenter
        iconImageView.isHidden = message.isEmpty
    }
    
    // MARK: Private methods
    
}

//extension UIView {
//    func getRootSuperview() -> UIView {
//        if let superview = superview {
//            return superview.getRootSuperview()
//        } else {
//            return self
//        }
//    }
//}
