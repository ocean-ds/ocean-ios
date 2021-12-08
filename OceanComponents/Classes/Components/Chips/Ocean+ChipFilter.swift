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
    public class ChipFilter: UIView {
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
            view.image = Ocean.icon.xSolid?.withRenderingMode(.alwaysTemplate)
            view.contentMode = .scaleAspectFit
            view.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
            view.layer.cornerRadius = view.frame.height / 2.0
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInSide))
            view.addGestureRecognizer(tapGesture)
            return view
        }()
        
        private lazy var mainStack: UIStackView = {
            let stack = UIStackView()
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
        
        public var onClickIcon: (() -> Void)? = nil
        
        public convenience init(builder: ChipFilterBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.shadowRadius = 8
            self.add(view: mainStack)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            self.label.text = self.text
        }
        
        @objc func touchUpInSide() {
            onClickIcon?()
        }
    }
}
