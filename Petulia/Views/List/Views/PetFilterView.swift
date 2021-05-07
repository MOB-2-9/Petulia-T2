//
//  PetFilterView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct PetFilterView: View {
  
  @State var showStoreDropDown: Bool = false
  let sortByOptions = [
    DropdownOption(title: "Distance"),
    DropdownOption(title: "Date", isSelected: true),
  ]
  let ageOptions = [
    DropdownOption(title: "Baby"),
    DropdownOption(title: "Young"),
    DropdownOption(title: "Adult"),
    DropdownOption(title: "Senior"),
  ]
  let genderOptions = [
    DropdownOption(title: "Male"),
    DropdownOption(title: "Female"),
  ]
  let sizeOptions = [
    DropdownOption(title: "Small"),
    DropdownOption(title: "Medium"),
    DropdownOption(title: "Large"),
    DropdownOption(title: "XLarge"),
  ]
  
  let onSelect = { key in
    print("selected key:", key)
  }
  
  var body: some View {
    HStack {
      DropdownButton(displayText: .constant("Sort By"), options: sortByOptions, onSelect: onSelect)
      DropdownButton(displayText: .constant("Age"), options: ageOptions, onSelect: onSelect)
      DropdownButton(displayText: .constant("Gender"), options: genderOptions, onSelect: onSelect)
      DropdownButton(displayText: .constant("Size"), options: sizeOptions, onSelect: onSelect)
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
