//
//  Ocean+DetailedCardView.swift
//  OceanComponents
//
//  Created by Renan Massaroto on 23/05/23.
//

import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    
    public class DetailedCardView: UIView, SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        struct Constants {
            static let minItemWidth: CGFloat = 264
            static let minItemHeight: CGFloat = 136
            static let maxItemHeight: CGFloat = 168
            static let pageControlHeight: CGFloat = 16
            static let minHeight: CGFloat = 168
            static let maxHeight: CGFloat = 200
        }
        
        // MARK: Public properties
        
        // MARK: Private properties
        
        private var items: [DetailedCardItemModel]
        
        private lazy var heightConstraint: NSLayoutConstraint = {
            return heightAnchor.constraint(equalToConstant: hasProgress() ? Constants.maxHeight : Constants.minHeight)
        }()
        
        private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
            let collectionViewLayout = UICollectionViewFlowLayout()
            collectionViewLayout.scrollDirection = .horizontal
            collectionViewLayout.minimumLineSpacing = Ocean.size.spacingStackXxs
            collectionViewLayout.sectionInset = .init(top: 0,
                                                      left: Ocean.size.spacingStackXs,
                                                      bottom: 0,
                                                      right: Ocean.size.spacingStackXs)
            collectionViewLayout.estimatedItemSize = CGSizeMake(Constants.minItemWidth, Constants.maxItemHeight)
            
            return collectionViewLayout
        }()
        
        // MARK: View
        
        private lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collection.dataSource = self
            collection.delegate = self
            collection.isPrefetchingEnabled = false
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.isPagingEnabled = false
            collection.register(DetailedCardCell.self, forCellWithReuseIdentifier: DetailedCardCell.identifier)
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.isSkeletonable = true
            
            return collection
        }()
        
        private lazy var pageControl: UIPageControl = {
            let pageControl = UIPageControl()
            pageControl.pageIndicatorTintColor = Ocean.color.colorInterfaceLightDeep
            pageControl.currentPageIndicatorTintColor = Ocean.color.colorBrandPrimaryPure
            pageControl.hidesForSinglePage = true
            pageControl.isUserInteractionEnabled = false
            pageControl.isSelected = false
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.clipsToBounds = true
            pageControl.isSkeletonable = true
            pageControl.isHiddenWhenSkeletonIsActive = true
            
            return pageControl
        }()
        
        // MARK: Constructors
        
        public init(frame: CGRect, items: [DetailedCardItemModel]) {
            self.items = items
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Setup
        
        private func setupUI() {
            isSkeletonable = true
            addSubviews(collectionView, pageControl)
            
            collectionView.oceanConstraints
                .topToTop(to: self)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .make()
            
            pageControl.oceanConstraints
                .topToBottom(to: collectionView)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .bottomToBottom(to: self)
                .height(constant: Constants.pageControlHeight)
                .make()
            
            heightConstraint.isActive = true
            updateUI()
            
        }
        
        private func hasProgress() -> Bool {
            return items.contains(where: { $0.progress != nil })
        }
        
        private func updateUI() {
            heightConstraint.constant = hasProgress() ? Constants.maxHeight : Constants.minHeight
            collectionView.reloadData()
            pageControl.numberOfPages = items.count
        }
        
        // MARK: Public methods
        
        public func update(_ items: [DetailedCardItemModel]) {
            self.items = items
            updateUI()
        }
        
        // MARK: Private methods
        
        private func getCurrentPage() -> Int {
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                return visibleIndexPath.row
            }
            
            return pageControl.currentPage
        }
        
        // MARK: SkeletonCollectionViewDataSource
        
        public func collectionView(_ collectionView: UICollectionView,
                                   numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        public func collectionSkeletonView(_ skeletonView: UICollectionView,
                                           cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
            return DetailedCardCell.identifier
        }
        
        public func collectionView(_ collectionView: UICollectionView,
                                   cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedCardCell.identifier,
                                                                for: indexPath) as? Ocean.DetailedCardCell else {
                return UICollectionViewCell()
            }
        
            cell.update(items[indexPath.row])
            
            return cell
        }
        
        // MARK: UICollectionViewDelegate
        
        public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl.currentPage = getCurrentPage()
        }
        
        public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                             willDecelerate decelerate: Bool) {
            pageControl.currentPage = getCurrentPage()
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            pageControl.currentPage = getCurrentPage()
        }
        
        // MARK: UICollectionViewDelegateFlowLayout
        
        public func collectionView(_ collectionView: UICollectionView,
                                   layout collectionViewLayout: UICollectionViewLayout,
                                   sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let itemWidth = Constants.minItemWidth
            let itemHeight = hasProgress() ? Constants.maxItemHeight : Constants.minItemHeight
            
            return CGSizeMake(itemWidth, itemHeight)
        }
    }
}
