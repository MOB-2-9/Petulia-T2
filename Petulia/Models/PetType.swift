//
//  PetType.swift
//  Petulia
//
//  Created by Johandre Delgado on 24.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation

enum PetType {
  case dog, cat, bird, smallFurry, rabbit, horse, barnyard, scalesFinsOther
  
  var id: Int {
    get {
      switch self {
      case .dog: return 0
      case .cat: return 1
      case .bird: return 2
      case .smallFurry: return 3
      case .rabbit: return 4
      case .horse: return 5
      case .barnyard: return 6
      case .scalesFinsOther: return 7
      }
    }
  }
  
  var name: String {
    get {
      switch self {
      case .dog: return "dogs"
      case .cat: return "cats"
      case .bird: return "birds"
      case .smallFurry: return "furries"
      case .rabbit: return "rabbits"
      case .horse: return "horses"
      case .barnyard: return "farmies"
      case .scalesFinsOther: return "exotic"
      }
    }
  }
  
  var endPoint: String {
    get {
      switch self {
      case .dog: return "dog"
      case .cat: return "cat"
      case .bird: return "bird"
      case .smallFurry: return "small-furry"
      case .rabbit: return "rabbit"
      case .horse: return "horse"
      case .barnyard: return "barnyard"
      case .scalesFinsOther: return "scales-fins-other"
      }
    }
  }
  
  var iconName: String {
    get {
      switch self {
      case .dog: return "dog"
      case .cat: return "cat"
      case .bird: return "bird"
      case .smallFurry: return "hamster"
      case .rabbit: return "rabbit"
      case .horse: return "horse"
      case .barnyard: return "pig"
      case .scalesFinsOther: return "gecko"
      }
    }
  }
  
  static var allPetTypes: [PetType] {
    get {
      return [.dog, .cat, .bird, .smallFurry, .rabbit, .horse, .barnyard, .scalesFinsOther]
    }
  }
  
  init(animalTypeName: String) {
    switch animalTypeName {
    case "dog", "dogs":
      self = .dog
    case "cat", "cats":
      self = .cat
    case "bird", "birds":
      self = .bird
    case "small-furry", "furries":
      self = .smallFurry
    case "rabbit", "rabbits":
      self = .rabbit
    case "horse", "horses":
      self = .horse
    case "barnyard", "farmies":
      self = .barnyard
    case "scales-fins-other", "exotic":
      self = .scalesFinsOther
    default:
      self = .dog
    }
  }
}
