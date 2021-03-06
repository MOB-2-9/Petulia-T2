//
//  PetResponse.swift
//  Petulia
//
//  Created by Johandre Delgado  on 02.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.


import Foundation


// MARK: - Animal Modeling API response
struct Animal: Codable, Identifiable {
  let id: Int
  let organizationID: String?
  let url: String?
  let type, species: String?
  let age, gender, size: String?
  let tags: [String]?
  let attributes: Attributes?
  let name, animalDescription, description: String?
  let status: String?
  let publishedAt: String?
  let photos: [Photo]?
  let distance: Double?
  let breeds: Breed?
  let contact: Contact?
  
  enum CodingKeys: String, CodingKey {
    case id
    case organizationID = "organization_id"
    case url, type, age, tags, attributes, name, species, size, gender, animalDescription, description, photos, distance, breeds
    case status
    case publishedAt = "published_at"
    case contact
  }
}



// MARK: - Component DTOs

struct AllAnimals: Codable {
  let animals: [Animal]?
  let pagination: PaginationDTO
}

struct PaginationDTO: Codable {
  var countPerPage: Int
  var totalCount: Int
  var currentPage: Int
  var totalPages: Int
  let links: PaginationLinks?
  
  enum CodingKeys: String, CodingKey {
    case countPerPage = "count_per_page"
    case totalCount = "total_count"
    case currentPage = "current_page"
    case totalPages = "total_pages"
    case links = "_links"
  }
}

extension PaginationDTO {
  static var new: PaginationDTO {
    PaginationDTO(countPerPage: 20, totalCount: 20, currentPage: 1, totalPages: 1, links: PaginationLinks(previous: nil, next: nil))
  }
}

struct PaginationLinks: Codable {
  let previous: LinkString?
  let next: LinkString?
}

struct LinkString: Codable {
  let href: String
}

struct Photo: Codable {
  let small, medium, large, full: String?
  
  var asDictionary: [String: Any] {
    get {
      var dic: [String: Any] = [:]
      if let small = small {
        dic[AnimalKeys.Photos.smallPhoto] = small
      }
      if let medium = medium {
        dic[AnimalKeys.Photos.mediumPhoto] = medium
      }
      if let large = large {
        dic[AnimalKeys.Photos.largePhoto] = large
      }
      if let full = full {
        dic[AnimalKeys.Photos.fullPhoto] = full
      }
      return dic
    }
  }
  
  init(dic: [String: String]) {
    self.small = dic[AnimalKeys.Photos.smallPhoto]
    self.medium = dic[AnimalKeys.Photos.mediumPhoto]
    self.large = dic[AnimalKeys.Photos.largePhoto]
    self.full = dic[AnimalKeys.Photos.fullPhoto]
  }
  
  init(small: String?, medium: String?, large: String?, full: String?) {
    self.small = small
    self.medium = medium
    self.large = large
    self.full = full
  }
  
  func imagePath(for size: Size) -> String {
    let noUrlString = "no-image"
    switch size {
    case .small:
      return self.small ?? noUrlString
    case .medium:
      return self.medium ?? noUrlString
    case .large:
      return self.large ?? noUrlString
    case .full:
      return self.full ?? noUrlString
    }
  }
}

enum Size: String, Codable {
  case small, medium, large, full
}


// MARK: - Address
struct Address: Codable {
  let address1, address2, city, state: String?
  let postcode, country: String?
  var asDictionary: [String: Any] {
    get {
      var dic: [String: Any] = [:]
      //TODO
      if let address1 = address1 {
        dic[AnimalKeys.Contact.Address.address1] = address1
      }
      if let address2 = address2 {
        dic[AnimalKeys.Contact.Address.address2] = address2
      }
      if let city = city {
        dic[AnimalKeys.Contact.Address.city] = city
      }
      if let state = state {
        dic[AnimalKeys.Contact.Address.state] = state
      }
      if let postcode = postcode {
        dic[AnimalKeys.Contact.Address.postcode] = postcode
      }
      if let country = country {
        dic[AnimalKeys.Contact.Address.country] = country
      }
      return dic
    }
  }
  
  init(dic: [String: String]) {
    self.address1 = dic[AnimalKeys.Contact.Address.address1]
    self.address2 = dic[AnimalKeys.Contact.Address.address2]
    self.city = dic[AnimalKeys.Contact.Address.city]
    self.state = dic[AnimalKeys.Contact.Address.state]
    self.postcode = dic[AnimalKeys.Contact.Address.postcode]
    self.country = dic[AnimalKeys.Contact.Address.country]
  }
}

struct Breed: Codable {
  let primary, secondary: String?
  let mixed: Bool
  let unknown: Bool
  
  static var new: Breed {
    Breed(primary: nil, secondary: nil, mixed: false, unknown: true)
  }
}

struct Attributes: Codable {
  var spayed: Bool?
  var trained: Bool?
  var declawed: Bool?
  var special: Bool?
  var vacinated: Bool?
  
  enum CodingKeys: String, CodingKey {
    case spayed = "spayed_neutered"
    case trained = "house_trained"
    case declawed = "declawed"
    case special = "special_needs"
    case vacinated = "shots_current"
  }
}

extension Attributes {
  var list: [String: Bool] {
    
    return [
      "spayed": spayed ?? false,
      "trained": trained ?? false,
      "declawed": declawed ?? false,
      "special": special ?? false,
      "vacinated": vacinated ?? false
    ]
  }
}

//MARK: Contact Info
struct Contact: Codable {
  let email: String?
  let phone: String?
  let address: Address?
  
  var asDictionary: [String: Any] {
    get {
      var dic: [String: Any] = [
        AnimalKeys.Contact.email: email ?? "",
        AnimalKeys.Contact.phone: phone ?? "",

      ]
      if let address = address {
        dic[AnimalKeys.Contact.address] = address.asDictionary
      }
      return dic
    }
  }
  
  
  init(dic: [String: Any]) {
    self.email = dic[AnimalKeys.Contact.email] as? String
    self.phone = dic[AnimalKeys.Contact.phone] as? String
    if let addressDic = dic[AnimalKeys.Contact.address] as? [String: String] {
      self.address = Address(dic: addressDic)
    } else {
      self.address = nil
    }
  }

  init(email: String, phone: String, address: Address) {
    self.email = email
    self.phone = phone
    self.address = address
  }
  
  
}
