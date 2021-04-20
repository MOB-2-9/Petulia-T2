//
//  LoginView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct LoginView: View {
  
  @ObservedObject var viewModel: AuthenticationViewModel
  
  var body: some View {
    VStack {
      AuthFormView(authType: .login, name: $viewModel.name, email: $viewModel.email, password: $viewModel.password)
        .frame(width: Constants.screenWidth - 32, height: 120, alignment: .center)
      loginButton
    }
    .navigationBarTitle("Log In", displayMode: .inline)
    .padding(.horizontal, 16)
    .onTapGesture { UIApplication.shared.endEditing(true) }
    .alert(with: $viewModel.errorMessage)
  }
}

//MARK: Preview
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(viewModel: AuthenticationViewModel(authType: .login))
  }
}

//MARK: - UIComponents
extension LoginView {
  var loginButton: some View {
    Button(action: loginButtonTapped, label: {
      Text("Log in")
        .font(.system(size: 18, weight: .regular, design: .default))
        .foregroundColor(.white)
        .padding()
    })
    .frame(width: Constants.screenWidth - 32, height: 50, alignment: .center)
    .background(Color.accentColor)
    .border(Color.clear, width: 2)
    .cornerRadius(100)
  }
}

//MARK: - Methods
extension LoginView {
  func loginButtonTapped() {
    viewModel.isLoginSuccessfully = true
  }
}
