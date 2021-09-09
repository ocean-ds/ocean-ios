//
//  Ocean+TransactionListItem.swift
//  OceanComponents
//
//  Created by Vini on 07/09/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class TransactionListItem: UIView {
        public typealias TransactionListItemBuilder = (TransactionListItem) -> Void
        
        public enum ValueStatus {
            case neutral
            case positive
            case negative
        }
        
        public var onTouch: (() -> Void)?
        
        public var level1: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var level2: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var level3: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var level4: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var value: Double = 0 {
            didSet {
                updateUI()
            }
        }
        
        public var valueStatus: ValueStatus = .neutral {
            didSet {
                updateUI()
            }
        }
        
        public var date: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var tagTitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var tagImage: UIImage? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var tagStatus: Tag.Status = .warning {
            didSet {
                updateUI()
            }
        }
        
        private lazy var level1Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var level1Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)
        
        private lazy var level2Label: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var level2Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        
        private lazy var level3Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var level4Label: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .left
                label.textColor = Ocean.color.colorBrandPrimaryDeep
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var level4Spacer = Ocean.Spacer(space: Ocean.size.spacingStackXxs)
        
        private lazy var leftContentStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    level4Label,
                    level4Spacer,
                    level1Label,
                    level1Spacer,
                    level2Label,
                    level2Spacer,
                    level3Label
                ])
                
                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                            left: Ocean.size.spacingStackXs,
                                            bottom: Ocean.size.spacingStackXs,
                                            right: 0)
            }
        }()
        
        private lazy var valueLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: Ocean.font.fontSizeXxs)
                label.textAlignment = .right
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var valueSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)
        
        private lazy var tagView: Ocean.Tag = {
            Ocean.Tag { view in
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var tagSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)
        
        private lazy var dateLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.textAlignment = .right
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var rightContentStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .trailing
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.add([
                    valueLabel,
                    valueSpacer,
                    tagView,
                    tagSpacer,
                    dateLabel
                ])

                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                            left: 0,
                                            bottom: Ocean.size.spacingStackXs,
                                            right: Ocean.size.spacingStackXs)
            }
        }()
        
        private lazy var contentStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fillProportionally
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    leftContentStack,
                    rightContentStack
                ])
            }
        }()
        
        private lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fillProportionally
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    contentStack,
                    Ocean.Divider(widthConstraint: self.widthAnchor)
                ])
            }
        }()
        
        public convenience init(builder: TransactionListItemBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            add(view: mainStack)
            
            self.isUserInteractionEnabled = true
            self.addTapGesture(selector: #selector(tapped(sender:)))
            self.addLongPressGesture(selector: #selector(longPressed(sender:)))
        }
        
        private func updateUI() {
            level1Label.text = level1
            level2Label.text = level2
            level2Label.isHidden = level2.isEmpty
            level2Spacer.isHidden = level2.isEmpty
            level3Label.text = level3
            level3Label.isHidden = level3.isEmpty
            level4Label.text = level4
            level4Label.isHidden = level4.isEmpty
            level4Spacer.isHidden = level4.isEmpty
            let valueCurrency = value.toCurrency(symbolSpace: true) ?? " R$ 0,00"
            switch self.valueStatus {
            case .positive:
                valueLabel.text = "+" + valueCurrency
                valueLabel.textColor = Ocean.color.colorStatusPositiveDeep
            case .negative:
                valueLabel.text = "-" + valueCurrency
                valueLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            default:
                valueLabel.text = valueCurrency
                valueLabel.textColor = Ocean.color.colorInterfaceDarkDeep
            }
            tagView.status = tagStatus
            tagView.image = tagImage
            tagView.title = tagTitle
            tagView.isHidden = tagTitle.isEmpty
            tagSpacer.isHidden = tagTitle.isEmpty
            dateLabel.text = date
            dateLabel.isHidden = date.isEmpty
        }
        
        @objc func tapped(sender: UITapGestureRecognizer){
            self.backgroundColor = Ocean.color.colorInterfaceLightPure
            onTouch?()
        }

        @objc func longPressed(sender: UILongPressGestureRecognizer) {
            if sender.state == .began {
                self.backgroundColor = Ocean.color.colorInterfaceLightDown
            } else if sender.state == .ended {
                self.backgroundColor = Ocean.color.colorInterfaceLightPure
                onTouch?()
            }
        }
    }
}
