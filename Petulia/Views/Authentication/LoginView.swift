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
        AuthFormView(authType: .signup)
      }
      .padding(.horizontal , 16)
      .onTapGesture { UIApplication.shared.endEditing(true) }
    }
  }
}

//MARK: - UIComponents
extension LoginView {}

//MARK: Preview
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
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
