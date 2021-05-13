//
//  PetFilterView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

class FilterViewModel: ObservableObject {
  @Published var sortByOptions = [
    DropdownOption(title: "Date", isSelected: true),
    DropdownOption(title: "Distance"),
  ]
  @Published var ageOptions = [
    DropdownOption(title: "Baby"),
    DropdownOption(title: "Young"),
    DropdownOption(title: "Adult"),
    DropdownOption(title: "Senior"),
    DropdownOption(title: "None"),
  ]
  @Published var genderOptions = [
    DropdownOption(title: "Male"),
    DropdownOption(title: "Female"),
    DropdownOption(title: "None"),
  ]
  @Published var sizeOptions = [
    DropdownOption(title: "Small"),
    DropdownOption(title: "Medium"),
    DropdownOption(title: "Large"),
    DropdownOption(title: "XLarge"),
    DropdownOption(title: "None"),
  ]
}

struct PetFilterView: View {
  
  @State var showStoreDropDown: Bool = false
  @ObservedObject var filterViewModel = FilterViewModel()
  
  let onSelect = { key in
    print("selected key:", key)
  }
  
  var body: some View {
    HStack {
      DropdownButton(title: "Sort By", options: filterViewModel.sortByOptions)
      DropdownButton(title: "Age", options: filterViewModel.ageOptions)
      DropdownButton(title: "Gender", options: filterViewModel.genderOptions)
      DropdownButton(title: "Size", options: filterViewModel.sizeOptions)
    }
  }
  
  func buttonTapped() {
    print("Tapped!")
    showStoreDropDown.toggle()
  }
}

struct PetFilterView_Previews: PreviewProvider {
  static var previews: some View {
    PetFilterView()
  }
}
