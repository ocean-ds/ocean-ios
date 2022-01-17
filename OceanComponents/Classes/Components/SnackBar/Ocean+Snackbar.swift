//
//  Snackbar.swift
//  Blu
//
//  Created by Lucas Silveira on 27/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

extension Ocean {
    
    public typealias SnackbarBuilder = (Snackbar) -> Void
    
    public class Snackbar: UIView {
        var mainStack: UIStackView!
        private var labelText: UILabel!
        private var imageViewIcon: UIImageView!
        private var actionText: String = "Action"
        private var labelButton: UILabel!
        public var checkStatus: (() -> States)?
        private var touchUpInsideGesture : UITapGestureRecognizer!
        
        public enum States  {
            case created
            case loading
            case hide
            case destroyed
        }
        
        public enum Lines : CGFloat {
            case one = 48
            case two = 88
        }
        
        public enum IconType {
            case info
            case error
            case alert
            case success
        }
        
        public var state: States = .created {
            didSet {
                
            }
        }
        
        public var line: Lines = .one
        
        public var snackbarText: String = "Snackbar text" {
            didSet {
                labelText.text = snackbarText
            }
        }
        
        public var snackbarIcon: UIImage?
        
        public var iconType: IconType? {
            didSet {
                if (self.iconType == .info) {
                    imageViewIcon.image = Ocean.icon.informationCircleOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .alert) {
                    imageViewIcon.image = Ocean.icon.exclamationCircleOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .error) {
                    imageViewIcon.image = Ocean.icon.banOutline?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .success) {
                    imageViewIcon.image = Ocean.icon.checkCircleOutline?.withRenderingMode(.alwaysTemplate)
                }
                updateIconColor()
            }
        }
        
        public var snackbarIconColor: UIColor?
        
        
        public var snackbarActionText: String = "Action" {
            didSet {
                actionText = snackbarActionText
                makeButton()
            }
        }
        
        public var snackbarActionTouch: (() -> Void)?
        
        fileprivate func createView() {
            self.state = .created
            makeLabel()
            makeIcon()
            
            self.backgroundColor = Ocean.color.colorInterfaceDarkDeep
            self.layer.cornerRadius = Ocean.size.borderRadiusSm
            self.translatesAutoresizingMaskIntoConstraints = false
            
            mainStack = UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.distribution = .fillProportionally
                stack.axis = .horizontal
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
                stack.addArrangedSubview(imageViewIcon)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
                stack.addArrangedSubview(labelText)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            }
            
            self.addSubview(mainStack)
            addConstraints()
            self.alpha = 0
        }
        
        public func show(in view: UIView, duration: Int = 2, completion: (() -> Void)? = nil) {
            self.isHidden = false
            view.addSubview(self)
            self.leftAnchor.constraint(equalTo: view.leftAnchor,
                                       constant: Ocean.size.spacingStackXxs).isActive = true
            self.rightAnchor.constraint(equalTo: view.rightAnchor,
                                        constant: -Ocean.size.spacingStackXxs).isActive = true
            if #available(iOS 11.0, *) {
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                             constant: -Ocean.size.spacingStackXxs).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -Ocean.size.spacingStackXxs).isActive = true
            }
            self.heightAnchor.constraint(equalToConstant: line.rawValue).isActive = true
            
            self.state = .loading
            self.alpha = 0
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.2, options: .curveEaseIn, animations: {
                    self.alpha = 1
                    if (duration > 0) {
                        self.hide(duration) {
                            completion?()
                        }
                    }
                })
            }
        }
        
        public func hide(_ duration: Int = 0, completion: (() -> Void)? = nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration)) {
                UIView.transition(with: self, duration: 1.0, options: .curveEaseOut, animations: {
                    self.alpha = 0
                    self.state = .hide
                }) { _ in
                    self.removeFromSuperview()
                    completion?()
                }
            }
        }
        
        fileprivate func makeIcon() {
            imageViewIcon = UIImageView()
            imageViewIcon.translatesAutoresizingMaskIntoConstraints = false
            imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
            imageViewIcon.contentMode = .scaleAspectFit
            updateIconColor()
        }
        
        fileprivate func updateIconColor() {
            switch iconType {
            case .info:
                setIconColor(color: Ocean.color.colorBrandPrimaryUp)
                break
            case .alert:
                setIconColor(color:Ocean.color.colorStatusNeutralPure)
                break
            case .error:
                setIconColor(color:Ocean.color.colorStatusNegativePure)
                break
            case .success:
                setIconColor(color:Ocean.color.colorStatusPositivePure)
                break
            case .none:
                break
            }
        }
        
        fileprivate func makeLabel() {
            labelText = Ocean.Typography.description { label in
                label.text = self.snackbarText
                label.setLineHeight(lineHeight: Ocean.font.lineHeightComfy)
                label.numberOfLines = 0
                label.textColor = Ocean.color.colorInterfaceLightPure
            }
        }
        
        fileprivate func setIconColor(color: UIColor) {
            imageViewIcon.tintColor = color
        }
        
        @objc func touchUpInside(_ sender: UITapGestureRecognizer? = nil)  {
            print("touchUpInside")
            self.snackbarActionTouch?()
            self.isHidden = true
        }
        
        fileprivate func makeButton() {
            labelButton = UILabel()
            labelButton.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold,
                                      size: Ocean.font.fontSizeXxs)
            labelButton.text = actionText
            labelButton.widthAnchor.constraint(equalToConstant: 63).isActive = true
            labelButton.numberOfLines = 3
            labelButton.isUserInteractionEnabled = true
            
            self.touchUpInsideGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInside(_:)))
            labelButton.addGestureRecognizer(self.touchUpInsideGesture)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            mainStack.addArrangedSubview(labelButton)
            mainStack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))

            switch iconType {
            case .info:
                labelButton.textColor = Ocean.color.colorBrandPrimaryUp
                break
            case .alert:
                labelButton.textColor = Ocean.color.colorStatusNeutralPure
                break
            case .error:
                labelButton.textColor = Ocean.color.colorStatusNegativePure
                break
            case .success:
                labelButton.textColor = Ocean.color.colorStatusPositivePure
                break
            case .none:
                labelButton.textColor = Ocean.color.colorInterfaceLightPure
                break
            }
        }
        
        fileprivate func addConstraints() {
            mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            mainStack.heightAnchor.constraint(equalToConstant: line.rawValue).isActive = true
            
            imageViewIcon.widthAnchor.constraint(equalToConstant: Ocean.size.spacingInlineSm).isActive = true
            imageViewIcon.heightAnchor.constraint(equalToConstant: Ocean.size.spacingInlineSm).isActive = true
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.createView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.createView()
        }
        
        public convenience init(builder: SnackbarBuilder) {
            self.init(frame: .zero)
            builder(self)
        }
        
        deinit {
            self.state = .destroyed
        }
    }
}
