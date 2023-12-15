//
//  Ocean+OnboardingCell.swift
//  OceanComponents
//
//  Created by Acassio Mendonça on 04/08/23.
//

import Foundation
import OceanTokens

class OnboardingCell: UICollectionViewCell {
    private let illustrationHeight: CGFloat = 140
    private let illustrationWidth: CGFloat = 140
    
    static let identifier = "OnboardingCell"
    
    lazy var illustrationImageView: UIImageView = {
        UIImageView { imageView in
            imageView.contentMode = .scaleAspectFit
        }
    }()
    
    lazy var titleLabel: UILabel = {
        Ocean.Typography.heading3 { label in
            label.textAlignment = .center
            label.numberOfLines = 0
        }
    }()
    
    lazy var subtitleLabel: UILabel = {
        Ocean.Typography.description { label in
            label.textAlignment = .center
            label.numberOfLines = 0
        }
    }()
    
    lazy var linkView: OceanSwiftUI.Link = {
        OceanSwiftUI.Link.primaryMedium { link in
            link.parameters.type = .external
        }
    }()
    
    lazy var mainStack: Ocean.StackView = {
        let stack = Ocean.StackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.clipsToBounds = true
        
        stack.add([illustrationImageView,
                   Ocean.Spacer(space: Ocean.size.spacingStackSm),
                   titleLabel,
                   Ocean.Spacer(space: Ocean.size.spacingStackXs),
                   subtitleLabel,
                   Ocean.Spacer(space: Ocean.size.spacingStackXs),
                   linkView.uiView])
        
        return stack
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(mainStack)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        contentView.clipsToBounds = true
        
        containerView.oceanConstraints
            .fill(to: contentView)
            .make()
        
        mainStack.oceanConstraints
            .leadingToLeading(to: containerView, constant: Ocean.size.spacingStackXs)
            .trailingToTrailing(to: containerView, constant: -Ocean.size.spacingStackXs)
            .centerY(to: containerView)
            .make()
        
        illustrationImageView.oceanConstraints
            .height(constant: illustrationHeight)
            .width(constant: illustrationWidth)
            .make()
    }
    
    func configure(with model: Ocean.Onboarding.PageModel) {
        illustrationImageView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        linkView.uiView.isHidden = model.linkText.isEmpty
        linkView.parameters.text = model.linkText
        linkView.parameters.onTouch = model.linkAction
    }
}
