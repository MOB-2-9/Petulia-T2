//
//  APIManager.swift
//  Petulia
//
//  Created by Johandre Delgado  on 02.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import Combine

protocol NetworkService {
  func isTokenValid() -> Bool
  func refreshAccessToken(completion: @escaping (() -> Void))
  func fetch<T: Decodable>( at endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void)
}

class APIService: NetworkService {
  
  private var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "Petfinder-Info", ofType: "plist") else {
      fatalError("Petfinder-Info file NOT found! Create it and add your API Key and Secret")
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let loadedKey = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("API_KEY NOT found in Petfinder-Info.plist")
    }
    
    if(loadedKey.starts(with: "_")) {
      fatalError("Register and get your own Petfinder API Key at: https://www.petfinder.com/developers/v2/docs/")
    }
    return loadedKey
  }
  
  private var secret: String {
    guard let filePath = Bundle.main.path(forResource: "Petfinder-Info", ofType: "plist") else {
      fatalError("Petfinder-Info file NOT found!")
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let loadedSecret = plist?.object(forKey: "API_SECRET") as? String else {
      fatalError("API_SECRET NOT found in Petfinder-Info.plist")
    }
    
    if(loadedSecret.starts(with: "_")) {
      fatalError("Register and get your own Petfinder API Secret at: https://www.petfinder.com/developers/v2/docs/")
    }
    return loadedSecret
  }
  
  private var token: String {
    get { UserDefaults.standard.string(forKey: Keys.tokenKey) ?? "" }
    set {  UserDefaults.standard.setValue(newValue, forKey: Keys.tokenKey) }
  }
  
  private var tokenExpirationDate: Date {
    get { UserDefaults.standard.object(forKey: Keys.tokenExpiration) as? Date ?? Date() }
    set { UserDefaults.standard.set(newValue, forKey: Keys.tokenExpiration) }
  }
  
  // To decode server answer to a token request
  private struct TokenResponse: Decodable {
    let token_type: String
    let expires_in: Int
    let access_token: String
  }
  
  func isTokenValid() -> Bool {
    let tokenDate = tokenExpirationDate
    let isValid = Date() < tokenDate && !token.isEmpty
    print("\n\(#function) = \(isValid)")
    return isValid
  }
  
  func refreshAccessToken(completion: @escaping (() -> Void)) {
    let tokenURL = EndPoint.tokenPath.urlString
    
    guard let url = EndPoint.tokenPath.url else {
      print("\(#function) - Error: Cannot create URL using - \(tokenURL)")
      return
    }
    
    let method = "POST"
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.httpBody = "grant_type=client_credentials&client_id=\(apiKey)&client_secret=\(secret)".data(using: .utf8)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if let response = response as? HTTPURLResponse {
        print("\(#function) - response: \(response.statusCode)")
      }
      if error != nil {
        print("\(#function) - Error: \(error!.localizedDescription)")
      }
      
      if let tokenData = data {
        do {
          let object = try JSONDecoder().decode(TokenResponse.self, from: tokenData)
          self.token = object.access_token
          
          let date = Date().addingTimeInterval(TimeInterval(object.expires_in))
          print("\ntoken local expiration date: \(date)")
          self.tokenExpirationDate = date
          completion()
        } catch let error {
          print("❌ \(#function) - Decoding error: \(error) \ntokenData error: \(String(decoding: tokenData, as: UTF8.self))")
        }
      }
    }
    
    task.resume()
  }
  
  func fetch<T: Decodable>( at endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
    if isTokenValid() {
      guard let url = endPoint.url else {
        print("❌ \(#function) - Error: Cannot create URL using - \(endPoint.urlString)")
        return
      }
      let method = "GET"
      var request = URLRequest(url: url)
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      request.httpMethod = method
      request.cachePolicy = .reloadRevalidatingCacheData
      
      let session = URLSession.shared
      let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
        }
        if let data = data {
          do {
            let object = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
              completion(.success(object))
            }
            
          } catch let error {
            completion(.failure(error))
          }
        }
      }
      task.resume()
    } else {
      refreshAccessToken { [weak self] in
        self?.fetch(at: endPoint, completion: completion)
      }
    }
  }
  
  static func getPets(petType: PetType, limit: Int, completion: @escaping (_ pets: [PetDetailViewModel], _ error: String?) -> Void) {
    
    let url = URL(string: "https://api.petfinder.com/v2/animals/?type=\(petType.endPoint)&limit=\(limit)")!
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(UserDefaults.standard.string(forKey: Keys.tokenKey) ?? "")", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
    request.cachePolicy = .reloadRevalidatingCacheData
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion([], error.localizedDescription)
      }
      if let data = data {
        do {
          let animals = try JSONDecoder().decode(AllAnimals.self, from: data)
          
          DispatchQueue.main.async {
            let pets = animals.animals!.compactMap { PetDetailViewModel(model: $0) }
            completion(pets, nil)
          }
          
        } catch let error {
          print(error.localizedDescription)
          completion([], nil)
        }
      }
    }
    task.resume()
  }
  
  //  static func getRecommended(petType: PetType, completion: @escaping (_ pets: [PetDetailViewModel], _ error: String?) -> Void) {
  static func getRecommended(firstPetType: PetType, secondPetType: PetType?, thirdPetType: PetType?, completion: @escaping (_ pets: [PetDetailViewModel], _ error: String?) -> Void) {
    
    var animals: [PetDetailViewModel] = []
    
    getPets(petType: firstPetType, limit: 10) { (pets, error) in
      if let error = error {
        return completion(animals, error)
      }
      animals.append(contentsOf: pets)
      
      if let secondPetType = secondPetType {
        getPets(petType: secondPetType, limit: 6) { (pets, error) in
          if let error = error {
            return completion(animals, error)
          }
          animals.append(contentsOf: pets)
          
          if let thirdPetType = thirdPetType {
            getPets(petType: thirdPetType, limit: 4) { (pets, error) in
              if let error = error {
                return completion(animals, error)
              }
              animals.append(contentsOf: pets)
              
              DispatchQueue.main.async {
                completion(animals, nil)
              }
              
            }
          } else {
            DispatchQueue.main.async {
              completion(animals, nil)
            }
          }
        }
      } else {
        DispatchQueue.main.async {
          completion(animals, nil)
        }
      }
    }
  }
  
}
