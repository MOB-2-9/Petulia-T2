//
//  AuthFormView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct AuthFormView: View {
  
  let authType: AuthType
  @Binding var name: String
  @Binding var email: String
  @Binding var password: String
  
  init(authType: AuthType, name: Binding<String>, email: Binding<String>, password: Binding<String>) {
    self.authType = authType
    self._name = name
    self._email = email
    self._password = password
  }
  
  var body: some View {
    VStack{
      switch authType {
      case .login:
        loginView
      case .signup:
        signUpView
      }
    }
  }
}

//MARK: - Enums
extension AuthFormView {}

extension AuthFormView {
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
  
  var nameField: some View {
    HStack{
      Image(systemName: "person.fill").foregroundColor(.gray)
      TextField("name", text: $name)
        .autocapitalization(.words)
        .foregroundColor(.primary)
        .frame(height: 40.0)
    }
    .padding(.horizontal , 15)
    .background(Color(red: 239/255, green: 243/255, blue: 244/255))
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    )
  }
  
  var emailField: some View {
    HStack{
      Image(systemName: "person").foregroundColor(.gray)
      TextField("email", text: $email)
        .keyboardType(.emailAddress)
        .foregroundColor(.primary)
        .frame(height: 40.0)
        .autocapitalization(.none)
    }
    .padding(.horizontal , 15)
    .background(Color(red: 239/255, green: 243/255, blue: 244/255))
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    )
  }
  
  var passwordField: some View {
    HStack{
      Image(systemName: "lock").foregroundColor(.gray)
      SecureField("password", text: $password)
        .foregroundColor(.primary)
        .frame(height: 40.0)
        .autocapitalization(.none)
    }
    .padding(.horizontal , 15)
    .background(Color(red: 239/255, green: 243/255, blue: 244/255))
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    )
  }
}
