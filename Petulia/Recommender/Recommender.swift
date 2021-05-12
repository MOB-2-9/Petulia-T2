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
  
  var animalType: AnimalType
  var score: Double
  
  init(name: String, score: Double) {
    self.animalType = AnimalType(rawValue: name)!
    self.score = score
  }
}

enum AnimalType: String {
  case dogs, cats, birds, furries, rabbits, horses, farmies, exotic
}

public class Recommender: ObservableObject {
  
  @Published var petScores = [PetScore]()
  
  init() {
    load()
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
      
      for name in result.recommendations {
        let score = result.scores[name] ?? 0
        tempPetScores.append(PetScore(name: name, score: score))
      }
      self.petScores = tempPetScores
    } catch(let error) {
      print("error is \(error.localizedDescription)")
    }
  }
}
