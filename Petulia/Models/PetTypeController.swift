//
//  PetTypeController.swift
//  Petulia
//
//  Created by Johandre Delgado on 27.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

class PetTypeController {
  private(set) var types: [PetType] = []
  private(set) var currentPetType: PetType  = .dog
  var currentEndPoint: String {
    currentPetType.endPoint
  }
  init() {
    types = createPetTypes()
    let savedPetTypeID = UserDefaults.standard.integer(forKey: Keys.savedPetTypeID)
    currentPetType = getPetType(by: savedPetTypeID) ?? .dog
    Defaults.incrementPetType(petType: currentPetType.name)
  }
  
  private func createPetTypes() -> [PetType] {
    return PetType.allPetTypes
  }
  
  func getPetType(by id: Int) -> PetType? {
    return types.first( where: { $0.id == id })
  }
  
  func set(to petType: PetType) {
    self.currentPetType = petType
    UserDefaults.standard.set(currentPetType.id, forKey: Keys.savedPetTypeID)
    Defaults.incrementPetType(petType: petType.name)
  }
}
