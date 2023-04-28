//
//  Ocean+BaseChip.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 27/04/23.
//

import Foundation
import OceanTokens


public class BaseChip: UIView {
    
    public enum ChipType {
        case filterChip
        case basicChip
    }
    
    struct Constants {
        static let height: CGFloat = 32
    }
    
    public var text: String = "" {
        didSet {
            updateUI()
        }
    }
    
    public var icon: UIImage? = nil {
        didSet {
            updateUI()
        }
    }
    
    public var number: Int? = nil {
        didSet {
            updateUI()
        }
    }
    
    public var status: Ocean.ChipStatus = .inactive {
        didSet {
            updateUI()
        }
    }
    
    internal var type: ChipType = .basicChip {
        didSet {
            updateUI()
        }
    }
    
    internal lazy var label: UILabel = {
        UILabel { label in
            label.font = .baseSemiBold(size: Ocean.font.fontSizeXxs)
            label.text = self.text
            label.textColor = Ocean.color.colorInterfaceDarkUp
            label.textAlignment = .center
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    internal lazy var badge: Ocean.BadgeNumber = {
        Ocean.Badge.number { view in
            view.size = .small
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    internal lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal func configureAparence() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
        self.layer.masksToBounds = true
        self.backgroundColor = Ocean.color.colorInterfaceLightUp
        self.layer.borderColor = Ocean.color.colorStatusNegativePure.cgColor
        self.layer.borderWidth = 0
    }
    
    internal func setupConstraints() {
        imageView.oceanConstraints
            .width(constant: 16)
            .height(constant: 16)
            .make()
    }
    
    internal func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.didTapButton))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapButton() {
        
    }

    internal func updateUI() {
        label.text = text
        updateStatus()
        updateUIWithBadge()
        updateUIWithImage()
    }
    
    internal func setType() -> ChipType {
        return .basicChip
    }
    
    private func updateStatus() {
        switch status {
        case .normal, .inactive:
            self.setNormalState()
        case .selected:
            self.setSelectedState()
        case .disabled:
            self.setDisabledState()
        }
    }
    
    private func updateUIWithBadge() {
        if let numberValue = self.number {
            self.badge.number = numberValue
        }
        
        self.badge.isHidden = self.number == nil
    }
    
    private func updateUIWithImage() {
        if let icon = self.icon {
            self.imageView.image = icon
        }
        
        self.imageView.isHidden = self.icon == nil
    }
    
    private func setNormalState() {
        self.backgroundColor = Ocean.color.colorInterfaceLightUp
        self.label.textColor = Ocean.color.colorBrandPrimaryPure
        self.badge.status = .primary
        self.imageView.tintColor = Ocean.color.colorBrandPrimaryPure
    }
    
    private func setSelectedState() {
        self.backgroundColor = Ocean.color.colorBrandPrimaryPure
        self.label.textColor = Ocean.color.colorInterfaceLightPure
        self.badge.status = .primaryInverted
        self.imageView.tintColor = Ocean.color.colorInterfaceLightPure
    }
    
    private func setDisabledState() {
        self.backgroundColor = Ocean.color.colorInterfaceLightDown
        self.label.textColor = Ocean.color.colorInterfaceDarkUp
        self.badge.status = .disabled
        self.imageView.tintColor = Ocean.color.colorInterfaceDarkUp
    }
}
