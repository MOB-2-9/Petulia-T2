//
//  MotherView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/12/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct MotherView : View {
  
  @EnvironmentObject var viewRouter: OnboardingViewRouter
  
  var body: some View {
    VStack {
      if viewRouter.currentPage == "onboardingView" {
        OnboardingView()
      } else if viewRouter.currentPage == "authView" {
        AuthView()
      }
    }
  }
}
