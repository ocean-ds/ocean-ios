//
//  TooltipButton.swift
//  Blu
//
//  Created by Lucas Silveira on 10/07/20.
//  Copyright © 2020 Blu. All rights reserved.
//

import UIKit
import OceanTokens

struct TooltipButtonMeasure {
    static let triangleWidth: CGFloat = 22
    static let triangleHeight: CGFloat = 17
    static let triangleRadius: CGFloat = 2
    static let closeButtonWidthHeight: CGFloat = 16
    static let defaultNumberOfLines: Int = 3
    static let alphaFull: CGFloat = 1
//    static let hal
}

class TooltipButton: UIControl {
    private var container: UIStackView!
    private var bgView: UIView!
    private var triangleView: UIView!
    private var buttonClose: UIButton!
    private var labelTitle: UILabel!
    private var clipboardText: UILabel!
    private let height: CGFloat = 107.61
    private let triagleHeight: CGFloat = 8.61
    private let rectangleHeight: CGFloat = 99
    private let defaultTriangleMeause = {

    }

    public var title: String = "Tooltip title" {
        didSet {
            labelTitle.text = title
        }
    }

    public var textDescription: String = "Tooltip description here" {
        didSet {
            clipboardText.text = textDescription
        }
    }

    public var onTouch: (() -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeViews()
    }

    public convenience init(builder: ((TooltipButton) -> Void)?) {
        self.init(frame: .zero)
        builder?(self)
    }

    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: width / 2, y: height)
        let point3 = CGPoint(x: -width / 2, y: height)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: 0)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: 0)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: 0)
        path.closeSubpath()

        return path
    }

    fileprivate func makeTriangle() {
        triangleView = UIView()
        triangleView.backgroundColor = .clear
        triangleView.translatesAutoresizingMaskIntoConstraints = false

        let cgPath = createRoundedTriangle(width: TooltipButtonMeasure.triangleWidth,
                                           height: TooltipButtonMeasure.triangleHeight,
                                           radius: TooltipButtonMeasure.triangleRadius)
        let path = UIBezierPath(cgPath: cgPath)

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = Ocean.color.colorInterfaceDarkDeep.cgColor

        triangleView.layer.insertSublayer(shape, at: 0)
        triangleView.isUserInteractionEnabled = false
    }

    fileprivate func makeTitle() {
        labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont(name: Ocean.font.fontFamilyBaseWeightBold, size: Ocean.font.fontSizeXxs)
        labelTitle.textColor = Ocean.color.colorInterfaceLightDown
        labelTitle.text = title
    }

    fileprivate func makeCloseButton() {
        let image = R.image.iconClose()?.withRenderingMode(.alwaysTemplate)
        buttonClose = UIButton(type: .custom)
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(image, for: .normal)
        buttonClose.tintColor = Ocean.color.colorInterfaceLightPure
        buttonClose.widthAnchor.constraint(equalToConstant: TooltipButtonMeasure.closeButtonWidthHeight).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: TooltipButtonMeasure.closeButtonWidthHeight).isActive = true
        buttonClose.isUserInteractionEnabled = true
    }

    fileprivate func makeClipboardText() {
        clipboardText = UILabel()
        clipboardText.translatesAutoresizingMaskIntoConstraints = false
        clipboardText.font = UIFont(name: Ocean.font.fontFamilyBaseWeightRegular, size: Ocean.font.fontSizeXxs)
        clipboardText.textColor = Ocean.color.colorInterfaceLightDeep
        clipboardText.numberOfLines = TooltipButtonMeasure.defaultNumberOfLines
        clipboardText.isUserInteractionEnabled = true
        clipboardText.text = textDescription
    }

    fileprivate func makeContainerBase() {
        makeTriangle()
        self.addSubview(triangleView)

        container = UIStackView()
        container.alignment = .fill
        container.distribution = .fill
        container.axis = .horizontal
        container.translatesAutoresizingMaskIntoConstraints = false

        bgView = UIView()
        bgView.backgroundColor = Ocean.color.colorInterfaceDarkDeep
        bgView.layer.cornerRadius = 4
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(container)

        self.addSubview(bgView)
    }

    fileprivate func makeComponents() {
        makeContainerBase()
        container.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
        container.addArrangedSubview(UIStackView { stack in
            stack.alignment = .fill
            stack.distribution = .fill
            stack.axis = .vertical
            stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
            stack.addArrangedSubview(UIStackView { stack in
                stack.alignment = .fill
                stack.distribution = .fill
                stack.axis = .vertical

                stack.addArrangedSubview(UIStackView { stack in
                    stack.axis = .horizontal
                    stack.alignment = .center
                    stack.distribution = .fillProportionally

                    makeTitle()
                    stack.addArrangedSubview(labelTitle)
                    stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))

                    stack.addArrangedSubview(UIStackView { stack in
                        stack.axis = .vertical
                        stack.alignment = .trailing
                        stack.backgroundColor = .red

                        makeCloseButton()
                        stack.addArrangedSubview(buttonClose)
                        stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXxs))
                    })
                })

                makeClipboardText()
                stack.addArrangedSubview(clipboardText)

            })
            stack.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))

        })
        container.addArrangedSubview(Spacer(space: Ocean.size.spacingStackXs))
    }

    @objc func touchDown() {
        self.clipboardText.alpha = 0.8
    }

    @objc func touchUpInside() {
        self.clipboardText.alpha = 1
        self.handleTouch()
    }

    @objc func closeTouchDown() {
        self.buttonClose.alpha = 0.8
    }

    @objc func closeTouchUpInside() {
        self.buttonClose.alpha = 1
        self.close()
    }

    private func updateBackgroundColor(_ color: UIColor, time: Double = 0.3) {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: time) {
            self.backgroundColor = color
        }
    }

    fileprivate func configStyle() {
        self.layer.cornerRadius = Ocean.size.borderRadiusCircular * height
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func addTouchActions() {
        buttonClose.addTarget(self, action: #selector(closeTouchDown), for: .touchDown)
        buttonClose.addTarget(self, action: #selector(closeTouchUpInside), for: .touchUpInside)

        let touchDownGesture = UITapGestureRecognizer(target: self, action: #selector(touchDown))
        let touchUpInsideGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpInside))
        clipboardText.addGestureRecognizer(touchDownGesture)
        clipboardText.addGestureRecognizer(touchUpInsideGesture)
    }

    fileprivate func addConstraints() {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true

        triangleView.heightAnchor.constraint(equalToConstant: triagleHeight).isActive = true
        triangleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        triangleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        bgView.topAnchor.constraint(equalTo: triangleView.bottomAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: rectangleHeight).isActive = true

        container.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: bgView.leftAnchor).isActive = true
    }

    fileprivate func makeViews() {
        makeComponents()
        configStyle()
        addTouchActions()
        addConstraints()
    }

    fileprivate func close() {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.isHidden = true
        })
    }

    fileprivate func handleTouch() {
        UIView.transition(with: self, duration: 0.1, options: .curveEaseIn, animations: {
            self.onTouch?()
            self.isHidden = true
        })
    }

    fileprivate func updateButtonState() {
        clipboardText.alpha = 0.8
    }
}
