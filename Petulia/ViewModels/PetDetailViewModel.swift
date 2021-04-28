//
//  PetDetailViewModel.swift
//  Petulia
//
//  Created by Johandre Delgado  on 15.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Combine
import FirebaseFirestore.FIRDocumentSnapshot

struct PetDetailViewModel: Identifiable, Hashable, Codable {
  
  var id: Int
  var urlString: String? = nil
  var name: String
  var species: String
  var breed: String
  var size: String
  var age: String
  var tags: [String]
  var attributes: [String: Bool]
  var description: String
  var photos: [Photo]
  var gender: String
  var status: String
  var distance: String
  var shelterId: String
  var postedDate: String
  var contact: Contact?
  
  var asDictionary: [String: Any] {
    get {
      var dic: [String: Any] = [
        AnimalKeys.id: id,
        AnimalKeys.name: name,
        AnimalKeys.species: species,
        AnimalKeys.breed: breed,
        AnimalKeys.size: size,
        AnimalKeys.age: age,
        AnimalKeys.tags: tags,
        AnimalKeys.attributes: attributes,
        AnimalKeys.description: description,
        AnimalKeys.photos: photos.map{ $0.asDictionary },
        AnimalKeys.gender: gender,
        AnimalKeys.status: status,
        AnimalKeys.distance: distance,
        AnimalKeys.shelterId: shelterId,
        AnimalKeys.postedDate: postedDate,
      ]
      if let urlString = urlString {
        dic[AnimalKeys.urlString] = urlString
      }
      if let contact = contact {
        dic[AnimalKeys.contact] = contact.asDictionary
      }
      return dic
    }
  }
  
  init(model: Animal) {
    self.id = model.id
    self.name = model.name ?? "Pet Name"
    self.urlString = model.url
    self.species = model.species ?? "N/A"
    self.breed = model.breeds?.primary ?? "Unreported" 
    self.size = model.size ?? "N/A"
    self.age = model.age ?? "N/A"
    self.tags = model.tags ?? []
    self.attributes = model.attributes?.list ?? [String: Bool]()
    self.description = model.description ?? "Your next beautiful, loving pet"
    self.photos = model.photos ?? []
    self.gender = model.gender ?? "Unknown"
    self.status = model.status ?? "Unknown"
    self.distance = model.distance != nil ? "\(String(format: "%.1f", model.distance!)) miles" : ""
    self.shelterId = model.organizationID ?? ""
    let date = Date.date(dateString: model.publishedAt!)
    self.postedDate = date?.timeAgo() ?? "Some time ago"
    self.contact = model.contact
  }
  
  init?(doc: DocumentSnapshot) {
    guard let dic = doc.data(),
          let id = dic[AnimalKeys.id] as? Int,
          let name = dic[AnimalKeys.name] as? String,
          let species = dic[AnimalKeys.species] as? String,
          let breed = dic[AnimalKeys.breed] as? String,
          let size = dic[AnimalKeys.size] as? String,
          let age = dic[AnimalKeys.age] as? String,
          let tags = dic[AnimalKeys.tags] as? [String],
          let attributes = dic[AnimalKeys.attributes] as? [String: Bool],
          let description = dic[AnimalKeys.description] as? String,
          let photosDic = dic[AnimalKeys.photos] as? [[String: String]],
          let gender = dic[AnimalKeys.gender] as? String,
          let status = dic[AnimalKeys.status] as? String,
          let distance = dic[AnimalKeys.distance] as? String,
          let shelterId = dic[AnimalKeys.shelterId] as? String,
          let postedDate = dic[AnimalKeys.postedDate] as? String
    else { return nil }
    self.urlString = dic[AnimalKeys.urlString] as? String
    self.id = id
    self.name = name
    self.species = species
    self.breed = breed
    self.size = size
    self.age = age
    self.tags = tags
    self.attributes = attributes
    self.description = description
    self.photos = []
    for photoDic in photosDic {
      let photo = Photo(dic: photoDic)
      self.photos.append(photo)
    }
    self.gender = gender
    self.status = status
    self.distance = distance
    self.shelterId = shelterId
    self.postedDate = postedDate
    if let contactDic = dic[AnimalKeys.contact] as? [String: String] {
      self.contact = Contact(dic: contactDic)
    }
  }
}

extension PetDetailViewModel {
    var url: URL {
        let string = urlString ?? "https://www.petfinder.com/search/pets-for-adoption/?pet_id=\(id)"
        return URL(string: string)!
    }
}


// MARK: - EXTENSIONS
extension PetDetailViewModel {
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: PetDetailViewModel, rhs: PetDetailViewModel) -> Bool {
    lhs.id == rhs.id
  }
  
  func defaultImagePath(for size: Size) -> String {
    if let first = photos.first {
      return first.imagePath(for: size)
    }
    return ""
  }
  
  var imagePaths: [String] {
    return photos.map { $0.imagePath(for: .medium)}
  }
  
  var cleanedAttributes: [String] {
    let truers = attributes.filter { $0.value == true }
    return truers.map { $0.key }
  }
  
  var characteristics: [Characteristic] {
    [
      Characteristic(id: 5, title: status, label: "status"),
      Characteristic(id: 1, title: size, label: "size"),
      Characteristic(id: 2, title: age, label: "age"),
      Characteristic(id: 3, title: gender, label: "gender"),
      Characteristic(id: 4, title: species, label: "species")
    ]
  }

}


// MARK: - COMPONENTS
struct Characteristic: Identifiable {
  var id: Int
  var title: String
  var label: String
}
