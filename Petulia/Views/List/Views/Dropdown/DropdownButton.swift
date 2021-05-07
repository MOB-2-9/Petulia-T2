//
//  DropDownButton.swift
//  Petulia
//
//  Created by Samuel Folledo on 5/7/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct DropdownOption: Hashable {
  var title: String
//  var isSelected: Bool
//  var val: String
  public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
    return lhs.title == rhs.title
  }
}

struct DropdownButton: View {
  let dropdownCornerRadius: CGFloat = 5
  @State var shouldShowDropdown = false
  @Binding var displayText: String
  var options: [DropdownOption]
  var onSelect: ((_ key: String) -> Void)?
  
  let buttonHeight: CGFloat = 30
  var body: some View {
    Button(action: {
      self.shouldShowDropdown.toggle()
    }) {
      HStack(alignment: .center) {
        Text(displayText)
        Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down")
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
        if self.shouldShowDropdown {
          Spacer(minLength: buttonHeight + 10)
          DropdownView(options: self.options, onSelect: self.onSelect)
        }
      }, alignment: .topLeading
    )
    .background(
      RoundedRectangle(cornerRadius: dropdownCornerRadius).fill(Color.white)
    )
  }
}
