//
//  UIApplication+Extension.swift
//  Petulia
//
//  Created by Johan on 19.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
  static var appBuildNumber: String? {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }
  
  static var appVersionNumber: String? {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
  
  /// dismiss keyboard for search bar
  /// Source: https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui
  func endEditing(_ force: Bool) {
      self.windows
          .filter{$0.isKeyWindow}
          .first?
          .endEditing(force)
  }
}
