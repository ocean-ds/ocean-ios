//
//  Ocean+ChipFilter.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 07/12/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class ChipFilter: UICollectionViewCell {
        static let cellId = "ChipFilterCell"
        
        struct Constants {
            static let height: CGFloat = 32
        }
        
        public var text: String = "Label" {
            didSet {
                updateUI()
            }
        }
        
        private lazy var label: UILabel = {
            UILabel { label in
                label.font = .baseRegular(size: 14)
                label.text = self.text
                label.textColor = Ocean.color.colorBrandPrimaryDown
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            let img = Ocean.icon.xSolid?.withRenderingMode(.alwaysTemplate)
            view.image = img
            view.contentMode = .scaleAspectFit
            view.layer.cornerRadius = view.frame.height / 2.0
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInSide))
            view.addGestureRecognizer(tapGesture)
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 16),
                view.heightAnchor.constraint(equalToConstant: 16),
            ])
            return view
        }()
        
        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 6
            
            stack.add([
                label,
                imageView
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXxs)
            
            return stack
        }()
        
        public var onClickIcon: ((Ocean.ChipFilter) -> Void)? = nil
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp

            self.isSkeletonable = true
            self.contentView.isSkeletonable = true
            self.skeletonCornerRadius = Float(self.layer.cornerRadius)
            contentView.add(view: mainStack)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            self.label.text = self.text
        }
        
        @objc func touchUpInSide() {
            onClickIcon?(self)
        }
    }
}
