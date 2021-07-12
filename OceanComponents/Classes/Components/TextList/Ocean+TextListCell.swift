//
//  Ocean+TextListCell.swift
//  OceanComponents
//
//  Created by Vini on 09/07/21.
//

import Foundation
import OceanTokens
import UIKit

extension Ocean {
    public class TextListCell: UIView {
        struct Constants {
            static let roundedViewHeightWidth: CGFloat = 40
        }
        
        public var title: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var subtitle: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var text: String = "" {
            didSet {
                updateUI()
            }
        }
        
        public var image: UIImage? = nil {
            didSet {
                updateUI()
            }
        }
        
        public var arrow: Bool = false {
            didSet {
                updateUI()
            }
        }
        
        public var badge: Bool = false {
            didSet {
                updateUI()
            }
        }
        
        public var onTouch: (() -> Void)?
        
        public lazy var mainStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .vertical
                stack.distribution = .fill
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    contentStack,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()
        
        public lazy var contentStack: UIStackView = {
            UIStackView { stack in
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.alignment = .center
                stack.translatesAutoresizingMaskIntoConstraints = false
                
                stack.add([
                    Ocean.Spacer(space: Ocean.size.spacingStackXs),
                    roundedIconView,
                    roundedIconViewSpacer,
                    infoStack,
                    arrowImageViewSpacer,
                    arrowImageView,
                    Ocean.Spacer(space: Ocean.size.spacingStackXs)
                ])
            }
        }()
        
        lazy var roundedIconViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
        
        public lazy var roundedIconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            view.layer.cornerRadius = Constants.roundedViewHeightWidth / 2
            view.backgroundColor = Ocean.color.colorInterfaceLightUp
            view.addSubview(typeImageView)
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
                view.widthAnchor.constraint(equalToConstant: Constants.roundedViewHeightWidth),
                typeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                typeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            
            return view
        }()
        
        public lazy var typeImageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        lazy var arrowImageViewSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXs)
        
        public lazy var arrowImageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = Ocean.icon.chevronRightSolid
            view.contentMode = .scaleAspectFit
            return view
        }()
        
        public lazy var badgeView = Ocean.Badge()
        
        public lazy var infoStackTitle: UIStackView = {
            UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.distribution = .fillProportionally
                stack.alignment = .leading
                
                stack.add([
                    titleLabel,
                    Ocean.Spacer(space: Ocean.size.spacingStackXxs),
                    badgeView
                ])
            }
        }()
        
        public lazy var infoStack: UIStackView = {
            UIStackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.distribution = .fill
                stack.alignment = .leading
                
                stack.add([
                    infoStackTitle,
                    subtitleLabel,
                    textLabel
                ])
            }
        }()
        
        public lazy var titleLabel: UILabel = {
            Ocean.Typography.paragraph { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXs)
                label.textColor = Ocean.color.colorInterfaceDarkDeep
                label.numberOfLines = 1
            }
        }()
        
        public lazy var subtitleLabel: UILabel = {
            Ocean.Typography.description { label in
                label.numberOfLines = 1
            }
        }()

        public lazy var textLabel: UILabel = {
            Ocean.Typography.caption { label in
                label.numberOfLines = 1
            }
        }()
        
        public convenience init(builder: TextListCellBuilder = nil) {
            self.init()
            builder?(self)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.add(view: mainStack)
            
            self.addTapGesture(selector: #selector(viewTapped))
        }

        func updateUI() {
            titleLabel.text = title
            subtitleLabel.isHidden = subtitle.isEmpty
            subtitleLabel.text = subtitle
            textLabel.isHidden = text.isEmpty
            textLabel.text = text
            typeImageView.image = image
            roundedIconViewSpacer.isHidden = image == nil
            roundedIconView.isHidden = image == nil
            arrowImageViewSpacer.isHidden = !arrow
            arrowImageView.isHidden = !arrow
            badgeView.isHidden = !badge
        }
        
        @objc func viewTapped() {
            self.onTouch?()
        }
    }
}
