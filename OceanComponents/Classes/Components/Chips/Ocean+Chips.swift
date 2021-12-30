//
//  Ocean+Chips.swift
//  OceanComponents
//
//  Created by Thomás Marques Brandão Reis on 08/12/21.
//

import Foundation
import UIKit
import OceanTokens
import SkeletonView

extension Ocean {
    public class Chips: UIView, SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        struct Constants {
            static let height: CGFloat = 34
        }

        private var data: [ChipModel] = []

        public var chipType: Ocean.ChipType = .choice

        public var isMultipleSelect = false
        public var allowDeselect = false

        public var onValueChange: ((Bool, ChipModel) -> Void)?
        public var onRemoved: ((ChipModel) -> Void)?

        private lazy var chipsCollectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
            collection.dataSource = self
            collection.delegate = self
            collection.isPrefetchingEnabled = false
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.isPagingEnabled = false
            collection.backgroundColor = .clear
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.isSkeletonable = true

            switch self.chipType {
            case .choice:
                collection.register(Ocean.ChipChoice.self, forCellWithReuseIdentifier: Ocean.ChipChoice.cellId)
            case .choiceWithIcon:
                collection.register(Ocean.ChipChoiceWithIcon.self, forCellWithReuseIdentifier: Ocean.ChipChoiceWithIcon.cellId)
            case .choiceWithBadge:
                collection.register(Ocean.ChipChoiceWithBagde.self, forCellWithReuseIdentifier: Ocean.ChipChoiceWithBagde.cellId)
            case .filter:
                collection.register(Ocean.ChipFilter.self, forCellWithReuseIdentifier: Ocean.ChipFilter.cellId)
            }
            return collection
        }()

        public override var intrinsicContentSize: CGSize {
            get {
                return CGSize(width: frame.width, height: Constants.height)
            }
        }

        // MARK: - Constructors

        public convenience init(builder: ChipsBuilder) {
            self.init()
            self.chipType = chipType
            setupUI()
            builder(self)
        }

        override public init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


        // MARK: - Public methods

        public func addData(with data: [ChipModel]) {
            let carouselLayout = UICollectionViewFlowLayout()
            carouselLayout.scrollDirection = .horizontal
            carouselLayout.minimumLineSpacing = Ocean.size.spacingStackXxs
            carouselLayout.sectionInset = .init(top: 0, left: Ocean.size.spacingStackXs, bottom: 0, right: Ocean.size.spacingStackXs)
            setupCollectionView()
            chipsCollectionView.collectionViewLayout = carouselLayout
            self.data = data
            chipsCollectionView.reloadData()
        }


        // MARK: - SkeletonCollectionViewDataSource

        public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
            1
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {

            switch self.chipType {
            case .choice:
                return Ocean.ChipChoice.cellId
            case .choiceWithIcon:
                return Ocean.ChipChoiceWithIcon.cellId
            case .choiceWithBadge:
                return Ocean.ChipChoiceWithBagde.cellId
            case .filter:
                return Ocean.ChipFilter.cellId
            }
        }

        // MARK: - UICollectionViewDataSource

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.data.count
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch self.chipType {
            case .choice:
                return createChipChoiceCell(indexPath: indexPath, collectionView: collectionView)
            case .choiceWithIcon:
                return createChipChoiceWithIconCell(indexPath: indexPath, collectionView: collectionView)
            case .choiceWithBadge:
                return createChipChoiceWithBadgeCell(indexPath: indexPath, collectionView: collectionView)
            case .filter:
                return createChipFilterCell(indexPath: indexPath, collectionView: collectionView)
            }
        }

        // MARK: - UICollectionViewDelegateFlowLayout

        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var widthItem = data[indexPath.row].title.size(withAttributes: nil).width
            switch self.chipType {
            case .choice:
                widthItem += 38
            case .choiceWithIcon:
                widthItem += 64
            case .choiceWithBadge:
                if let number = data[indexPath.row].number {
                    let numberWidth = String(number).size(withAttributes: nil)
                    widthItem += numberWidth.width + 54
                } else {
                    widthItem += 38
                }
            case .filter:
                widthItem += 56
            }
            return CGSize(width: widthItem, height: Constants.height)
        }

        // MARK: - Private methods

        private func setupUI() {
            backgroundColor = .clear
        }

        private func setupCollectionView() {

            addSubview(chipsCollectionView)

            NSLayoutConstraint.activate([
                chipsCollectionView.topAnchor.constraint(equalTo: topAnchor),
                chipsCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
                chipsCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
                chipsCollectionView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        }

        private func createChipChoiceCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Ocean.ChipChoice.cellId, for: indexPath) as? Ocean.ChipChoice else { return UICollectionViewCell() }
            cell.index = indexPath.row
            cell.allowDeselect = self.allowDeselect
            cell.text = data[cell.index].title
            cell.status = data[cell.index].status
            cell.onValueChange = { selected, chip in
                self.data[indexPath.row].status = chip.status
                self.onValueChange?(selected, self.data[chip.index])
                self.deselectOthers(current: chip.index)
            }
            return cell
        }

        private func createChipChoiceWithIconCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Ocean.ChipChoiceWithIcon.cellId, for: indexPath) as? Ocean.ChipChoiceWithIcon else { return UICollectionViewCell() }
            cell.index = indexPath.row
            cell.allowDeselect = self.allowDeselect
            cell.icon = data[cell.index].icon
            cell.text = data[cell.index].title
            cell.status = data[cell.index].status
            cell.onValueChange = { selected, chip in
                self.data[indexPath.row].status = chip.status
                self.onValueChange?(selected, self.data[chip.index])
                self.deselectOthers(current: chip.index)
            }
            return cell
        }

        private func createChipChoiceWithBadgeCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Ocean.ChipChoiceWithBagde.cellId, for: indexPath) as? Ocean.ChipChoiceWithBagde else { return UICollectionViewCell() }
            cell.index = indexPath.row
            cell.allowDeselect = self.allowDeselect
            cell.number = data[cell.index].number
            cell.text = data[cell.index].title
            cell.status = data[cell.index].status
            cell.onValueChange = { selected, chip in
                self.data[indexPath.row].status = chip.status
                self.onValueChange?(selected, self.data[chip.index])
                self.deselectOthers(current: chip.index)
            }
            return cell
        }

        private func createChipFilterCell(indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Ocean.ChipFilter.cellId, for: indexPath) as? Ocean.ChipFilter else { return UICollectionViewCell() }
            cell.text = data[indexPath.row].title
            cell.onClickIcon = { chip in
                let itemRemoved = self.data[indexPath.row]
                self.data.remove(at: indexPath.row)
                self.chipsCollectionView.reloadItems(at: [indexPath])
                self.onRemoved?(itemRemoved)
            }
            return cell
        }

        private func deselectOthers(current: Int) {
            if !isMultipleSelect {
                for (i, chipModel) in self.data.enumerated() {
                    if chipModel.status == .selected, i != current {
                        self.data[i].status = .normal
                    }
                }
                self.chipsCollectionView.reloadData()
            }
        }
    }
}
