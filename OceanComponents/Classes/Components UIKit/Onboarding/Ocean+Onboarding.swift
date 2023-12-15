//
//  Ocean+Onboarding.swift
//  Charts
//
//  Created by Acassio Mendonça on 04/08/23.
//

import Foundation
import OceanTokens

extension Ocean {
    public class Onboarding: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        private let containerPageControlViewHeight: CGFloat = 48

        public struct PagesModel {
            var pages: [PageModel] = []
            var titleButton: String = ""
            var titleButtonLastPage: String = ""
            var actionLastPage: (() -> Void)?
            
            public init(pages: [PageModel],
                        titleButton: String,
                        titleButtonLastPage: String,
                        actionLastPage: (() -> Void)?) {
                self.pages = pages
                self.titleButton = titleButton
                self.titleButtonLastPage = titleButtonLastPage
                self.actionLastPage = actionLastPage
            }
            
            public static func empty() -> Self {
                return .init(pages: [],
                             titleButton: "",
                             titleButtonLastPage: "",
                             actionLastPage: nil)
            }
        }
        
        public struct PageModel {
            var image: UIImage
            var title: String
            var subtitle: String
            var linkText: String
            var linkAction: () -> Void
            
            public init(image: UIImage,
                        title: String,
                        subtitle: String,
                        linkText: String = "",
                        linkAction: @escaping () -> Void = { }) {
                self.image = image
                self.title = title
                self.subtitle = subtitle
                self.linkText = linkText
                self.linkAction = linkAction
            }
        }
        
        public var model: PagesModel = .empty() {
            didSet {
                updateUI()
            }
        }
        
        lazy var collection: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.isPagingEnabled = true
            collection.showsHorizontalScrollIndicator = false
            collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
            collection.dataSource = self
            collection.delegate = self
            collection.backgroundColor = .white
            
            return collection
        }()
        
        lazy var nextButton: Ocean.ButtonPrimary = {
            Ocean.Button.primaryMD { button in
                button.onTouch = nextButtonTapped
            }
        }()
        
        lazy var pageControlView: Ocean.CustomPageIndicator = {
            let view = Ocean.CustomPageIndicator()
            return view
        }()
        
        lazy var containerPageControlView: UIView = {
            let view = UIView()
            view.addSubview(pageControlView)
            
            return view
        }()
        
        lazy var bottomStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.alignment = .fill
            
            stack.add([
                containerPageControlView,
                nextButton
            ])
            
            stack.setMargins(horizontal: Ocean.size.spacingStackXs)
            
            return stack
        }()
        
        public override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            backgroundColor = .white
            addSubviews(collection)
            addSubviews(bottomStack)
            setupConstraints()
        }
        
        private func updateUI() {
            pageControlView.numberOfPages = model.pages.count
            nextButton.text = model.titleButton
            
            collection.reloadData()
        }
        
        private func setupConstraints() {
            collection.oceanConstraints
                .topToTop(to: self, safeArea: true)
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .bottomToTop(to: bottomStack)
                .make()
            
            containerPageControlView.oceanConstraints
                .height(constant: containerPageControlViewHeight)
                .make()
            
            pageControlView.oceanConstraints
                .centerX(to: containerPageControlView)
                .centerY(to: containerPageControlView)
                .make()
            
            bottomStack.oceanConstraints
                .leadingToLeading(to: self)
                .trailingToTrailing(to: self)
                .bottomToBottom(to: self, safeArea: true)
                .make()
        }
        
        private func nextButtonTapped() {
            let currentOffset = collection.contentOffset
            let nextPageOffset = CGPoint(x: currentOffset.x + collection.bounds.width, y: currentOffset.y)
            
            collection.setContentOffset(nextPageOffset, animated: true)
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model.pages.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier,
                                                          for: indexPath) as! OnboardingCell
            
            cell.configure(with: model.pages[indexPath.row])
            
            return cell
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth = scrollView.frame.size.width
            if pageWidth == 0 {
                return
            }
            let currentPageFloat = scrollView.contentOffset.x / pageWidth
            
            pageControlView.currentPage = currentPageFloat
            let lastPageIndex = model.pages.count - 1

            if currentPageFloat < CGFloat(lastPageIndex) {
                nextButton.text = model.titleButton
                nextButton.onTouch = nextButtonTapped
            } else if currentPageFloat == CGFloat(lastPageIndex) {
                nextButton.text = model.titleButtonLastPage
                nextButton.onTouch = model.actionLastPage
            }
        }
        
        // MARK: UICollectionViewDelegateFlowLayout
        
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cvRect = collectionView.frame
            
            return CGSize(width: cvRect.width, height: cvRect.height)
        }
    }
}
