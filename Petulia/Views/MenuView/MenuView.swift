//
//  MenuView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct MenuView: View {
  @EnvironmentObject var theme: ThemeManager
  //@State var currentPage: Page = .homeView
  //@StateObject var viewRouter: ViewRouter
  @EnvironmentObject var viewRouter: ViewRouter
  
  var body: some View {
//    switch viewRouter.currentPage {
//    case .pets:
//      HomeView()
//        .transition(.scale)
//    case .welfare:
//      WelfareOrganization()
//        .transition(.scale)
//    case .settings:
//      SettingsView()
//        .transition(.scale)
//    case .profile:
//      ProfileView()
//        .transition(.scale)
//    case .logout:
//      LoginView(viewModel: AuthenticationViewModel(authType: .login))
//        .transition(.scale)
//    }
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Button(action: {
            withAnimation {
                viewRouter.currentPage = .pets
            }
        }) {
          Image(systemName: "tortoise")
            .foregroundColor(.white)
            .imageScale(.large)
          Text("Pets")
            .foregroundColor(.white)
            .font(.headline)
        }
    }
      .padding(.top, 140)
      HStack {
        Button(action: {
          withAnimation {
            viewRouter.currentPage = .welfare
          }
        }){
        Image(systemName: "globe")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Welfare")
          .foregroundColor(.white)
          .font(.headline)
        }
      }
      .padding(.top, 20)
      HStack {
        Button(action: {
          withAnimation {
            viewRouter.currentPage = .settings
          }
        }){
        Image(systemName: "gear")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Settings")
          .foregroundColor(.white)
          .font(.headline)
        }
      }
      .padding(.top, 20)
      HStack {
        Button(action: {
          withAnimation {
            viewRouter.currentPage = .profile
          }
        }){
        Image(systemName: "person")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Profile")
          .foregroundColor(.white)
          .font(.headline)
        }
      }
      .padding(.top, 20)
      Spacer()
    }
    .padding()
    .frame(maxWidth: UIScreen.main.bounds.width/2, alignment: .leading)
    .background(theme.accentColor)
    .edgesIgnoringSafeArea(.all)
  }
  
}

struct BackgroundMenuView: View {
  
  @EnvironmentObject var theme: ThemeManager
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
    HStack {
      Image(systemName: "person")
        .foregroundColor(theme.accentColor)
        .imageScale(.large)
      Text("Profile")
        .foregroundColor(theme.accentColor)
        .font(.headline)
    }
    .padding(.top, 20)
    Spacer()
  }
  .padding()
  .frame(maxWidth: UIScreen.main.bounds.width/2, alignment: .leading)
  .background(theme.accentColor)
  .edgesIgnoringSafeArea(.all)
  }
}

struct ClearBackground: View {
  
  @EnvironmentObject var theme: ThemeManager
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
    HStack {
      Image(systemName: "person")
        .foregroundColor(Color.gray.opacity(0.5))
        .imageScale(.large)
      Text("Profile")
        .foregroundColor(Color.gray.opacity(0.5))
        .font(.headline)
    }
    .padding(.top, 20)
    Spacer()
  }
  .padding()
  .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
  .background(Color.gray.opacity(0.5))
  .edgesIgnoringSafeArea(.all)
  }
}

enum Page {
  case pets
  case welfare
  case settings
  case profile
  case logout
}

class ViewRouter: ObservableObject {
  @Published var currentPage: Page = .pets
  
}
