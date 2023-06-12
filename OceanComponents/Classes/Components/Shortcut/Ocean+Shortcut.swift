//
//  Ocean+Shortcut.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens
import SkeletonView

extension Ocean {
    public class Shortcut: UIView, SkeletonCollectionViewDataSource, UICollectionViewDelegate {

        struct Constants {
            static let heightTinyVertical: CGFloat = 80
            static let heightSmall: CGFloat = 104
            static let heightMediumVertical: CGFloat = 131

            static let heightTinyHorizontal: CGFloat = 56
            static let heightMediumHorizontal: CGFloat = 100
        }

        public enum Size {
            case tiny
            case small
            case medium
        }

        public enum Orientation {
            case horizontal
            case vertical
        }

        public var size: Size = .small
        public var orientation: Orientation = .vertical
        public var direction: UICollectionView.ScrollDirection = .horizontal

        public var height: CGFloat {
            switch size {
            case .tiny:
                return orientation == .vertical ? Constants.heightTinyVertical : Constants.heightTinyHorizontal
            case .small:
                return Constants.heightSmall
            case .medium:
                return orientation == .vertical ? Constants.heightMediumVertical : Constants.heightMediumHorizontal
            }
        }

        public var onTouch: ((Int) -> Void)?

        private lazy var heightConstraint: NSLayoutConstraint = {
            return self.heightAnchor.constraint(equalToConstant: height)
        }()

        private var data: [ShortcutModel] = []

        private lazy var carouselCollectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collection.dataSource = self
            collection.delegate = self
            collection.isPrefetchingEnabled = false
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.isPagingEnabled = false
            collection.register(ShortcutCell.self, forCellWithReuseIdentifier: ShortcutCell.cellId)
            collection.backgroundColor = .clear
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.isSkeletonable = true
            return collection
        }()

        public func addData(with data: [ShortcutModel], quantityPage: CGFloat = 3) {
            let shortcutLayout = UICollectionViewFlowLayout()
            shortcutLayout.scrollDirection = direction
            shortcutLayout.minimumInteritemSpacing = Ocean.size.spacingStackXs
            shortcutLayout.minimumLineSpacing = Ocean.size.spacingStackXs

            let spacingSection = Ocean.size.spacingStackXs * 2
            let spacing = Ocean.size.spacingStackXs * (quantityPage - 1)
            let spacingShowMore = direction == .horizontal ? Ocean.size.spacingStackXxs : 0
            let width = frame.width - spacingSection - spacing - spacingShowMore
            let widthItem = width <= 0 ? height : width / quantityPage

            shortcutLayout.itemSize = .init(width: widthItem,
                                            height: height)
            shortcutLayout.sectionInset = .init(top: 0,
                                                left: Ocean.size.spacingStackXs,
                                                bottom: 0,
                                                right: Ocean.size.spacingStackXs)

            carouselCollectionView.collectionViewLayout = shortcutLayout
            self.data = data
            carouselCollectionView.reloadData()
            carouselCollectionView.setContentOffset(.zero, animated: true)

            updateHeightConstraints(quantityPage: quantityPage)
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
            heightConstraint.isActive = true
        }

        private func setupCollectionView() {
            addSubview(carouselCollectionView)

            carouselCollectionView.oceanConstraints
                .fill(to: self)
                .make()
        }

        private func updateHeightConstraints(quantityPage: CGFloat) {
            if direction == .vertical {
                let quantityRows = (CGFloat(self.data.count) / quantityPage).rounded()
                let spacing = (quantityRows - 1) * Ocean.size.spacingStackXs
                let heightTotal = (height * quantityRows) + spacing
                heightConstraint.constant = heightTotal
            } else {
                heightConstraint.constant = height
            }
        }

        // MARK: - SkeletonCollectionViewDataSource

        public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
            1
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            ShortcutCell.cellId
        }

        // MARK: - UICollectionViewDataSource

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortcutCell.cellId, for: indexPath) as? ShortcutCell else { return UICollectionViewCell() }

            let shortcutData = self.data[indexPath.row]
            cell.orientation = orientation
            cell.model = shortcutData
            return cell
        }

        public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ShortcutCell {
                cell.pressState(isPressed: true)
            }
        }

        public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ShortcutCell {
                cell.pressState(isPressed: false)
            }
        }

        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            onTouch?(indexPath.row)
        }
    }
}
