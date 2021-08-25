//
//  Ocean+Carousel.swift
//  OceanComponents
//
//  Created by Vini on 20/08/21.
//

import OceanTokens

extension Ocean {
    public class Carousel: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
        struct Constants {
            static let heightContentDefault: CGFloat = 168
            static let heightPage: CGFloat = 4
        }
        
        private var heightContentConstraint: NSLayoutConstraint? = nil
        
        private var images: [UIImage] = []
        private var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
            }
        }
        
        public var onTouch: ((Int) -> Void)?
        
        private lazy var carouselCollectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collection.dataSource = self
            collection.delegate = self
            collection.isPrefetchingEnabled = false
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.isPagingEnabled = false
            collection.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
            collection.backgroundColor = .clear
            collection.translatesAutoresizingMaskIntoConstraints = false
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
            return pageControl
        }()
        
        public func addImages(with images: [UIImage]) {
            if images.count == 0 { return }
            
            let firstImage = images.first!
            var itemWidth = frame.width - (Ocean.size.spacingStackXs * 2)
            var itemHeight = firstImage.size.height
            let ratio = firstImage.size.width / firstImage.size.height
            if itemWidth > itemHeight {
                itemHeight = itemWidth / ratio
            } else {
                itemWidth = itemHeight * ratio
            }
            
            heightContentConstraint?.constant = itemHeight
            
            let carouselLayout = UICollectionViewFlowLayout()
            carouselLayout.scrollDirection = .horizontal
            carouselLayout.minimumLineSpacing = Ocean.size.spacingStackXxs
            carouselLayout.itemSize = .init(width: itemWidth,
                                            height: itemHeight)
            carouselLayout.sectionInset = .init(top: 0,
                                                left: Ocean.size.spacingStackXs,
                                                bottom: 0,
                                                right: Ocean.size.spacingStackXs)
            
            carouselCollectionView.collectionViewLayout = carouselLayout
            pageControl.numberOfPages = images.count
            
            self.images = images
            self.currentPage = 0
            
            carouselCollectionView.reloadData()
        }
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.heightContentDefault)
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            backgroundColor = .clear
            setupCollectionView()
            setupPageControl()
        }
        
        private func setupCollectionView() {
            addSubview(carouselCollectionView)
            
            NSLayoutConstraint.activate([
                carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
                carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
                carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
            
            heightContentConstraint = carouselCollectionView.heightAnchor.constraint(equalToConstant: Constants.heightContentDefault)
            heightContentConstraint?.isActive = true
        }
        
        private func setupPageControl() {
            addSubview(pageControl)
            
            NSLayoutConstraint.activate([
                pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor,
                                                 constant: Ocean.size.spacingStackXs),
                pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                pageControl.widthAnchor.constraint(equalTo: widthAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: Constants.heightPage)
            ])
        }
        
        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.images.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }

            cell.image = self.images[indexPath.row]

            return cell
        }
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            onTouch?(indexPath.row)
        }
        
        private func getCurrentPage() -> Int {
            let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
                return visibleIndexPath.row
            }
            
            return currentPage
        }
        
        public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            currentPage = getCurrentPage()
        }
        
        public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            currentPage = getCurrentPage()
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            currentPage = getCurrentPage()
        }
    }
}
