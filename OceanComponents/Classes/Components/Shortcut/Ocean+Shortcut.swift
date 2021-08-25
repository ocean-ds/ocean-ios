//
//  Ocean+Shortcut.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens

extension Ocean {
    public class Shortcut: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
        struct Constants {
            static let widht: CGFloat = 104
            static let height: CGFloat = 96
        }
        
        private var data: [ShortcutModel] = []
        
        public var onTouch: ((Int) -> Void)?
        
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
            return collection
        }()
        
        public func addData(with data: [ShortcutModel], quantityPage: CGFloat = 3) {
            let carouselLayout = UICollectionViewFlowLayout()
            carouselLayout.scrollDirection = .horizontal
            carouselLayout.minimumLineSpacing = Ocean.size.spacingStackXxs
            let width = frame.width - (Ocean.size.spacingStackXs * 2) - (Ocean.size.spacingStackXxs * (quantityPage - 1))
            let tryWidth = width / quantityPage
            let widthItem = tryWidth > Constants.widht ? tryWidth : Constants.widht
            carouselLayout.itemSize = .init(width: widthItem,
                                            height: Constants.height)
            carouselLayout.sectionInset = .init(top: 0,
                                                left: Ocean.size.spacingStackXs,
                                                bottom: 0,
                                                right: Ocean.size.spacingStackXs)
            
            carouselCollectionView.collectionViewLayout = carouselLayout
            
            self.data = data
            carouselCollectionView.reloadData()
        }
        
        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.height)
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
        }
        
        private func setupCollectionView() {
            addSubview(carouselCollectionView)
            
            NSLayoutConstraint.activate([
                carouselCollectionView.topAnchor.constraint(equalTo: topAnchor),
                carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
                carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
                carouselCollectionView.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        }
        
        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortcutCell.cellId, for: indexPath) as? ShortcutCell else { return UICollectionViewCell() }

            cell.image = self.data[indexPath.row].image
            cell.title = self.data[indexPath.row].title
            cell.isHighlight = self.data[indexPath.row].isHighlight

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
