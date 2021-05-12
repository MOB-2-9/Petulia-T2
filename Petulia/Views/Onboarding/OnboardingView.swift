//
//  OnboardingView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/11/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
  
  var subviews = [
    UIHostingController(rootView: Subview(imageString: "koala")),
    UIHostingController(rootView: Subview(imageString: "chameleon")),
    UIHostingController(rootView: Subview(imageString: "cat2"))
  ]
  
  var titles = ["Find your pet", "Look for Your Favorites", "Contact the Owners"]
  
  var captions = ["Pets ranging from exotic birds to household pets, your future pet is a click away!", "Find a pet you want to save and add them to your favorites!", "Call or email the owner to connect with them!"]
  
  @State var currentPageIndex = 0
  
  var body: some View {
    VStack(alignment: .leading) {
      PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
        .frame(height: UIScreen.main.bounds.height/3)
      Group {
        Text(titles[currentPageIndex])
          .font(.title)
        Text(captions[currentPageIndex])
          .font(.subheadline)
          .foregroundColor(.purpleLight)
          .frame(width: 300, height: 50, alignment: .leading)
          .lineLimit(nil)
      }
      .padding()
      HStack {
        PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
        Spacer()
        Button(action: {
          if self.currentPageIndex+1 == self.subviews.count {
            self.currentPageIndex = 0
          } else {
            self.currentPageIndex += 1
          }
        }) {
          ButtonContent()
        }
      }
      .padding()
    }
  }
}

struct ButtonContent: View {
  var body: some View {
    Image(systemName: "arrow.right")
      .resizable()
      .foregroundColor(.white)
      .frame(width: 30, height: 30)
      .padding()
      .background(Color.purple)
      .cornerRadius(30)
  }
}
