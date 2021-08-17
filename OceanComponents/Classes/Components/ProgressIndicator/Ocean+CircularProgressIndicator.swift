//
//  Ocean+CircularProgressIndicator.swift
//  OceanComponents-OceanComponents
//
//  Created by Vini on 13/08/21.
//

import OceanTokens
import UIKit

extension Ocean {
    public class CircularProgressIndicator: UIView {
        public enum Size {
            case small
            case medium
            case large
        }
        
        private var widthConstraint: NSLayoutConstraint?
        private var heightConstraint: NSLayoutConstraint?
        
        public var size: CircularProgressIndicator.Size = .medium {
            didSet {
                setSize()
            }
        }
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.image = Ocean.icon.spinner
            return view
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            add(view: imageView)
            
            widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 24)
            heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 24)
            
            widthConstraint?.isActive = true
            heightConstraint?.isActive = true
        }
        
        public func setSize() {
            switch size {
            case .large:
                widthConstraint?.constant = 32
                heightConstraint?.constant = 32
            case .medium:
                widthConstraint?.constant = 24
                heightConstraint?.constant = 24
            case .small:
                widthConstraint?.constant = 16
                heightConstraint?.constant = 16
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func startAnimating() {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            imageView.layer.add(rotation, forKey: "rotationAnimation")
        }
        
        public func stopAnimating() {
            imageView.layer.removeAllAnimations()
        }
    }
}
