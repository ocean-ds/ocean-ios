// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - JSON Files
extension Ocean {
// swiftlint:disable identifier_name line_length number_separator type_body_length
public struct shadow {
  public typealias ShadowParameters = [String : Any]
  ///public static let shadowLevel1 : ShadowParameters = ["x": 0, "y": 4, "radius": 8, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  public static let shadowLevel1 : ShadowParameters = ["x": 0, "y": 4, "radius": 8, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  ///public static let shadowLevel2 : ShadowParameters = ["x": 0, "y": 8, "radius": 16, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  public static let shadowLevel2 : ShadowParameters = ["x": 0, "y": 8, "radius": 16, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  ///public static let shadowLevel3 : ShadowParameters = ["x": 0, "y": 16, "radius": 32, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  public static let shadowLevel3 : ShadowParameters = ["x": 0, "y": 16, "radius": 32, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  ///public static let shadowLevel4 : ShadowParameters = ["x": 0, "y": 16, "radius": 48, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
  public static let shadowLevel4 : ShadowParameters = ["x": 0, "y": 16, "radius": 48, "red": 12,"green": 13,"blue": 20,"alpha": 0.08]
}
}
extension UIView {
  public func applyShadow(parameters: Ocean.shadow.ShadowParameters){
      self.layer.shadowOffset = CGSize(width: parameters["x"] as! Int, height: parameters["y"] as! Int)
      self.layer.shadowRadius = CGFloat(parameters["radius"] as! Int)
      let color = UIColor(red: CGFloat(parameters["red"] as! Int) / 255,
                        green: CGFloat(parameters["green"] as! Int)  / 255,
                        blue: CGFloat(parameters["blue"] as! Int) / 255,
                        alpha: CGFloat(parameters["alpha"] as! Double))
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOpacity = 1
  }
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
