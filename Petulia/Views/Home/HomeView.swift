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
  @EnvironmentObject var recommendedPetDataController: RecommendedPetDataController
  @EnvironmentObject var favorites: FavoriteController
  @EnvironmentObject var theme: ThemeManager
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.isDark) var isDark = false
  @AppStorage(Keys.showOnlyPostWithImages) var showOnlyPetsWithImages = false
  
  @State private var typing = false
  @State private var showSettingsSheet = false
  @State var showMenu = false
  
//  @ObservedObject var topRecommendations = Recommender()
  
  var filteredPets: [PetDetailViewModel] {
    if showOnlyPetsWithImages {
      return petDataController.allPets.filter { $0.photos.count > 0 }
    }
    return petDataController.allPets
  }
  
  var filteredRecommendedPets: [PetDetailViewModel] {
    if showOnlyPetsWithImages {
      return recommendedPetDataController.allPets.filter { $0.photos.count > 0 }
    }
    return recommendedPetDataController.allPets
  }
  
  var body: some View {
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
                recommendedSectionView()
                favoritesSectionView()
              }
              .padding(.bottom)
            }
            if typing {
              KeyboardToolBarView() {
                requestWebData()
              }
            }
          if typing {
            KeyboardToolBarView() {
              requestWebData()
            }
          }
        }
        .gesture(drag)
      }
    .onAppear { requestWebData() } // Assures data at startup
    .accentColor(theme.accentColor)
    .preferredColorScheme(isDark ? .dark : .light)
    .alert(with: $favorites.errorMessage)
  }
}

private extension HomeView {
  //MARK: - Methods
  func requestWebData() {
    self.petDataController.requestPets(around: postcode.isEmpty ? nil : postcode)
    self.recommendedPetDataController.requestPets()
  }
  
//  func getRecommendedPets() -> [PetDetailViewModel] {
//    var recommendedPets: [PetDetailViewModel] = []
//    var petTypeAndScore: [PetScore] = topRecommendations.petScores
//
//    petTypeAndScore.sort { $0.score > $1.score }
//
//    APIService.getRecommended(petType: petTypeAndScore[0].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 10 { break }
//        recommendedPets.append(pets[i])
//      }
//    }
//
//    APIService.getRecommended(petType: petTypeAndScore[1].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 5 { break }
//        recommendedPets.append(pets[i])
//      }
//    }
//
//    APIService.getRecommended(petType: petTypeAndScore[2].petType) { (pets, error) in
//      for i in 0..<pets.count {
//        if i == 4 { break }
//        recommendedPets.append(pets[i])
//      }
//    }
//
//    return recommendedPets
//  }
  
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
      settingsAction: { },
      petType: petDataController.petType.currentPetType.name
    )
  }
  
  func recommendedSectionView() -> some View {
    SectionView(
      kind: .recommended,
      petViewModel: filteredRecommendedPets,
      totalPetCount: recommendedPetDataController.allPets.count,
      title: "Recommended",
      isLoading: recommendedPetDataController.isLoading,
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
