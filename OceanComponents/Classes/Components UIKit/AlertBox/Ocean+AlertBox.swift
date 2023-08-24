//
//  Ocean+AlertBox.swift
//  OceanComponents
//
//  Created by Pedro Azevedo on 24/06/21.
//

import OceanTokens

extension Ocean {
    final public class AlertBox: UIView {
        public enum Status {
            case info
            case error
            case warning
            case success
        }
        
        public enum TextType {
            case shortText
            case longText
        }
        
        public var onTouch: (() -> Void)?
        
        public var textType: TextType = .shortText {
            didSet {
                messageLabel.isHidden = textType == .longText
                messageLongLabel.isHidden = textType == .shortText
            }
        }
        
        public var status: Status = .info {
            didSet {
                switch status {
                case .info:
                    backgroundColor = Ocean.color.colorInterfaceLightUp
                    iconImageView.tintColor = Ocean.color.colorBrandPrimaryDown
                    titleLabel.textColor = Ocean.color.colorBrandPrimaryDown
                    image = Ocean.icon.informationCircleOutline
                case .warning:
                    backgroundColor = Ocean.color.colorStatusNeutralUp
                    iconImageView.tintColor = Ocean.color.colorStatusNeutralDeep
                    titleLabel.textColor = Ocean.color.colorStatusNeutralDeep
                    image = Ocean.icon.exclamationCircleOutline
                case .error:
                    backgroundColor = Ocean.color.colorStatusNegativeUp
                    iconImageView.tintColor = Ocean.color.colorStatusNegativePure
                    titleLabel.textColor = Ocean.color.colorStatusNegativePure
                    image = Ocean.icon.banOutline
                case .success:
                    backgroundColor = Ocean.color.colorStatusPositiveUp
                    iconImageView.tintColor = Ocean.color.colorStatusPositiveDeep
                    titleLabel.textColor = Ocean.color.colorStatusPositiveDeep
                    image = Ocean.icon.checkCircleOutline
                }
            }
        }
        
        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }
        
        public var title: String = ""{
            didSet {
                updateUI()
            }
        }
        
        public var text: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var textAttributedString: NSAttributedString? {
            didSet {
                updateUI()
            }
        }
        
        private lazy var mainContentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.spacing = Ocean.size.spacingStackXxxs
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.addArrangedSubview(contentStack)
                stack.addArrangedSubview(messageLongLabel)
                
                stack.isLayoutMarginsRelativeArrangement = true
                stack.layoutMargins = .init(top: Ocean.size.spacingStackXs,
                                            left: Ocean.size.spacingStackXs,
                                            bottom: Ocean.size.spacingStackXs,
                                            right: Ocean.size.spacingStackXs)
            }
        }()
        
        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .horizontal
                stack.spacing = Ocean.size.spacingStackXxs
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.addArrangedSubview(iconImageView)
                stack.addArrangedSubview(messageStack)
            }
        }()
        
        private lazy var messageStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.axis = .vertical
                stack.spacing = 2
                stack.distribution = .fill
                stack.alignment = .leading
                stack.translatesAutoresizingMaskIntoConstraints = false

                stack.addArrangedSubview(titleLabel)
                stack.addArrangedSubview(messageLabel)
            }
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseBold(size: 14)
                label.numberOfLines = 1
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var messageLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.isHidden = self.textType == .longText
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var messageLongLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 0
                label.isHidden = self.textType == .shortText
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        public convenience init(builder: AlertBoxBuilder) {
            self.init()
            builder(self)
            setupUI()
        }
        
        private func setupUI() {
            ocean.radius.applyMd()
            clipsToBounds = true
            addSubview(mainContentStack)
        
            NSLayoutConstraint.activate([
                mainContentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainContentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                mainContentStack.topAnchor.constraint(equalTo: topAnchor),
                mainContentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchAction(_:))))
        }
        
        private func updateUI() {
            iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
            titleLabel.text = title
            titleLabel.isHidden = title.isEmpty

            messageLabel.text = text
            messageLongLabel.text = text

            if let textAttributedString = self.textAttributedString {
                messageLabel.attributedText = textAttributedString
                messageLongLabel.attributedText = textAttributedString
            }
            
            mainContentStack.spacing = title.isEmpty ? Ocean.size.spacingStackXxs : Ocean.size.spacingStackXs
        }
        
        @objc private func touchAction(_ sender: Any) {
            onTouch?()
        }
    }
}
