//
//  MenuView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation

struct MenuView: View {
  @EnvironmentObject var theme: ThemeManager
  //@State var currentPage: Page = .homeView
  //@StateObject var viewRouter: ViewRouter
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Image(systemName: "tortoise")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Pets")
          .foregroundColor(.white)
          .font(.headline)
      }
      .padding(.top, 140)
      HStack {
        Image(systemName: "globe")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Welfare")
          .foregroundColor(.white)
          .font(.headline)
      }
      .padding(.top, 20)
      HStack {
        Image(systemName: "gear")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Settings")
          .foregroundColor(.white)
          .font(.headline)
      }
      .padding(.top, 20)
      HStack {
        Image(systemName: "person")
          .foregroundColor(.white)
          .imageScale(.large)
        Text("Profile")
          .foregroundColor(.white)
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
