//
//  RecommendedPetDataController.swift
//  Petulia
//
//  Created by Mark Kim on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import Combine

final class RecommendedPetDataController: ObservableObject {
  
  @Published private(set) var allPets: [PetDetailViewModel] = []
  @Published private(set) var isLoading: Bool = false
  
  var topRecommendations = Recommender()
  
  private let apiService: NetworkService
  //  private(set) var pagination: PaginationDTO
  
  init(apiService: NetworkService = APIService()) {
    self.apiService = apiService
  }
  
  func requestPets() {
    
    var petTypeAndScore: [PetScore] = topRecommendations.petScores
    petTypeAndScore.sort { $0.score > $1.score }
    
    isLoading = true
    if let petType = petTypeAndScore.first {
      APIService.getRecommended(firstPetType: petType.petType, secondPetType: .cat, thirdPetType: .bird) { (pets, error) in
        if let error = error {
          print(error)
        } else {
          self.allPets = pets
          DispatchQueue.main.async {
            self.isLoading = false
          }
        }
      }
    } else {
      isLoading = false
    }
  }
}
