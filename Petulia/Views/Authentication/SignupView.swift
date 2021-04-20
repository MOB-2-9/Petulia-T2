//
//  SignupView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct SignupView: View {
  
  @ObservedObject var viewModel: AuthenticationViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        AuthFormView(authType: .signup, name: $viewModel.name, email: $viewModel.email, password: $viewModel.password)
          .frame(width: Constants.screenWidth - 32, height: 180, alignment: .center)
        signupButton
      }
      .navigationBarTitle("Sign Up", displayMode: .inline)
      .padding(.horizontal, 16)
      .onTapGesture { UIApplication.shared.endEditing(true) }
      .alert(with: $viewModel.errorMessage)
    }
  }
}

//MARK: Preview
struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    SignupView(viewModel: AuthenticationViewModel(authType: .signup))
  }
}

//MARK: - UIComponents
extension SignupView {
  var signupButton: some View {
    Button(action: signupButtonTapped, label: {
      Text("Sign up")
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
extension SignupView {
  func signupButtonTapped() {
    CustomerService.createCustomer(name: viewModel.name, email: viewModel.email, password: viewModel.password) { (alertError) in
      if let alertError = alertError {
        self.viewModel.handleAlertError(alertError: alertError)
        return
      }
      self.goToHomePage()
    }
  }
  
  func goToHomePage() {
    withAnimation {
      let petDataController = PetDataController()
      let favoriteController = FavoriteController()
      let themeManager = ThemeManager()
      let rootView = HomeView()
        .environmentObject(petDataController)
        .environmentObject(favoriteController)
        .environmentObject(themeManager)
      let rootVC = UIHostingController(rootView: rootView)
      AppService.initRootView(rootController: rootVC)
    }
  }
}
