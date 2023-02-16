//
//  Ocean+Tag.swift
//  OceanComponents
//
//  Created by Vini on 03/09/21.
//

import OceanTokens

extension Ocean {
    public class Tag: UIView {
        struct Constants {
            static let height: CGFloat = 20
            static let imageSize: CGFloat = 16
        }

        public typealias TagBuilder = (Tag) -> Void

        public enum Status {
            case positive
            case warning
            case negative
            case complementary
            case neutral
        }
        
        public enum TagType {
            case base
            case highlight
        }

        public var status: Status = .neutral {
            didSet {
                updateStatus()
            }
        }
        
        public var tagType: TagType = .base {
            didSet {
                updateStatus()
            }
        }

        public var image: UIImage? {
            didSet {
                updateUI()
            }
        }

        public var imageStatus: Bool = false {
            didSet {
                guard imageStatus else { return }
                switch self.status {
                case .positive:
                    self.image = Ocean.icon.checkCircleSolid
                case .warning:
                    self.image = Ocean.icon.exclamationCircleSolid
                case .negative:
                    self.image = Ocean.icon.xCircleSolid
                default: break
                }
            }
        }

        public var title: String = "" {
            didSet {
                updateUI()
            }
        }

        private lazy var imageView: UIImageView = {
            UIImageView { view in
                view.contentMode = .scaleAspectFit
                view.tintColor = Ocean.color.colorInterfaceDarkUp
                view.isHidden = true
                view.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: Constants.imageSize),
                    view.heightAnchor.constraint(equalToConstant: Constants.imageSize)
                ])
            }
        }()

        private lazy var titleLabel: UILabel = {
            UILabel { label in
                label.font = .baseSemiBold(size: Ocean.font.fontSizeXxxs)
                label.text = ""
                label.textColor = Ocean.color.colorInterfaceDarkUp
                label.translatesAutoresizingMaskIntoConstraints = false
            }
        }()

        private lazy var imageSpacer = Ocean.Spacer(space: Ocean.size.spacingStackXxxs)

        private lazy var mainStack: Ocean.StackView = {
            let stack = Ocean.StackView()
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false

            stack.add([
                Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                imageView,
                Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                titleLabel,
                Ocean.Spacer(space: Ocean.size.spacingStackXxxs),
                imageSpacer
            ])

            return stack
        }()

        public convenience init(builder: TagBuilder) {
            self.init()
            setupUI()
            builder(self)
        }

        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.cornerRadius = Constants.height * Ocean.size.borderRadiusCircular
            self.backgroundColor = Ocean.color.colorInterfaceLightUp
            self.add(view: mainStack)

            self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }

        private func updateUI() {
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = image == nil
            imageSpacer.isHidden = image != nil
            titleLabel.text = title
        }

        private func updateStatus() {
            switch self.status {
            case .positive:
                self.backgroundColor = Ocean.color.colorStatusPositiveUp
                self.imageView.tintColor = Ocean.color.colorStatusPositiveDeep
                self.titleLabel.textColor = Ocean.color.colorStatusPositiveDeep
            case .warning:
                self.backgroundColor = Ocean.color.colorStatusNeutralUp
                self.imageView.tintColor = Ocean.color.colorStatusNeutralDeep
                self.titleLabel.textColor = Ocean.color.colorStatusNeutralDeep
            case .negative:
                self.backgroundColor = Ocean.color.colorStatusNegativeUp
                self.imageView.tintColor = Ocean.color.colorStatusNegativePure
                self.titleLabel.textColor = Ocean.color.colorStatusNegativePure
            case .complementary:
                self.backgroundColor = Ocean.color.colorComplementaryPure.withAlphaComponent(Ocean.size.opacityLevelSemitransparent)
                self.imageView.tintColor = Ocean.color.colorComplementaryPure
                self.titleLabel.textColor = Ocean.color.colorComplementaryPure
            default:
                self.backgroundColor = Ocean.color.colorInterfaceLightUp
                self.imageView.tintColor = Ocean.color.colorInterfaceDarkUp
                self.titleLabel.textColor = Ocean.color.colorInterfaceDarkUp
            }
        }
        
        private func updateType() {
            switch self.tagType {
            case .highlight:
                self.backgroundColor = Ocean.color.colorHighlightPure
                self.titleLabel.textColor = Ocean.color.colorInterfaceDarkUp
            default:
                self.status = .neutral
            }
        }

        public func setSkeleton() {
            self.isSkeletonable = true
        }
    }
}
