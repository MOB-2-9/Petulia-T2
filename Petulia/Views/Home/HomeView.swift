//
//  HomeView.swift
//  Petulia
//
//  Created by Johandre Delgado  on 15.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var petDataController: PetDataController
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  @AppStorage(Keys.showOnlyPostWithImages) var showOnlyPetsWithImages = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  @State var showMenu = false
  
  var filteredPets: [PetDetailViewModel] {
    if showOnlyPetsWithImages {
      return petDataController.allPets.filter { $0.photos.count > 0 }
    }
    return petDataController.allPets
  }
  
  var body: some View {
    
    let drag = DragGesture()
      .onEnded {
        if $0.translation.width < -100 {
          withAnimation {
            self.showMenu = false
          }
        }
      }
    
    NavigationView {
      GeometryReader { geometry in
        ZStack(alignment: .leading){
          VStack {
            ScrollView(.vertical, showsIndicators: false) {
              VStack {
                filterView().padding(.top)
                petTypeScrollView()
                recentPetSectionView()
                favoritesSectionView()
              }
              .padding(.bottom)
            }
              if typing {
                KeyboardToolBarView() {
                  requestWebData()
                }
              }
          }
          MenuView()
            .offset(x: self.showMenu ? 0 : -UIScreen.main.bounds.width)
            .animation(.interactiveSpring(response: 0.6,
                                          dampingFraction: 0.6, blendDuration: 0.6))
          Spacer()
        }
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
            Image(systemName: "line.horizontal.3")
              .imageScale(.large)
          }
        })
      ), trailing: HStack { settingsControlView() })
    }
    .onAppear { requestWebData() } // Assures data at startup
    .navigationViewStyle(StackNavigationViewStyle()) // Solves the double column bug
    .accentColor(theme.accentColor)
    .preferredColorScheme(isDark ? .dark : .light)
    .alert(with: $favorites.errorMessage)
  }
}

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
      .padding(.top, 120)
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


private extension HomeView {
  //MARK: - Methods
  func requestWebData() {
    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
  }
  
  //MARK: - Components
  
  func filterView() -> some View {
    FilterBarView(postcode: $postcode, typing: $typing) {
      requestWebData()
    }
  }
  
  func petTypeScrollView() -> some View {
    PetTypeScrollView(
      types: petDataController.petType.types,
      currentPetType: petDataController.petType.currentPetType) { (petType) in
      petDataController.petType.set(to: petType)
      requestWebData()
    }
  }
  
  func recentPetSectionView() -> some View {
    SectionView(
      kind: .recent,
      petViewModel: filteredPets,
      totalPetCount: petDataController.allPets.count,
      title: "Recent \(petDataController.petType.currentPetType.name)".capitalized,
      isLoading: petDataController.isLoading,
      primaryAction: { requestWebData() },
      settingsAction: { }
    )
  }
  
  func favoritesSectionView() -> some View {
    SectionView(
      kind: .favorites,
      petViewModel: favorites.list,
      title: "Favorites"
    )
  }
  
  func settingsControlView() -> some View {
    SettingsButton(presentation: $showSettingsSheet) {
      requestWebData()
    }
  }
}
