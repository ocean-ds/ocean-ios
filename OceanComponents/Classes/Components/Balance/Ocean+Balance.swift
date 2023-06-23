//
//  Ocean+Balance.swift
//  OceanComponents
//
//  Created by Vinicius Romeiro on 17/05/23.
//

import OceanTokens
import SkeletonView

extension Ocean {
    public class Balance: UIView, SkeletonCollectionViewDataSource, UICollectionViewDelegate {
        struct Constants {
            static let heightContent: CGFloat = 140
            static let heightContentLg: CGFloat = 230
            static let heightContentScroll: CGFloat = 58
            static let space: CGFloat = Ocean.size.spacingInsetMd
            static let heightPage: CGFloat = 4
        }
        
        // MARK: - Properties public

        public var onStateChanged: ((BalanceState) -> Void)?
        
        // MARK: - Properties private

        private lazy var heightConstraint: NSLayoutConstraint = {
            return self.heightAnchor.constraint(equalToConstant: Constants.heightContent + Constants.space + Constants.heightPage)
        }()

        private lazy var heightCollectionViewConstraint: NSLayoutConstraint = {
            return collectionView.heightAnchor.constraint(equalToConstant: Constants.heightContent)
        }()

        private (set) public var state: BalanceState = .collapsed

        private var data: [BalanceModel] = []

