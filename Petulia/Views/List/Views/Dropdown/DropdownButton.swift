//
//  DropDownButton.swift
//  Petulia
//
//  Created by Samuel Folledo on 5/7/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

class DropdownOption {
  private(set) var title: String
  var isSelected: Bool
  public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
    return lhs.title == rhs.title
  }
  
  init(title: String, isSelected: Bool = false) {
    self.title = title
    self.isSelected = isSelected
  }
  
  func toggleIsSelected() {
    isSelected = !isSelected
  }
}

class DropdownViewModel: ObservableObject {
  @Published var buttonTitle: String
  @Published var options: [DropdownOption]
  @Published var shouldShowDropdown = false
  
  @Published var sortByOptions = [
    DropdownOption(title: "Distance"),
    DropdownOption(title: "Date", isSelected: true),
  ]
  @Published var ageOptions = [
    DropdownOption(title: "Baby"),
    DropdownOption(title: "Young"),
    DropdownOption(title: "Adult"),
    DropdownOption(title: "Senior"),
  ]
  @Published var genderOptions = [
    DropdownOption(title: "Male"),
    DropdownOption(title: "Female"),
  ]
  @Published var sizeOptions = [
    DropdownOption(title: "Small"),
    DropdownOption(title: "Medium"),
    DropdownOption(title: "Large"),
    DropdownOption(title: "XLarge"),
  ]
  
  init(buttonTitle: String, options: [DropdownOption]) {
    self.buttonTitle = buttonTitle
    self.options = options
  }
  
  func tapped() {
    print("OPTion tapped!")
  }
}

struct DropdownButton: View {
  let dropdownCornerRadius: CGFloat = 5
  @ObservedObject var viewModel: DropdownViewModel
  
  init(title: String, options: [DropdownOption]) {
    self.viewModel = DropdownViewModel(buttonTitle: title, options: options)
  }
  
  let buttonHeight: CGFloat = 30
  var body: some View {
    Button(action: {
      self.viewModel.shouldShowDropdown.toggle()
    }) {
      HStack(alignment: .center) {
        Text(viewModel.buttonTitle)
        Image(systemName: self.viewModel.shouldShowDropdown ? "chevron.up" : "chevron.down")
      }
    }
//    .padding(.horizontal)
//    .cornerRadius(dropdownCornerRadius)
    .frame(height: self.buttonHeight)
    .frame(maxWidth: .infinity)
    .overlay(
      RoundedRectangle(cornerRadius: dropdownCornerRadius)
        .stroke(Color.primary, lineWidth: 0)
    )
    .overlay(
      VStack {
        //drop down view
        if self.viewModel.shouldShowDropdown {
          Spacer(minLength: buttonHeight + 10)
          DropdownView(options: self.viewModel.options)
        }
      }, alignment: .topLeading
    )
    .background(
      RoundedRectangle(cornerRadius: dropdownCornerRadius).fill(Color.white)
    )
  }
}
