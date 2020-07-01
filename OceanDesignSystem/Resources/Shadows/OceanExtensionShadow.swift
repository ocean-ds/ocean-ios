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
  ///public static let shadowLevel1 = ShadowParameters(offset:CGSize(width: 0, height: 4), radiusBlur: 8, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  public static let shadowLevel1 = ShadowParameters(offset:CGSize(width: 0, height: 4), radiusBlur: 8, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  ///public static let shadowLevel2 = ShadowParameters(offset:CGSize(width: 0, height: 8), radiusBlur: 16, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  public static let shadowLevel2 = ShadowParameters(offset:CGSize(width: 0, height: 8), radiusBlur: 16, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  ///public static let shadowLevel3 = ShadowParameters(offset:CGSize(width: 0, height: 16), radiusBlur: 32, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  public static let shadowLevel3 = ShadowParameters(offset:CGSize(width: 0, height: 16), radiusBlur: 32, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  ///public static let shadowLevel4 = ShadowParameters(offset:CGSize(width: 0, height: 16), radiusBlur: 48, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))
  public static let shadowLevel4 = ShadowParameters(offset:CGSize(width: 0, height: 16), radiusBlur: 48, shadowColor: UIColor(red: 12 / 255, green: 13 / 255, blue: 20 / 255, alpha: 0.08))

  public struct ShadowParameters {
      public let offset : CGSize
      public let radiusBlur: CGFloat
      public let shadowColor: UIColor
      public init(offset: CGSize, radiusBlur: CGFloat, shadowColor: UIColor) {
          self.offset = offset
          self.radiusBlur = radiusBlur
          self.shadowColor = shadowColor
      }
  }
}
}
extension UIView {
  func applyShadow(parameters: Ocean.shadow.ShadowParameters){
      self.layer.shadowOffset = parameters.offset
      self.layer.shadowRadius = parameters.radiusBlur
      self.layer.shadowColor = parameters.shadowColor.cgColor
      self.layer.shadowOpacity = 1
  }
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
