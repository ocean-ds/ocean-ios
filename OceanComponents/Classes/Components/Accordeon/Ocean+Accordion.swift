//
//  Ocean+Accordion.swift
//  Charts
//
//  Created by Acassio Mendonça on 11/07/23.
//

import OceanTokens

extension Ocean {
    
    public class Accordion: UIView {
        public enum Status {
            case expanded, enabled
        }
        
        public struct ItemModel {
            public var title: String
            public var content: String
            public var status: Status
            public var hasDivider: Bool
            
            public init(title: String,
                        content: String,
                        status: Status = .enabled,
                        hasDivider: Bool = true) {
                self.title = title
                self.content = content
                self.status = status
                self.hasDivider = hasDivider
            }
        }
        
        public var itemModel: ItemModel? {
            didSet {
                updateUI()
            }
        }
        
        private var titleHeightConstraints: CGFloat = 54.0
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.text = ""
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorBrandPrimaryDown
            }
        }()
        
        private lazy var arrowView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var containerTitleView: UIView = {
            let view = UIView()
            
            view.addSubview(titleLabel)
            view.addSubview(arrowView)
            
            return view
        }()
        
        private lazy var contentLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.text = ""
            }
        }()
        
        private lazy var contentSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
        
        private lazy var divider = Ocean.Divider()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            
            stack.add([
                containerTitleView,
                contentLabel,
                contentSpacer,
                divider
            ])
            
            stack.setMargins(horizontal: Ocean.size.spacingStackXs)
            stack.addTapGesture(target: self, selector: #selector(tap))
            
            return stack
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            addSubviews(mainStack)
            setupContraints()
            
            contentLabel.isHidden = true
            contentSpacer.isHidden = true
        }
        
        private func setupContraints() {
            mainStack.oceanConstraints
                .fill(to: self)
                .make()
            
            containerTitleView.oceanConstraints
                .height(constant: titleHeightConstraints)
                .make()
            
            titleLabel.oceanConstraints
                .leadingToLeading(to: containerTitleView)
                .centerY(to: containerTitleView)
                .make()
            
            arrowView.oceanConstraints
                .trailingToTrailing(to: containerTitleView)
                .centerY(to: titleLabel)
                .make()
        }
        
        private func updateUI() {
            if let item = itemModel {
                titleLabel.text = item.title
                contentLabel.text = item.content
                divider.isHidden = !item.hasDivider
            }
        }
        
        private func updateState() {
            if itemModel?.status == .enabled {
                contentLabel.isHidden = false
                contentSpacer.isHidden = false
                titleLabel.textColor = Ocean.color.colorBrandPrimaryDown
                arrowView.tintColor = Ocean.color.colorBrandPrimaryDown
                arrowView.transform = CGAffineTransform(rotationAngle: .pi)
                itemModel?.status = .expanded
            } else {
                contentLabel.isHidden = true
                contentSpacer.isHidden = true
                titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
                arrowView.tintColor = Ocean.color.colorInterfaceDarkDown
                arrowView.transform = CGAffineTransform.identity
                itemModel?.status = .enabled
            }
        }
        
        @objc private func tap() {
            UIView.animate(withDuration: 0.25){
                self.updateState()
            }
        }
    }
}
