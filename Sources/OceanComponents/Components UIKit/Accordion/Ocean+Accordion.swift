//
//  Ocean+Accordion.swift
//  OceanDesignSystem
//
//  Created by Acassio Mendonça on 11/07/23.
//

import OceanTokens
import UIKit

extension Ocean {
    
    public class Accordion: UIView {
        public enum Status {
            case expanded, collapsed
        }
        
        public struct Model {
            public var title: String
            public var content: String
            public var contentAttributedString: NSAttributedString?
            public var hasDivider: Bool
            
            public init(title: String,
                        content: String = "",
                        contentAttributedString: NSAttributedString? = nil,
                        hasDivider: Bool = true) {
                self.title = title
                self.content = content
                self.contentAttributedString = contentAttributedString
                self.hasDivider = hasDivider
            }
        }
        
        public var model: Model? {
            didSet {
                updateUI()
            }
        }
        
        public var status: Status = .collapsed {
            didSet {
                updateUIForStatus()
            }
        }

        private lazy var titleLabel: UILabel = {
            Ocean.Typography.heading5 { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
                label.text = ""
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorInterfaceDarkDown
            }
        }()
        
        private lazy var arrowView: UIImageView = {
            UIImageView { imageView in
                imageView.image = Ocean.icon.chevronDownSolid?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = Ocean.color.colorInterfaceDarkDown
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var containerArrowView: UIView = {
            let view = UIView()
            view.clipsToBounds = false
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(arrowView)

            return view
        }()
        
        private lazy var titleStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.distribution = .fill
            stack.spacing = Ocean.size.spacingStackXs
            
            stack.add([
                titleLabel,
                containerArrowView
            ])
            
            return stack
        }()
        
        private lazy var contentLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.isHidden = true
                label.text = ""
            }
        }()
        
        private lazy var contentSpacer: Ocean.Spacer = {
            let spacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
            spacer.isHidden = true
            return spacer
        }()
        
        private lazy var divider = Ocean.Divider()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            
            stack.add([
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                titleStack,
                Ocean.Spacer(space: Ocean.size.spacingStackXs),
                contentLabel,
                contentSpacer,
                divider
            ])

            stack.addTapGesture(target: self, selector: #selector(tap))
            
            return stack
        }()
        
        public override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            addSubviews(mainStack)
            setupContraints()
            updateUI()
        }
        
        private func setupContraints() {
            mainStack.oceanConstraints
                .fill(to: self)
                .make()

            containerArrowView.oceanConstraints
                .topToTop(to: titleStack)
                .bottomToBottom(to: titleStack)
                .trailingToTrailing(to: titleStack)
                .width(constant: 16, type: .greaterThanOrEqualTo)
                .make()
            
            arrowView.oceanConstraints
                .height(constant: 16)
                .width(constant: 16)
                .trailingToTrailing(to: containerArrowView)
                .centerY(to: containerArrowView)
                .make()
        }
        
        private func updateUI() {
            guard let model = model else { return }
            titleLabel.text = model.title
            
            if let contentAttributedString = model.contentAttributedString {
                contentLabel.attributedText = contentAttributedString
            } else {
                contentLabel.text = model.content
            }
            divider.isHidden = !model.hasDivider
        }
        
        private func updateUIForStatus() {
            UIView.animate(withDuration: 0.25) {
                switch self.status {
                case .expanded:
                    self.expandAccordion()
                case .collapsed:
                    self.collapseAccordion()
                }
            }
        }
        
        private func expandAccordion() {
            contentLabel.isHidden = false
            contentSpacer.isHidden = false
            titleLabel.textColor = Ocean.color.colorBrandPrimaryDown
            arrowView.tintColor = Ocean.color.colorBrandPrimaryDown
            arrowView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        private func collapseAccordion() {
            contentLabel.isHidden = true
            contentSpacer.isHidden = true
            titleLabel.textColor = Ocean.color.colorInterfaceDarkDown
            arrowView.tintColor = Ocean.color.colorInterfaceDarkDown
            arrowView.transform = CGAffineTransform.identity
        }
        
        private func toogleStatus() {
            if status == .collapsed {
                status = .expanded
            } else {
                status = .collapsed
            }
        }
        
        @objc private func tap() {
            toogleStatus()
        }
    }
}
