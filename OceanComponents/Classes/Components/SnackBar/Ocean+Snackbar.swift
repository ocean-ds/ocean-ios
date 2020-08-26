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
        private var backgroundView: UIView!
        private var backgroundViewContent: UIStackView!
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
            case two = 58
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
                    imageViewIcon.image = Ocean.icon.infoMd
                    imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .alert) {
                    imageViewIcon.image = Ocean.icon.errorMd
                    imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .error) {
                    imageViewIcon.image = Ocean.icon.notAllowedMd
                    imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
                } else if (self.iconType == .success) {
                    imageViewIcon.image = Ocean.icon.okCircleMd
                    imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
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
            
            backgroundView = UIView()
            backgroundView.backgroundColor = Ocean.color.colorInterfaceDarkDeep
            backgroundView.layer.cornerRadius = Ocean.size.borderRadiusSm
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(backgroundView)
            
            backgroundViewContent = UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.alignment = .center
                stack.axis = .horizontal
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXs))
                stack.addArrangedSubview(imageViewIcon)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXs))
                stack.addArrangedSubview(labelText)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingInlineXs))
            }
            
            mainStack = UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.alignment = .leading
                stack.axis = .horizontal
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
                stack.addArrangedSubview(backgroundViewContent)
                stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            }
            
            backgroundView.addSubview(mainStack)
            addConstraints()
            self.alpha = 0
            
        }
        
        public func show(_ duration: Int = 2) {
            self.state = .loading
            self.alpha = 0
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.2, options: .curveEaseIn, animations: {
                    self.alpha = 1
                    if (duration > 0) {
                        self.hide(duration)
                    }
                })
            }
        }
        
        public func hide(_ duration: Int = 0) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration)) {
                UIView.transition(with: self, duration: 1.0, options: .curveEaseOut, animations: {
                    self.alpha = 0
                    self.state = .hide
                })
            }
        }
        
        fileprivate func makeIcon() {
            imageViewIcon = UIImageView()
            imageViewIcon.image = imageViewIcon.image?.withRenderingMode(.alwaysTemplate)
            updateIconColor()
            imageViewIcon.widthAnchor.constraint(equalToConstant: Ocean.size.spacingInlineSm).isActive = true
            imageViewIcon.heightAnchor.constraint(equalToConstant: Ocean.size.spacingInlineSm).isActive = true
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
                label.widthAnchor.constraint(lessThanOrEqualToConstant: 221).isActive = true
            }
        }
        
        fileprivate func setIconColor(color: UIColor) {
            imageViewIcon.tintColor = color
        }
        
        @objc func touchUpInside(_ sender: UITapGestureRecognizer? = nil)  {
            print("touchUpInside")
            self.snackbarActionTouch?()
            self.isHidden = true
            //UIView.transition(with: self, duration: 0.1, options: .curveEaseIn, animations: {
                
                
            //})
        }
        
        fileprivate func makeButton() {
            labelButton = UILabel()
            labelButton.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold,
                                      size: Ocean.font.fontSizeXxs)
            labelButton.textColor = Ocean.color.colorBrandPrimaryUp
            labelButton.text = actionText
            labelButton.widthAnchor.constraint(equalToConstant: 43).isActive = true
            labelButton.numberOfLines = 3
            labelButton.isUserInteractionEnabled = true
            labelButton.backgroundColor = .yellow
            
            self.touchUpInsideGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpInside(_:)))
            labelButton.addGestureRecognizer(self.touchUpInsideGesture)
            self.isUserInteractionEnabled = true
            backgroundViewContent.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            backgroundViewContent.addArrangedSubview(labelButton)
            backgroundViewContent.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        }
        
        fileprivate func addConstraints() {
            backgroundViewContent.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
            backgroundViewContent.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            backgroundViewContent.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
            backgroundViewContent.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
            
            mainStack.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
            mainStack.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        }
        
        public override func didMoveToSuperview() {
            super.didMoveToSuperview()
            
            guard let superview = superview else {
                return
            }
            
            backgroundView.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                 constant: Ocean.size.spacingStackXxs).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                  constant: -Ocean.size.spacingStackXxs).isActive = true
            if #available(iOS 11.0, *) {
                backgroundView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -Ocean.size.spacingStackXxs).isActive = true
            } else {
                backgroundView.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                constant: -Ocean.size.spacingStackXxs).isActive = true
            }
            backgroundView.heightAnchor.constraint(equalToConstant: line.rawValue).isActive = true
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
