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
  ///public static let shadowLevel1 : ShadowParameters = ["x": 0, "y": 4, "radius": 8, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  public static let shadowLevel1 : ShadowParameters = ["x": 0, "y": 4, "radius": 8, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  ///public static let shadowLevel2 : ShadowParameters = ["x": 0, "y": 8, "radius": 16, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  public static let shadowLevel2 : ShadowParameters = ["x": 0, "y": 8, "radius": 16, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  ///public static let shadowLevel3 : ShadowParameters = ["x": 0, "y": 16, "radius": 32, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  public static let shadowLevel3 : ShadowParameters = ["x": 0, "y": 16, "radius": 32, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  ///public static let shadowLevel4 : ShadowParameters = ["x": 0, "y": 16, "radius": 48, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
  public static let shadowLevel4 : ShadowParameters = ["x": 0, "y": 16, "radius": 48, "color": #colorLiteral(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08)]
}
}
extension UIView {
  public func applyShadow(parameters: Ocean.shadow.ShadowParameters){
      self.layer.shadowOffset = CGSize(width: parameters["x"] as! Int, height: parameters["y"] as! Int)
      self.layer.shadowRadius = CGFloat(parameters["radius"] as! Int)
      let color = parameters["color"] as! UIColor
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOpacity = 1
  }
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
