//
//  Ocean+Shortcut.swift
//  OceanComponents
//
//  Created by Vini on 23/08/21.
//

import OceanTokens
import SkeletonView

extension Ocean {
    public class Shortcut: UIView {

        struct Constants {
            static let minHeightTinyVertical: CGFloat = 80
            static let minHeightTinyHorizontal: CGFloat = 56
            static let minHeightSmall: CGFloat = 104
            static let minHeightMediumVertical: CGFloat = 131
            static let minHeightMediumHorizontal: CGFloat = 100

            static let interItemSpacing: CGFloat = Ocean.size.spacingStackXxs
            static let lineSpacing: CGFloat = Ocean.size.spacingStackXxs
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

        // MARK: Public properties

        public var size: Size = .small

        public var orientation: Orientation = .vertical

        public var onTouch: ((Int) -> Void)?

        private var data: [ShortcutModel] = []

        // MARK: Private properties

        // MARK: Views

        private lazy var contentStack: Ocean.StackView = {
            Ocean.StackView { stack in
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fill
                stack.spacing = Shortcut.Constants.lineSpacing
                stack.isSkeletonable = true
            }
        }()

        public func set(data: [ShortcutModel], cols: Int = 2) {
            self.data = data
            contentStack.removeAllArrangedSubviews()

            let chunks = data.chunks(ofCount: cols)
            chunks.forEach { items in
                let stack = Ocean.StackView { stack in
                    stack.translatesAutoresizingMaskIntoConstraints = false
                    stack.axis = .horizontal
                    stack.distribution = .fillEqually
                    stack.alignment = .fill
                    stack.spacing = Shortcut.Constants.interItemSpacing
                    stack.isSkeletonable = true
                }

                items.forEach { model in
                    let view = Ocean.ShorcutItem(orientation: orientation, size: size)
                    view.model = model
                    view.onTouch = tapped(model:)

                    stack.addArrangedSubview(view)
                }

                for _ in items.count..<cols {
                    stack.addArrangedSubview(UIView())
                }

                stack.oceanConstraints
                    .height(constant: getItemMinHeight(), type: .greaterThanOrEqualTo)
                    .make()

                contentStack.addArrangedSubview(stack)
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
            isSkeletonable = true
            backgroundColor = .clear

            addSubview(contentStack)

            contentStack.oceanConstraints
                .fill(to: self)
                .make()
        }

        public func getItemMinHeight() -> CGFloat {
            switch size {
            case .tiny:
                return orientation == .horizontal
                ? Shortcut.Constants.minHeightTinyHorizontal
                : Shortcut.Constants.minHeightTinyVertical
            case .small:
                return Shortcut.Constants.minHeightSmall
            case .medium:
                return orientation == .horizontal
                ? Shortcut.Constants.minHeightMediumHorizontal
                : Shortcut.Constants.minHeightMediumVertical
            }
        }

        private func tapped(model: ShortcutModel) {
            guard let index = data.firstIndex(where: { $0 == model }) else {
                return
            }

            onTouch?(index)
        }
    }
}
