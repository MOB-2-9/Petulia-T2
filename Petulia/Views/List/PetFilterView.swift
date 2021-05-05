//
//  PetFilterView.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct PetFilterView: View {
    var body: some View {
      HStack {
        Button(action: buttonTapped, label: {
          Text("Sort By") //distance, size, date,
        })
        .frame(maxWidth: .infinity)
        Button(action: buttonTapped, label: {
          Text("Age") //Young
        })
        .frame(maxWidth: .infinity)
        Button(action: buttonTapped, label: {
          Text("Gender") //Female
        })
        .frame(maxWidth: .infinity)
        Button(action: buttonTapped, label: {
          Text("Size") //Medium
        })
        .frame(maxWidth: .infinity)
      }
    }
  
  func buttonTapped() {
    print("Tapped!")
  }
}

struct PetFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PetFilterView()
    }
}
