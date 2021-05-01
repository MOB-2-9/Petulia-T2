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
        Button(action: buttonTapped, label: {
          Text("Age")
        })
        Button(action: buttonTapped, label: {
          Text("Gender")
        })
        Button(action: buttonTapped, label: {
          Text("Size")
        })
        Button(action: buttonTapped, label: {
          Text("Attributes") //spayed, trained, declawed, special, vacinated
        })
        Button(action: buttonTapped, label: {
          Text("Breed") //primary, secondary, mixed?
        })
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
