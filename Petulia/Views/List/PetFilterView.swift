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
          Text("Tap me")
        })
        Button(action: buttonTapped, label: {
          Text("Tap me2")
        })
        Button(action: buttonTapped, label: {
          Text("Tap me3")
        })
        Button(action: buttonTapped, label: {
          Text("Tap me4")
        })
      }
    }
  
  func buttonTapped() {
    
  }
}

struct PetFilterView_Previews: PreviewProvider {
    static var previews: some View {
        PetFilterView()
    }
}
