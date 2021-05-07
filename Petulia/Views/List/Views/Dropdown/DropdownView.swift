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
      ForEach(self.options, id: \.self) { option in
        DropdownOptionCell(title: option.title, onSelect: onSelect)
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
  var title: String
//  var key: String
  var onSelect: ((_ key: String) -> Void)?
  
  var body: some View {
    Button(action: {
      if let onSelect = self.onSelect {
        onSelect(self.title)
      }
    }) {
      Text(self.title)
    }
    //        .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .padding(.vertical, 5)
  }
}