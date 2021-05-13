//
//  FavoriteController.swift
//  Petulia
//
//  Created by Johandre Delgado on 27.11.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

class FavoriteController: ObservableObject {
  @Published private(set) var list = [PetDetailViewModel]()
  @Published var errorMessage: AlertMessage?
  
  private var storage: StorageService
  
  init(storage: StorageService = StorageService()) {
    self.storage = storage
    load()
  }
  
  func load() {
    CustomerService.loadUserFavoritePets { pets, alertError in
      if let alertError = alertError {
        self.handleAlertError(alertError: alertError)
        return
      }
      self.list = pets
    }
  }
  
  func addToFavorite(pet: PetDetailViewModel) {
    guard !list.contains(pet) else { return }
    list.insert(pet, at: 0)
    CustomerService.addUserFavoritePets(pet: pet) { alertError in
      if let alertError = alertError {
        self.handleAlertError(alertError: alertError)
        return
      }
    }
  }
  
  func removeFromFavorite(pet: PetDetailViewModel) {
    if let index = list.firstIndex(of: pet) {
      list.remove(at: index)
      CustomerService.removeUserFavoritePets(petId: "\(pet.id)") { alertError in
        if let alertError = alertError {
          self.handleAlertError(alertError: alertError)
          return
        }
      }
    }
  }
  
  func isFavorite(pet: PetDetailViewModel) -> Bool {
    return list.contains(pet)
  }
  
  func swipeBookmark(for pet: PetDetailViewModel) {
    if isFavorite(pet: pet) {
      removeFromFavorite(pet: pet)
    } else {
      addToFavorite(pet: pet)
    }
  }
}

//MARK: FavoriteController Helpers
extension FavoriteController {
  func handleAlertError(alertError: AlertError) {
      errorMessage = AlertMessage.alertError(alertError: alertError)
  }
}
