//
//  Ocean+Carousel.swift
//  OceanComponents
//
//  Created by Vini on 20/08/21.
//

import OceanTokens
import SkeletonView

extension Ocean {
    public class Carousel: UIView, SkeletonCollectionViewDataSource, UICollectionViewDelegate {
        struct Constants {
            static let heightContentDefault: CGFloat = 140
            static let space: CGFloat = Ocean.size.spacingStackXs
            static let heightPage: CGFloat = 4
        }

        private lazy var heightConstraint: NSLayoutConstraint = {
            return self.heightAnchor.constraint(equalToConstant: Constants.heightContentDefault + Constants.space + Constants.heightPage)
        }()

        private lazy var heightContentConstraint: NSLayoutConstraint = {
            return carouselCollectionView.heightAnchor.constraint(equalToConstant: Constants.heightContentDefault)
        }()

        private var data: [CarouselModel] = []

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
            return pageControl
        }()

        public func addImages(with images: [UIImage]) {
            guard !images.isEmpty,
                  let firstImage = images.first else { return }

            var itemWidth = frame.width - (Ocean.size.spacingStackXs * 2)
            var itemHeight = firstImage.size.height
            let ratio = firstImage.size.width / firstImage.size.height
            if itemWidth > itemHeight {
                itemHeight = itemWidth / ratio
            } else {
                itemWidth = itemHeight * ratio
            }

            heightContentConstraint.constant = itemHeight
            heightConstraint.constant = itemHeight + Constants.space + Constants.heightPage

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

            self.data = images.map { CarouselModel(image: $0) }
            self.currentPage = 0

            carouselCollectionView.reloadData()
            carouselCollectionView.setContentOffset(.zero, animated: true)
        }

        public func addImagesUrl(with imagesUrl: [String]) {
            guard !imagesUrl.isEmpty else { return }

            let itemWidth = frame.width - (Ocean.size.spacingStackXs * 2)
            let itemHeight: CGFloat = 160

            heightContentConstraint.constant = itemHeight
            heightConstraint.constant = itemHeight + Constants.space + Constants.heightPage

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
            pageControl.numberOfPages = imagesUrl.count

            self.data = imagesUrl.map { CarouselModel(imageUrl: $0) }
            self.currentPage = 0

            carouselCollectionView.reloadData()
            carouselCollectionView.setContentOffset(.zero, animated: true)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            isSkeletonable = true
            backgroundColor = .clear
            setupCollectionView()
            setupPageControl()

            heightConstraint.isActive = true
        }

        private func setupCollectionView() {
            addSubview(carouselCollectionView)

            NSLayoutConstraint.activate([
                carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
                carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
                carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            ])

            heightContentConstraint.isActive = true
        }

        private func setupPageControl() {
            addSubview(pageControl)

            NSLayoutConstraint.activate([
                pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor,
                                                 constant: Constants.space),
                pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                pageControl.widthAnchor.constraint(equalTo: widthAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: Constants.heightPage)
            ])
        }

        // MARK: - SkeletonCollectionViewDataSource

        public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
            1
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            CarouselCell.cellId
        }

        // MARK: - UICollectionViewDataSource

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }

            let data = self.data[indexPath.row]
            cell.image = data.image
            cell.imageUrl = data.imageUrl

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
