//
//  OrgsViewModel.swift
//  Petulia
//
//  Created by Nicholas Kearns on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Combine

struct OrgsViewModel: Codable {
  var organizations: [Organization]
}

struct Organization: Codable {
  var id: String
  var name: String
  var address: Address
  var url: String
  
  
  init(model: Organization) {
    self.id = model.id
    self.name = model.name
    self.address = model.address
    self.url = model.url
  }
  
}
