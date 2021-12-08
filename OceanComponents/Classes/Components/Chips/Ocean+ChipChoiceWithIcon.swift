//
//  ChipChoiceWithIcon.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 07/12/21.
//

import Foundation
import UIKit
import OceanTokens

extension Ocean {
    public class ChipChoiceWithIcon: UIView {
        struct Constants {
            static let height: CGFloat = 32
        }
        
        public var text: String = "Label" {
            didSet {
                updateUI()
            }
        }
        
        public var status: ChipStatus = .normal {
            didSet {
                updateUI()
            }
        }
        
        public var icon: UIImage? = nil {
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
        
        public var onSelected: (() -> Void)? = nil
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.image = self.icon
            view.contentMode = .scaleAspectFit
            view.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tintColor = Ocean.color.colorBrandPrimaryDown
            return view
        }()
        
        private lazy var mainStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.spacing = 6
            
            stack.add([
                imageView,
                label
            ])
            
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = .init(top: Ocean.size.spacingStackXxs,
                                        left: Ocean.size.spacingStackXs,
                                        bottom: Ocean.size.spacingStackXxs,
                                        right: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.height)
            }
        }
        
        public convenience init(builder: ChipChoiceWithIconBuilder) {
            self.init()
            setupUI()
            builder(self)
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.shadowRadius = 8
            self.layer.borderColor = Ocean.color.colorStatusNegativePure.cgColor
            self.layer.borderWidth = 0
            self.add(view: mainStack)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInSide))
            self.addGestureRecognizer(tapGesture)
            
            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
        
        private func updateUI() {
            self.label.text = self.text
            self.imageView.image = self.icon
            
            switch status {
            case .normal:
                self.setNormalState()
            case .selected:
                self.setSelectedState()
            case .disabled:
                self.setDisabledState()
            case .error:
                self.setErrorState()
            }
        }
        
        private func setNormalState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorBrandPrimaryDown
            self.imageView.tintColor = Ocean.color.colorBrandPrimaryDown
        }
        
        private func setSelectedState() {
            self.backgroundColor = Ocean.color.colorBrandPrimaryDown
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceLightPure
            self.imageView.tintColor = Ocean.color.colorInterfaceLightPure
        }
        
        private func setDisabledState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 0
            self.label.textColor = Ocean.color.colorInterfaceDarkUp
            self.imageView.tintColor = Ocean.color.colorInterfaceDarkUp
        }
        
        private func setErrorState() {
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.layer.borderWidth = 1
            self.label.textColor = Ocean.color.colorBrandPrimaryDown
            self.imageView.tintColor = Ocean.color.colorBrandPrimaryDown
        }
        
        @objc func touchUpInSide() {
            switch status {
            case .normal:
                self.status = .selected
                onSelected?()
            case .selected:
                self.status = .normal
            default:
                break
            }
        }
    }
}
