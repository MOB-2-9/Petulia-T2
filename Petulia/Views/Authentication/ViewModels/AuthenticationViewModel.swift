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
  @Published var errorMessage: AlertMessage?
  @Published var name: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  
  init(authType: AuthType) {
    self.authType = authType
  }
}

//MARK: - Helpers
extension AuthenticationViewModel {
    func handleError(title: String, message: String) {
        let alertError = AlertError(title: title, message: message)
        errorMessage = AlertMessage.alertError(alertError: alertError)
    }
    
    func handleAlertError(alertError: AlertError) {
        errorMessage = AlertMessage.alertError(alertError: alertError)
    }
}
