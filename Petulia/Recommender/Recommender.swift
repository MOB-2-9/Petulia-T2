//
//  Recommender.swift
//  Petulia
//
//  Created by Mark Kim on 5/5/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Combine
import CoreML

struct PetScore {
  
  var petType: PetType
  var score: Double
  
  init(animalTypeName: String, score: Double) {
    self.petType = PetType(animalTypeName: animalTypeName)
    self.score = score
  }
}
public class Recommender: ObservableObject {
  
  @Published var petScores = [PetScore]()
  
  init() {
    load()
    
//    var petTypeAndScore: [PetScore] = self.petScores
//    petTypeAndScore.sort { $0.score > $1.score }
//    
//    APIService.getRecommended(petType: petTypeAndScore[0].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 10 { break }
//        Constants.recommendedPets.append(pets[i])
//      }
//    }
//    
//    APIService.getRecommended(petType: petTypeAndScore[1].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 6 { break }
//        Constants.recommendedPets.append(pets[i])
//      }
//    }
//
//    APIService.getRecommended(petType: petTypeAndScore[2].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 5 { break }
//        Constants.recommendedPets.append(pets[i])
//      }
//    }
  }
  
  func load() {
    do {
      let recommender = PetRecommender_1()
      let scores: [String: Double] = UserDefaults.standard.dictionary(forKey: Defaults.Keys.petScores) as? [String: Double] ?? [:]
      /*
       items are the pets the machine is going to use to learn what to recomend
       k is the number of type of pets the code will return
       */
      let input = PetRecommender_1Input(items: scores, k: 3, restrict_: [], exclude: [])
      let result = try recommender.prediction(input: input)
      var tempPetScores = [PetScore]()
      
      for animalTypeName in result.recommendations {
        let score = result.scores[animalTypeName] ?? 0
        tempPetScores.append(PetScore(animalTypeName: animalTypeName, score: score))
      }
      self.petScores = tempPetScores
    } catch(let error) {
      print("error is \(error.localizedDescription)")
    }
  }
}
