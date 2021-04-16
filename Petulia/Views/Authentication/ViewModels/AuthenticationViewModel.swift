//
//  AuthenticationViewModel.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

enum AuthType {
  case login, signup
}

class AuthenticationViewModel: ObservableObject {
  
  let authType: AuthType
  @Published var name: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  
  
  init(authType: AuthType) {
    self.authType = authType
  }
}
