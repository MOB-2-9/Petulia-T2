//
//  AuthView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct AuthView: View {
  
  @State var isLogin = false
  @State var isSignup = false
  
  var body: some View {
    NavigationView {
      VStack {
        headingImage
        headingText
        Spacer()
        VStack(spacing: 24) {
          loginButton
          signupButton
        }
        Spacer()
        NavigationLink(destination: LoginView(viewModel: AuthenticationViewModel(authType: .login)), isActive: $isLogin, label: {
          EmptyView()
        })
        NavigationLink(destination: SignupView(viewModel: AuthenticationViewModel(authType: .signup)), isActive: $isSignup, label: {
          EmptyView()
        })
      }
      .padding(.horizontal , 16)
      .onTapGesture { UIApplication.shared.endEditing(true) }
    }
  }
}

//MARK: - UIComponents
extension AuthView {
  var headingImage: some View {
    Image("PetuliaLogo")
      .resizable()
      .frame(width: Constants.screenHeight/4, height: Constants.screenHeight/4, alignment: .center)
  }
  var headingText: some View {
    Text("Welcome to Petulia")
      .font(.title)
      .foregroundColor(.accentColor)
  }
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
  var signupButton: some View {
    Button(action: signupButtonTapped, label: {
      Text("Sign up")
        .frame(width: Constants.screenWidth - 32, height: 50, alignment: .center)
        .font(.system(size: 18, weight: .regular, design: .default))
        .background(Color.clear)
        .overlay(
          RoundedRectangle(cornerRadius: 25)
            .stroke(Color.accentColor, lineWidth: 2)
        )
    })
    
  }
}

//MARK: - Methods
extension AuthView {
  func loginButtonTapped() {
    isLogin = true
  }
  
  func signupButtonTapped() {
    isSignup = true
  }
}

//MARK: Preview
struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView()
  }
}

//MARK: - Enum
enum AuthState {
  case isLogin, isSignUp, isLoginSuccessful, isSignUpSuccessful
}

