//
//  CollectionKeys.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

let db = Firestore.firestore()
let auth = Auth.auth()

enum CollectionKeys {
  static var users = "Users"
  
  enum Users {
    static let favoritePets = "FavoritePets"
  }
}
