//
//  Ocean+BottomSheetCell.swift
//  OceanComponents
//
//  Created by Vini on 14/06/21.
//

import UIKit
import OceanTokens

extension Ocean {
    class BottomSheetCell: UITableViewCell {
        static let identifier = "bottomSheetCellIdentifier"
        
        lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var isSelected: Bool {
            didSet {
                titleLabel.textColor = isSelected ? Ocean.color.colorBrandPrimaryPure : Ocean.color.colorInterfaceDarkDeep
            }
        }
        
        private func setupUI() {
            contentView.addSubview(titleLabel)
            selectionStyle = .none
            contentView.backgroundColor = Ocean.color.colorInterfaceLightPure
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Ocean.size.borderRadiusLg).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Ocean.size.borderRadiusLg).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        }
    }
}
