//
//  SignupView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct SignupView: View {
  
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

//MARK: Preview
struct SignupView_Previews: PreviewProvider {
  static var previews: some View {
    SignupView()
  }
}

//MARK: - Methods
extension SignupView {}
