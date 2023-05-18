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
            stackView.layoutMargins = UIEdgeInsets(top: Ocean.size.spacingStackXs,
                                                   left: Ocean.size.spacingStackXs,
                                                   bottom: Ocean.size.spacingStackXs,
                                                   right: Ocean.size.spacingStackXs)
            stackView.isLayoutMarginsRelativeArrangement = true
        }
        scrollView.addSubview(contentStack)
        contentStack.oceanConstraints
            .fill(to: scrollView)
            .width(to: self.view)
            .make()
        
        addExample(stackView: contentStack, state: .defaultState)
        addExample(stackView: contentStack,
                   state: .defaultState,
                   descriptionText: nil,
                   additionalInformationText: nil,
                   tooltipMessage: nil,
                   subItems: [["Label 1", "R$ 1,00", "Tooltip 2"]])
        addExample(stackView: contentStack,
                   state: .defaultState,
                   descriptionText: nil,
                   additionalInformationText: nil,
                   tooltipMessage: nil,
                   subItems: nil,
                   ctaText: nil)
    }
    
    private func addExample(stackView: Ocean.StackView,
                            state: InformativeCardViewState,
                            iconImage: UIImage? = Ocean.icon.placeholderOutline,
                            titleText: String = "Title",
                            valueText: String = "R$ 0,00",
                            descriptionText: String? = "Description",
                            additionalInformationText: String? = "Additional information",
                            tooltipMessage: String? = "Tooltip 1",
                            subItems: [[String]]? = [["Label 1", "R$ 1,00", "Tooltip 2"], ["Label 2", "R$ 2,00"]],
                            ctaText: String? = "Call To Action",
                            ctaOnTouchMessage: String = "CTA touched!") {
        
        let informativeCard = InformativeCardView()
        informativeCard.iconImage = Ocean.icon.placeholderOutline
        informativeCard.titleText = titleText
        informativeCard.valueText = valueText
        informativeCard.descriptionText = descriptionText
        informativeCard.additionalInformationText = additionalInformationText
        informativeCard.tooltipMessage = tooltipMessage
        subItems?.forEach { item in
            if item.count == 3 {
                informativeCard.addSubItem(labelText: item[0], valueText: item[1], tooltipMessage: item[2])
            } else if item.count == 2 {
                informativeCard.addSubItem(labelText: item[0], valueText: item[1])
            }
        }
        informativeCard.ctaText = ctaText
        informativeCard.ctaOnTouch = { [weak self] in
            guard let self = self else { return }
            
            let snackbar = Ocean.View.snackbarInfo(builder: { snackbar in
                snackbar.line = .one
                snackbar.snackbarText = ctaOnTouchMessage
            })
            
            snackbar.show(in: self.view)
        }
        
        stackView.addArrangedSubview(informativeCard)
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
    
    var iconImage: UIImage? = Ocean.icon.placeholderOutline {
        didSet {
            defaultView.iconImage = iconImage ?? Ocean.icon.placeholderOutline!
        }
    }
    
    var tooltipMessage: String? {
        didSet {
            defaultView.tooltipMessage = tooltipMessage
        }
    }
    
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
    
    var additionalInformationText: String? {
        didSet {
            defaultView.additionalInformationText = additionalInformationText
        }
    }
    
    var ctaText: String? {
        didSet {
            cta.text = ctaText ?? ""
            cta.isHidden = ctaText == nil || ctaText?.isEmpty == true
            divider.isHidden = cta.isHidden
        }
    }
    
    var ctaOnTouch: (() -> Void)? {
        didSet {
            cta.onTouch = ctaOnTouch
        }
    }
    
    // MARK: Views
    
    private lazy var defaultView: InformativeCardDefaultView = {
        let view = InformativeCardDefaultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: Common
    
    private lazy var divider: Ocean.Divider = {
        let divider = Ocean.Divider()
        divider.isHidden = cta.isHidden
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
    
    private lazy var cta: Ocean.GroupCTA = {
        let cta = Ocean.GroupCTA()
        cta.isHidden = ctaText == nil || ctaText?.isEmpty == true
        cta.onTouch = ctaOnTouch
        cta.text = ctaText ?? ""
        cta.translatesAutoresizingMaskIntoConstraints = false
        
        return cta
    }()
    
    private lazy var contentStack: Ocean.StackView = {
        Ocean.StackView { stack in
            
            stack.alignment = .fill
            stack.axis = .vertical
            stack.backgroundColor = Ocean.color.colorInterfaceLightPure
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.add([
                defaultView,
                divider,
                cta
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
    
    func addSubItem(labelText: String, valueText: String, tooltipMessage: String = "") {
        defaultView.addSubItem(labelText: labelText,
                               valueText: valueText,
                               tooltipMessage: tooltipMessage)
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
    
    var iconImage: UIImage? = Ocean.icon.placeholderOutline {
        didSet {
            leftIconImageView.image = (iconImage ?? Ocean.icon.placeholderOutline!).withRenderingMode(.alwaysTemplate)
        }
    }
    
    var tooltipMessage: String? {
        didSet {
            tooltip.message = tooltipMessage ?? ""
            rightIconImageView.isHidden = tooltipMessage == nil || tooltipMessage?.isEmpty == true
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
    
    var additionalInformationText: String? {
        didSet {
            additionalInformationLabel.text = additionalInformationText
            additionalInformationLabel.isHidden = additionalInformationText == nil || additionalInformationText?.isEmpty == true
            additionalInformationSpacer.isHidden = additionalInformationLabel.isHidden
        }
    }
    
    // MARK: Views
    
    private lazy var leftIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = iconImage?.withRenderingMode(.alwaysTemplate)
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
    
    private lazy var additionalInformationSpacer: Ocean.Spacer = {
        let spacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
        spacer.isHidden = additionalInformationText == nil || additionalInformationText?.isEmpty == true
        spacer.isHidden = additionalInformationLabel.isHidden
        
        return spacer
    }()
    
    private lazy var additionalInformationLabel: UILabel = {
        Ocean.Typography.caption { [weak self] label in
            guard let self = self else { return }
            
            label.numberOfLines = 0
            label.isHidden = additionalInformationText == nil || additionalInformationText?.isEmpty == true
            label.text = additionalInformationText
            label.textAlignment = .left
            label.textColor = Ocean.color.colorInterfaceDarkDown
            label.translatesAutoresizingMaskIntoConstraints = false
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
                subItemsStack,
                additionalInformationSpacer,
                additionalInformationLabel
            ])
        }
    }()
    
    private lazy var tooltip: Ocean.Tooltip = {
        Ocean.Tooltip { tooltip in
            tooltip.indicatorMargin = Ocean.size.spacingStackXxxs
            tooltip.message = tooltipMessage ?? ""
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
        tooltip.show(target: rightIconImageView, position: .bottom, presenter: getRootSuperview())
    }
    
    func addSubItem(labelText: String, valueText: String, tooltipMessage: String = "") {
        let itemView = InfoListItemView()
        itemView.labelText = labelText
        itemView.valueText = valueText
        itemView.tooltipMessage = tooltipMessage
        
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
    
    var tooltipMessage: String = "" {
        didSet {
            tooltip.message = tooltipMessage
            iconImageView.isHidden = tooltipMessage.isEmpty
        }
    }
    
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
            tooltip.message = tooltipMessage
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
        tooltip.show(target: iconImageView, position: .bottom, presenter: getRootSuperview())
    }
    
    // MARK: Private methods
    
}
