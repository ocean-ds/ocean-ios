//
//  Ocean+ModalCell.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    class ModalCell: UITableViewCell {
        public var model: Ocean.CellModel? {
            didSet {
                updateUI()
            }
        }
        
        static let identifier = "bottomSheetCellIdentifier"
        
        private lazy var contentStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = Ocean.size.borderRadiusLg
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(iconImageView)
            stack.addArrangedSubview(labelsStack)
            stack.addArrangedSubview(chevronStack)
            
            return stack
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: Ocean.size.spacingInlineLg).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: Ocean.size.spacingInlineLg).isActive = true
            return imageView
        }()
        
        private lazy var labelsStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .leading
            stack.addArrangedSubview(titleLabel)
            stack.addArrangedSubview(subtitleLabel)
            return stack
        }()
        
        private lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var subtitleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.textColor = Ocean.color.colorInterfaceDarkDown
                label.font = .baseRegular(size: Ocean.font.fontSizeXxs)
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var chevronStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .trailing
            stack.addArrangedSubview(chevronImageView)
            return stack
        }()
        
        public lazy var chevronImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = Ocean.icon.chevronRightSolid
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func updateUI() {
            guard let model = self.model else { return }
            
            isSelected = model.isSelected
            
            titleLabel.text = model.title
            titleLabel.isHidden = model.title.isEmpty
            titleLabel.textColor = model.isSelected ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkDeep
            
            subtitleLabel.text = model.subTitle
            subtitleLabel.isHidden = model.subTitle.isEmpty
            
            iconImageView.image = model.imageIcon
            iconImageView.isHidden = model.imageIcon == nil
            
            chevronImageView.isHidden = model.hideChevron
        }
        
        private func setupUI() {
            selectionStyle = .none
            contentView.backgroundColor = Ocean.color.colorInterfaceLightPure
            contentView.addSubview(contentStack)
            
            NSLayoutConstraint.activate([
                contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Ocean.size.borderRadiusLg),
                contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Ocean.size.borderRadiusLg),
                contentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
                contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
