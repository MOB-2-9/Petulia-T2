//
//  Constants.swift
//  Petulia
//
//  Created by Johan on 18.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Foundation

enum Constants {
  static let screenWidth = UIScreen.main.bounds.width
  static let screenHeight = UIScreen.main.bounds.height
  static var recommendedPets: [PetDetailViewModel] = []
}

enum Keys {
  // Theme
  static var prefferedAccentColor = "prefferedAccentColor"
  static var isDark = "isDark"
  
  // URLs
  static var baseURLPath = "api.petfinder.com"
//  static var baseURLPath = "https://api.petfinder.com"
  static var tokenPath = "/v2/oauth2/token"
  static var allAnimalsPath = "/v2/animals"
  static var allTypesPath = "/v2/types"
  
  // Search
  static var showOnlyPostWithImages = "showOnlyWithImages"
  static var savedPostcode = "postcode"
  static var savedPetTypeID = "savedPetTypeID"
  static var tokenExpiration = "tokenExpiration"
  static var tokenKey = "tokenKey"
  
  // Credits
  static var author = "Johandre Delgado"
  static var authorWebsite = "https://www.seadeveloper.com"
  static var authorQuote = "Because caring is loving"
  
  //Customer
  static let currentUser = "currentUser"
  //Customer properties
  static let userId = "userId"
  static let name = "name"
  static let email = "email"
}

enum AnimalKeys {
  static let id = "id"
  static let urlString = "urlString"
  static let name = "name"
  static let species = "species"
  static let breed = "breed"
  static let size = "size"
  static let age = "age"
  static let tags = "tags"
  static let attributes = "attributes"
  static let description = "description"
  static let photos = "photos"
  static let gender = "gender"
  static let status = "status"
  static let distance = "distance"
  static let shelterId = "shelterId"
  static let postedDate = "postedDate"
  static let contact = "contact"
}

extension AnimalKeys {
  enum Photos {
    static let smallPhoto = "smallPhoto"
    static let mediumPhoto = "mediumPhoto"
    static let largePhoto = "largePhoto"
    static let fullPhoto = "fullPhoto"
  }
  
  enum Contact {
    static let email = "email"
    static let phone = "phone"
  }
}
