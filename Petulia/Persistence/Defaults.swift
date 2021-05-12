//
//  Defaults.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseAuth

struct Defaults {
  enum Keys {
    static let onboard = "onboard"
    static let currentUser = "currentUser"
    static let petScores = "petScores"
  }
  
  //MARK: Methods
  
  ///use after logging out
  static func removeUser(_ removeFromUserDefaults: Bool = false) {
    if removeFromUserDefaults {
      //clear everything in UserDefaults except for onboard
      UserDefaults.standard.deleteAllKeys(exemptedKeys: [Keys.onboard])
    }
  }
  
  static func incrementPetType(petType: String) {
    let petTypeKey = petType.lowercased()
    guard var petScores = UserDefaults.standard.dictionary(forKey: Keys.petScores) as? [String: Double] else {
      UserDefaults.standard.set([petTypeKey: -1.0], forKey: Keys.petScores)
      return
    }
    if let score = petScores[petTypeKey] {
      petScores[petTypeKey] = score - 1
    } else {
      petScores[petTypeKey] = -1
    }
    UserDefaults.standard.set(petScores, forKey: Keys.petScores)
  }
}
