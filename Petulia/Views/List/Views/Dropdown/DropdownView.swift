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
  @State var options: [DropdownOption]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(0..<options.count, id: \.self) { index in
        let option = options[index]
        DropdownOptionCell(option: option) //I think option here should be binded
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
  
  var body: some View {
    Button(action: {
      print("dropdown cell tapped \(option.title)")
      option.toggleIsSelected()
    }) {
      Text(option.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) //makes the button selectable and highlighted on a wider area
    }
//    .padding(.horizontal, 20)
//    .frame(maxWidth: .infinity)
    .padding(.vertical, 5)
    .background(
      option.isSelected ? Color.gray : Color.clear
    )
  }
}

struct DropdownView_Previews: PreviewProvider {
  static var previews: some View {
    let options: [DropdownOption] = [
      DropdownOption(title: "Eyo1", isSelected: true),
      DropdownOption(title: "Eyo2 "),
      DropdownOption(title: "Eyo3"),
    ]
    DropdownView(options: options)
  }
}
