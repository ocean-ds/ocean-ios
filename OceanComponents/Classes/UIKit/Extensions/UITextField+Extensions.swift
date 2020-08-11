//
//  TextArea+Extensions.swift
//  OceanComponents
//
//  Created by Alex Gomes on 07/08/20.
//
import UIKit

extension UITextField {

  enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
  }

  func underlined(_ width: CGFloat? = 30.0) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: self.bounds.height * 1.5, width: (width! - 50.0), height: 1)
    bottomLine.backgroundColor = UIColor.cyan.cgColor
    self.borderStyle = UITextField.BorderStyle.none
    self.layer.addSublayer(bottomLine)
  }

  @IBAction func toogleSecureTextEntry(_ sender: UIButton) {
    let secureTextEntry = !self.isSecureTextEntry
    self.isSecureTextEntry = secureTextEntry

    sender.setImage(UIImage(named: secureTextEntry ? "eye-hide-small" : "eye-small"), for: .normal)

    var width = CGFloat(21.29)
    var height = CGFloat(21.29)

    if secureTextEntry {
      width = CGFloat(20.83)
      height = CGFloat(13.28)
    }

    sender.frame = CGRect(
      x: CGFloat(self.frame.size.width - 25),
      y: CGFloat(5),
      width: width,
      height: height
    )
  }

  func addShowHidePassword() {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "eye-hide-small"), for: .normal)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 20)
    button.frame = CGRect(
      x: CGFloat(self.frame.size.width - 25),
      y: CGFloat(5),
      width: CGFloat(21.29),
      height: CGFloat(21.29)
    )
    button.addTarget(self, action: #selector(self.toogleSecureTextEntry), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
  }

  func addAccessoryView(withButton button: UIBarButtonItem, withViewWidth width: CGFloat) {
    let bar = UIToolbar()
    bar.barTintColor = #colorLiteral(red: 0.1211657003, green: 0.1330806613, blue: 0.1497248709, alpha: 1)
    bar.backgroundColor = #colorLiteral(red: 0.1211657003, green: 0.1330806613, blue: 0.1497248709, alpha: 1)

    button.tintColor = .white
    button.isEnabled = false
    let flexibleSpace = UIBarButtonItem(
      barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
      target: nil,
      action: nil
    )
    bar.items = [flexibleSpace, button, flexibleSpace]
    bar.sizeToFit()

    let lineView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
    lineView.backgroundColor = UIColor.cyan.withAlphaComponent(1)
    bar.addSubview(lineView)

    self.inputAccessoryView = bar
  }

  fileprivate func addLineConstraints(_ metrics: [String: NSNumber], _ views: [String: UIView]) {
    self.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[lineView]|",
      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
      metrics: metrics,
      views: views)
    )
  }

  fileprivate func addLineChecks(_ position: UITextField.LINE_POSITION,
                                 _ metrics: [String: NSNumber],
                                 _ views: [String: UIView]) {
    switch position {
    case .LINE_POSITION_TOP:
      self.addConstraints(NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[lineView(width)]",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: metrics,
        views: views)
      )
      break
    case .LINE_POSITION_BOTTOM:
      self.addConstraints(NSLayoutConstraint.constraints(
        withVisualFormat: "V:[lineView(width)]|",
        options: NSLayoutConstraint.FormatOptions(rawValue: 0),
        metrics: metrics,
        views: views)
      )
      break
    }
  }

  func addLineToView(position: LINE_POSITION, color: UIColor, width: Double) {
    let lineView = UIView()
    lineView.backgroundColor = color
    lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
    self.addSubview(lineView)

    let metrics = ["width": NSNumber(value: width)]
    let views = ["lineView": lineView]
    addLineConstraints(metrics, views)
    addLineChecks(position, metrics, views)
  }

  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      let value = self.placeholder != nil ? self.placeholder! : ""
      self.attributedPlaceholder = NSAttributedString(
        string: value,
        attributes: [NSAttributedString.Key.foregroundColor: newValue!]
      )
    }
  }
}
