//
//  Ocean+OrderedListItem.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 06/12/22.
//

import UIKit
import OceanTokens

extension Ocean {
    public class OrderedListItem: UIView {
        public typealias OrderedListItemBuilder = ((OrderedListItem) -> Void)?
        
        struct Constants {
            static let roundedViewHeightWidthLg: CGFloat = 24
        }
        
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var number: Int? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var roundedBackgroundColor: UIColor = Ocean.color.colorInterfaceLightUp {
            didSet {
                updateUI()
            }
        }
        
        public var roundedTintColor: UIColor = Ocean.color.colorBrandPrimaryDown {
            didSet {
                updateUI()
            }
        }
        
        public lazy var numberLabel: UILabel = {
            let label = UILabel()
            label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.textAlignment = .center
            
            return label
        }()
        
        public lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        public lazy var roundedView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidthLg / 2
            view.backgroundColor = roundedBackgroundColor
            
            view.addSubviews(numberLabel, imageView)
            
            return view
        }()
        
        public lazy var titleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
            }
        }()
        
        public lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .top
                stack.spacing = Ocean.size.spacingStackXxs
                
                stack.add([
                    roundedView,
                    titleLabel
                ])
            }
        }()
        
        public convenience init(builder: OrderedListItemBuilder = nil) {
            self.init()
            builder?(self)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            updateUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            add(view: contentStack)
            
            roundedView.oceanConstraints
                .width(constant: Constants.roundedViewHeightWidthLg)
                .height(constant: Constants.roundedViewHeightWidthLg)
                .make()
            
            numberLabel.oceanConstraints
                .fill(to: roundedView)
                .make()
            
            imageView.oceanConstraints
                .center(to: roundedView)
                .width(constant: Ocean.size.spacingInsetSm)
                .height(constant: Ocean.size.spacingInsetSm)
                .make()
        }
        
        private func updateUI() {
            titleLabel.text = title
            
            numberLabel.text = number?.description ?? "1"
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            
            roundedView.backgroundColor = roundedBackgroundColor
            numberLabel.textColor = roundedTintColor
            imageView.tintColor = roundedTintColor
            
            numberLabel.isHidden = number == nil
            imageView.isHidden = image == nil
        }
    }
}
