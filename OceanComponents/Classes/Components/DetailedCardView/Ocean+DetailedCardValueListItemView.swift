//
//  Ocean+Ocean+DetailedCardValueListItemView.swift
//  FSCalendar
//
//  Created by Renan Massaroto on 22/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {

    public struct DetailedCardItemModel {
        var iconImage: UIImage?
        var titleText: String
        var tooltipMessage: String?
        var valueText: String
        var progress: Float?
        var descriptionText: String
        
        public init(iconImage: UIImage?,
                    titleText: String,
                    tooltipMessage: String? = nil,
                    valueText: String,
                    progress: Float? = nil,
                    descriptionText: String) {
            self.iconImage = iconImage
            self.titleText = titleText
            self.tooltipMessage = tooltipMessage
            self.valueText = valueText
            self.progress = progress
            self.descriptionText = descriptionText
        }
        
        public static func empty() -> Self {
            return DetailedCardItemModel(iconImage: Ocean.icon.placeholderSolid,
                                         titleText: "",
                                         valueText: "",
                                         descriptionText: "")
        }
    }
    
    public class DetailedCardValueListItemView: UIView {
        
        struct Constants {
            static let minWidth: CGFloat = 232
            static let iconSize: CGFloat = 24
            static let infoSize: CGFloat = 20
        }
        
        // MARK: Private properties
        
        private var model: DetailedCardItemModel?
        
        // MARK: Views
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.contentMode = .scaleAspectFit
            imageView.isSkeletonable = true
            
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = -1
                label.textAlignment = .left
                label.isSkeletonable = true
                label.text = "                              "
            }
        }()
        
        private lazy var infoIconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = Ocean.color.colorInterfaceLightDeep
            imageView.image = Ocean.icon.infoSolid?.withRenderingMode(.alwaysTemplate)
            imageView.addTapGesture(target: self, selector: #selector(showTooltip))
            imageView.isSkeletonable = true
            imageView.isHiddenWhenSkeletonIsActive = true
            
            return imageView
        }()
        
        private lazy var titleContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubviews(titleLabel, infoIconImageView)
            view.isSkeletonable = true
            
            return view
        }()
        
        private lazy var valueLabel: UILabel = {
            Ocean.Typography.lead { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = -1
                label.textAlignment = .left
                label.isSkeletonable = true
                label.isHiddenWhenSkeletonIsActive = true
            }
        }()
        
        private lazy var progressBar: Ocean.ProgressBar = {
            let progressBar = Ocean.ProgressBar()
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            progressBar.isSkeletonable = true
            
            return progressBar
        }()
        
        private lazy var descriptionLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = -1
                label.textAlignment = .left
                label.isSkeletonable = true
                label.text = "            "
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stackView in
                stackView.axis = .vertical
                stackView.alignment = .leading
                stackView.distribution = .fill
                stackView.isSkeletonable = true
                
                stackView.add([
                    iconImageView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    titleContainerView,
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
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            addSubview(contentStack)
            
            iconImageView.oceanConstraints
                .width(constant: Constants.iconSize)
                .height(constant: Constants.iconSize)
                .make()
            
            titleLabel.oceanConstraints
                .topToTop(to: titleContainerView)
                .bottomToBottom(to: titleContainerView)
                .leadingToLeading(to: titleContainerView)
                .trailingToLeading(to: infoIconImageView, constant: -Ocean.size.spacingInlineXxxs)
                .make()
            
            infoIconImageView.oceanConstraints
                .centerY(to: titleLabel)
                .trailingToTrailing(to: titleContainerView, type: .lessThanOrEqualTo)
                .width(constant: Constants.infoSize)
                .height(constant: Constants.infoSize)
                .make()
            
            progressBar.oceanConstraints
                .width(to: contentStack)
                .make()
            
            contentStack.oceanConstraints
                .fill(to: self, constant: Ocean.size.spacingInsetSm)
                .make()
            
            oceanConstraints
                .width(constant: Constants.minWidth, type: .greaterThanOrEqualTo)
                .make()
            
            ocean.radius.applyMd()
            ocean.borderWidth.applyHairline(color: Ocean.color.colorInterfaceLightDown)
        }
        
        private func updateUI() {
            iconImageView.image = model?.iconImage?.withRenderingMode(.alwaysTemplate)
            titleLabel.text = model?.titleText ?? ""
            tooltip.message = model?.tooltipMessage ?? ""
            valueLabel.text = model?.valueText ?? ""
            if let progress = model?.progress {
                progressBar.setProgress(progress)
            }
            descriptionLabel.text = model?.descriptionText ?? ""
            
            iconImageView.isHidden = iconImageView.image == nil
            infoIconImageView.isHidden = model?.tooltipMessage == nil || model?.tooltipMessage?.isEmpty == true
            progressBar.isHidden = model?.progress == nil
        }
        
        // MARK: Public methods
        
        @objc
        public func showTooltip() {
            tooltip.show(target: infoIconImageView, position: .bottom, presenter: getRootSuperview())
        }
        
        public func update(_ model: DetailedCardItemModel) {
            self.model = model
            updateUI()
        }
        
        // MARK: Private methods
    }
}
