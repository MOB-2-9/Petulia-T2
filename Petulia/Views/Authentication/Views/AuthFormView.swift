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
  @State var email: String = ""
  @State var password: String = ""
  @State var name: String = ""
  
  init(authType: AuthType) {
    self.authType = authType
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

//MARK: Preview
struct AuthFormView_Previews: PreviewProvider {
  static var previews: some View {
    AuthFormView(authType: .signup)
  }
}

//MARK: - Enums
extension AuthFormView {
  enum AuthType {
    case login, signup
  }
}

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
        .foregroundColor(.accentColor)
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
        .foregroundColor(.accentColor)
        .frame(height: 40.0)
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
        .foregroundColor(.accentColor)
        .frame(height: 40.0)
    }
    .padding(.horizontal , 15)
    .background(Color(red: 239/255, green: 243/255, blue: 244/255))
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
    )
  }
}
