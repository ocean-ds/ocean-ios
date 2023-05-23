//
//  Ocean+DetailedCardCell.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 23/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    
    public class DetailedCardCell: UICollectionViewCell {
        
        // MARK: Public properties
        
        static let identifier = "DetailedCardCell"
        
        // MARK: Private properties
        
        var model: DetailedCardItemModel = .empty()
        
        // MARK: Views
        
        private lazy var itemView: Ocean.DetailedCardValueListItemView = {
            let view = Ocean.DetailedCardValueListItemView(frame: .zero, model: model)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        // MARK: Constructors
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            contentView.isSkeletonable = true
            contentView.addSubview(itemView)
            
            itemView.oceanConstraints
                .topToTop(to: contentView)
                .bottomToBottom(to: contentView, type: .lessThanOrEqualTo)
                .leadingToLeading(to: contentView)
                .trailingToTrailing(to: contentView)
                .make()
        }
        
        // MARK: Public methods
        
        public func update(_ model: DetailedCardItemModel) {
            self.model = model
            itemView.update(model)
        }
        
        // MARK: Private methods
    }
}
