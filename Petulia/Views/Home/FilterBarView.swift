//
//  FilterBarView.swift
//  Petulia
//
//  Created by Johan on 11.01.2021.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI
import Combine

struct FilterBarView: View {
  @Binding var postcode: String
  @Binding var typing: Bool
  var action: (() -> Void)?
  
  var body: some View {
    HStack {
      Spacer()
      HStack {
        Image(systemName: "map.fill")
          .imageScale(.small)
          .foregroundColor(.accentColor)
        TextField("Postcode",
                  text: $postcode,
                  onEditingChanged: { isTyping in
                    typing = isTyping
                  },
                  onCommit:  {
                    action?() //requestWebData()
                  }
        )
        .font(.headline)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .disableAutocorrection(true)
        .frame(maxWidth: 100)
        .padding(.vertical, 8)
        .onReceive(Just(self.postcode)) { inputValue in  //For every input after the postal code is 5 digits long, remove last to keep the data useable
          let filtered = postcode.filter { $0.isNumber }
          if postcode != filtered {
              postcode = filtered
          }
          if inputValue.count > 5 {
            self.postcode.removeLast()
          }
        }
        
        if !postcode.isEmpty {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.gray)
            .onTapGesture {
              postcode = ""
              action?() //requestWebData()
            }
        }
        
      }
      .padding(.horizontal)
      .background(Color(UIColor.systemGray6))
      .cornerRadius(10)
      .animation(.default)
      
      Spacer()
    }
  }
}