        private var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
            }
        }

        private lazy var balanceScrollView: BalanceScrollView = {
            let view = BalanceScrollView()
            view.isHidden = true
            view.onOpen = {
                self.updateStateCollectionViewCellSelected(state: .expanded)
                self.changeStateCollectionView()
            }
            return view
        }()

        private lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collection.dataSource = self
            collection.delegate = self
            collection.isPrefetchingEnabled = false
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.isPagingEnabled = true
            collection.register(BalanceCell.self, forCellWithReuseIdentifier: BalanceCell.identifier)
            collection.register(BalanceWithoutValueCell.self, forCellWithReuseIdentifier: BalanceWithoutValueCell.identifier)
            collection.backgroundColor = .clear
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.allowsSelection = false
            collection.isSkeletonable = true
            return collection
        }()

        private lazy var pageControl: UIPageControl = {
            let pageControl = UIPageControl()
            pageControl.pageIndicatorTintColor = Ocean.color.colorBrandPrimaryDown
            pageControl.currentPageIndicatorTintColor = Ocean.color.colorInterfaceLightPure
            pageControl.hidesForSinglePage = true
            pageControl.isUserInteractionEnabled = false
            pageControl.isSelected = false
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.transform = CGAffineTransformMakeScale(0.6, 0.6)

            return pageControl
        }()
        
        // MARK: - Constructors

        public init(frame: CGRect = .zero, state: BalanceState? = nil) {
            super.init(frame: frame)
            setupUI()
            setState(state ?? self.state, animated: false)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Functions public

        public func addBalances(with balances: [BalanceModel]) {
            guard !balances.isEmpty else { return }

            collectionView.collectionViewLayout = getBalanceLayout(state: self.state)

            let previousVisibility = pageControl.isHidden
            pageControl.numberOfPages = balances.count
            pageControl.isHidden = previousVisibility

            self.data = balances
            self.currentPage = 0

            let data = self.data[pageControl.currentPage]
            balanceScrollView.model = data
            collectionView.reloadData()
            collectionView.setContentOffset(.zero, animated: true)
        }

        public func setState(_ state: BalanceState, animated: Bool = true) {
            self.state = state
            updateState(animated: animated)
            onStateChanged?(state)
        }

        // MARK: - Setups
        
        private func setupUI() {
            isSkeletonable = true
            backgroundColor = .clear
            setupBalanceScrollView()
            setupCollectionView()
            setupPageControl()

            heightConstraint.isActive = true
        }

        private func setupBalanceScrollView() {
            addSubview(balanceScrollView)

            balanceScrollView.oceanConstraints
                .fill(to: self)
                .make()
        }

        private func setupCollectionView() {
            addSubview(collectionView)

            collectionView.oceanConstraints
                .topToTop(to: self)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .make()

            heightCollectionViewConstraint.isActive = true
        }

        private func setupPageControl() {
            addSubview(pageControl)

            pageControl.oceanConstraints
                .topToBottom(to: collectionView, constant: Ocean.size.spacingStackXxs)
                .centerX(to: self)
                .height(constant: Constants.heightPage)
                .make()
        }
        
        // MARK: - Functions private

        private func getBalanceLayout(state: BalanceState) -> UICollectionViewFlowLayout {
            let itemWidth = frame.width - (Ocean.size.spacingStackXs * 2) - 20

            let balanceLayout = UICollectionViewFlowLayout()
            balanceLayout.scrollDirection = .horizontal
            balanceLayout.minimumLineSpacing = Ocean.size.spacingStackXxs
            balanceLayout.itemSize = .init(width: itemWidth,
                                           height: state == .collapsed ? Constants.heightContent : Constants.heightContentLg)
            balanceLayout.sectionInset = .init(top: 0,
                                               left: Ocean.size.spacingStackXs,
                                               bottom: 0,
                                               right: Ocean.size.spacingStackXs)
            return balanceLayout
        }

        private func updateState(animated: Bool = true) {
            if state == .collapsed {
                self.collapseAllCollectionView()
            }

            if state == .scroll {
                self.updateStateScroll(animated: animated)
                return
            }

            self.updateVisibility()
            self.updateCollectionViewHeight(state: self.state)
        }

        private func updateStateScroll(animated: Bool = true) {
            self.collapseAllCollectionView()

            if pageControl.currentPage < data.count {
                let data = data[pageControl.currentPage]
                balanceScrollView.model = data
            }

            heightConstraint.constant = Constants.heightContentScroll

            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                    self.updateVisibility()
                }
            } else {
                updateVisibility()
            }
        }

        private func updateVisibility() {
            self.balanceScrollView.isHidden = state != .scroll
            self.collectionView.isHidden = state == .scroll
            self.pageControl.isHidden = state == .scroll
        }

        private func updateCollectionViewHeight(state: BalanceState) {
            self.collectionView.collectionViewLayout = self.getBalanceLayout(state: self.state)
            let collectionViewHeight = state == .collapsed ? Constants.heightContent : Constants.heightContentLg
            self.heightConstraint.constant = collectionViewHeight + Constants.space + Constants.heightPage
            self.heightCollectionViewConstraint.constant = collectionViewHeight
        }

        private func updateStateCollectionViewCellSelected(state: BalanceState) {
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                if let cell = self.collectionView.cellForItem(at: visibleIndexPath) as? BalanceCell {
                    cell.state = state
                }
            }
        }

        private func changeStateCollectionView() {
            var hasItemsExpanded = false
            let allIndexPaths = self.getAllIndexPaths()
            allIndexPaths.forEach { indexPath in
                if let cell = self.collectionView.cellForItem(at: indexPath) as? BalanceCell {
                    if cell.state == .expanded {
                        hasItemsExpanded = true
                    }
                }
            }

            setState(hasItemsExpanded ? .expanded : .collapsed)
        }

        private func collapseAllCollectionView() {
            let allIndexPaths = self.getAllIndexPaths()
            allIndexPaths.forEach { indexPath in
                if let cell = self.collectionView.cellForItem(at: indexPath) as? BalanceCell {
                    cell.state = .collapsed
                }
            }
        }

        private func getAllIndexPaths() -> [IndexPath] {
            let count = self.collectionView.numberOfSections
            return (0..<count).flatMap { self.getAllIndexPathsInSection(section: $0) }
        }

        private func getAllIndexPathsInSection(section: Int) -> [IndexPath] {
            let count = self.collectionView.numberOfItems(inSection: section)
            return (0..<count).map { IndexPath(row: $0, section: section) }
        }

        private func getCurrentPage() -> Int {
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                return visibleIndexPath.row
            }

            return currentPage
        }

        private func updateStateCollectionViewCellSelected() {
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
                if let cell = self.collectionView.cellForItem(at: visibleIndexPath) as? BalanceCell {
                    if cell.state == .collapsed {
                        self.setState(.collapsed)
                    } else {
                        self.setState(.expanded)
                    }
                }
            }
        }
        
        private func setupBalanceCell(data: BalanceModel, indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BalanceCell.identifier,
                for: indexPath
            ) as? BalanceCell else { return UICollectionViewCell() }
            
            cell.model = data
            cell.onStateChanged = { _ in
                self.changeStateCollectionView()
            }
            
            return cell
        }
        
        private func setupWithoutValueCell(data: BalanceModel, indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BalanceWithoutValueCell.identifier,
                for: indexPath
            ) as? BalanceWithoutValueCell else { return UICollectionViewCell() }
            
            cell.model = data
            
            return cell
        }

        // MARK: - SkeletonCollectionViewDataSource

        public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
            1
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            BalanceCell.identifier
        }

        // MARK: - UICollectionViewDataSource

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let data = self.data[indexPath.row]
            
            if data.cellType == .balance {
                return setupBalanceCell(data: data, indexPath: indexPath)
            } else {
                return setupWithoutValueCell(data: data, indexPath: indexPath)
            }
        }

        public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            currentPage = getCurrentPage()
            self.updateStateCollectionViewCellSelected()
        }

        public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            currentPage = getCurrentPage()
        }

        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            currentPage = getCurrentPage()
        }
    }
}
