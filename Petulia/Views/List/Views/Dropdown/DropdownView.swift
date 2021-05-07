//
//  DropdownView.swift
//  Petulia
//
//  Created by Samuel Folledo on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct DropdownView: View {
  let dropdownCornerRadius: CGFloat = 5
  var options: [DropdownOption]
  var onSelect: ((_ key: String) -> Void)?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(0..<options.count, id: \.self) { index in
//        DropdownOptionCell(title: option.title, onSelect: onSelect)
        let option = options[index]
        DropdownOptionCell(option: option, onSelect: onSelect)
      }
    }
    .background(Color.white)
    .cornerRadius(dropdownCornerRadius)
    .overlay(
      RoundedRectangle(cornerRadius: dropdownCornerRadius)
        .stroke(Color.primary, lineWidth: 1)
    )
  }
}

struct DropdownOptionCell: View {
  var option: DropdownOption
//  var title: String
//  var key: String
  var onSelect: ((_ key: String) -> Void)?
  
  var body: some View {
    Button(action: {
      if let onSelect = self.onSelect {
        onSelect(option.title)
//        self.option.isSelected.toggle()
      }
    }) {
      Text(option.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
//    .padding(.horizontal, 20)
//    .frame(maxWidth: .infinity)
    .padding(.vertical, 5)
    .background(
      option.isSelected ? Color.gray : Color.clear
    )
  }
}
