//
//  MenuView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct NavigationHamburgerMenu: View {
  @EnvironmentObject var theme: ThemeManager
  @StateObject var viewRouter: ViewRouter
  @State var showMenu = false
  @State private var showSettingsSheet = false
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @EnvironmentObject var petDataController: PetDataController
  
    var body: some View{
      let drag = DragGesture()
        .onEnded {
          if $0.translation.width < -100 {
            withAnimation {
              self.showMenu = false
            }
          }
        }
        return NavigationView{
            GeometryReader{ geometry in
                ZStack(alignment: .leading, content: {
                  switch viewRouter.currentPage {
                  case .pets:
                    HomeView()
                      .frame(width: geometry.size.width, height: geometry.size.height)
                  case .welfare:
                    WelfareOrganization()
                      .frame(width: geometry.size.width, height: geometry.size.height)
                  case .profile:
                    ProfileView()
                      .frame(width: geometry.size.width, height: geometry.size.height)
                  case .logout:
                    AuthView()
                      .frame(width: geometry.size.width, height: geometry.size.height)
                  case .generic:
                    EmptyView()
                      .transition(.scale)
                  }
                  ClearBackground()
                    .offset(x: self.showMenu ? 0 : -UIScreen.main.bounds.width)
                  BackgroundMenuView()
                    .offset(x: self.showMenu ? 0 : -UIScreen.main.bounds.width)
                    .animation(.linear)
                  
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    viewRouter.currentPage = .pets
                                    //hide the menu
                                    showMenu = false
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
                                    //hide the menu
                                    showMenu = false
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
                            viewRouter.currentPage = .profile
                            showMenu = false
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
                      HStack {
                        Button(action: {
                          withAnimation {
                            viewRouter.currentPage = .logout
                            showMenu = false
                          }
                        }){
                        Text("Log Out")
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
                        .offset(x: self.showMenu ? 0 : -UIScreen.main.bounds.width)
                        .animation(.interactiveSpring(response: 0.6,
                                                      dampingFraction: 0.5, blendDuration: 0.5))
                })
                .gesture(drag)
            }
            .navigationBarTitle("Petulia", displayMode: .large)
            .navigationBarItems(leading: (
              Button(action: {
                self.showMenu.toggle()
              }, label: {
                if self.showMenu{
                  Image(systemName: "multiply").font(.body).foregroundColor(.white)
                    .imageScale(.large)
                } else{
                  Image(systemName: "line.horizontal.3").foregroundColor(theme.accentColor)
                    .imageScale(.large)
                }
              })
            ),
            trailing: HStack { settingsControlView().foregroundColor(theme.accentColor) }
            )
        }
    }
}

struct BackgroundMenuView: View {
  
  @EnvironmentObject var theme: ThemeManager
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @EnvironmentObject var petDataController: PetDataController
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
    HStack {
      Text("Place holder")
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
      Text("Place holder")
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

private extension NavigationHamburgerMenu{
  func requestWebData() {
    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
  }
  func settingsControlView() -> some View {
    SettingsButton(presentation: $showSettingsSheet) {
      requestWebData()
    }
  }
}

enum Page {
  case pets
  case welfare
  case profile
  case logout
  case generic
  
}

class ViewRouter: ObservableObject {
  @Published var currentPage: Page = .pets
  
}
