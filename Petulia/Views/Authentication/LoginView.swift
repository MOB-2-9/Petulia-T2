//
//  LoginView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct LoginView: View {
  
  @State private var state: AuthState = .isLogin
  @State var email: String = ""
  @State var password: String = ""
  @State var name: String = ""
  
  var body: some View {
    NavigationView {
      VStack {
        switch state {
        case .isLogin:
          loginView
        case .isSignUp:
          signUpView
        default:
          EmptyView()
        }
      }
      .onTapGesture { UIApplication.shared.endEditing(true) }
    }
  }
}

//MARK: - UIComponents
extension LoginView {
  var nameField: some View {
    TextField("name", text: $name)
      .autocapitalization(.words)
      .padding()
  }
  
  var emailField: some View {
    TextField("email", text: $email)
      .keyboardType(.emailAddress)
      .padding()
  }
  
  var passwordField: some View {
    SecureField("password", text: $password)
      .padding()
  }
  
  var loginView: some View {
    VStack(spacing: 16) {
      emailField
      passwordField
    }
  }
  
  var signUpView: some View {
    VStack(spacing: 16) {
      nameField
      emailField
      passwordField
    }
  }
}

//MARK: - Methods
extension LoginView {}

//MARK: - Enum
extension LoginView {
  private enum AuthState {
    case isLogin, isSignUp, isLoginSuccessful, isSignUpSuccessful
  }
}
