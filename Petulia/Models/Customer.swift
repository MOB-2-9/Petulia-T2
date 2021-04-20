//
//  Customer.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseFirestore

struct Customer: Codable {
  
  private(set) var userId: String!
  private(set) var name: String
  private(set) var email: String
  
  var asDictionary: [String: Any] {
    get {
      let userDic: [String: Any] = [
        Keys.userId: userId!,
        Keys.name: name,
        Keys.email: email,
      ]
      return userDic
    }
  }
  
  //MARK: Singleton
  private static var _current: Customer?
  
  static var current: Customer? {
    // Check if current user (tenant) exist
    if let currentUser = _current {
      return currentUser
    } else {
      // Check if the user was saved in UserDefaults. If not, return nil
      guard let user = UserDefaults.standard.getStruct(Customer.self, forKey: Keys.currentUser) else { return nil }
      _current = user
      return user
    }
  }
  
  //MARK: Initializers
  
  ///initializer for signing up a Customer
  init(userId: String, name: String, email: String) {
    self.userId = userId
    self.name = name
    self.email = email
  }
  
  /// Initializer for loading user from a Firebase document
  init?(document: DocumentSnapshot) {
    self.userId = document.documentID
    guard let dict = document.data(),
          let name = dict[Keys.name] as? String,
          let email = dict[Keys.email] as? String
    else { return nil }
    self.name = name
    self.email = email
  }
}

// MARK: - Static Methods
extension Customer {
  static func setCurrent(_ user: Customer, writeToUserDefaults: Bool = false) {
    // Save user's information in UserDefaults excluding passwords and sensitive (private) info
    if writeToUserDefaults {
      UserDefaults.standard.setStruct(user, forKey: Keys.currentUser)
    }
    _current = user
  }
  
  static func removeCurrent(_ removeFromUserDefaults: Bool = false) {
    if removeFromUserDefaults {
      Defaults.removeUser(true)
    }
    _current = nil
  }
}
