//
//  StarterView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/9/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct StarterView: View{
  @StateObject var viewRouter: ViewRouter
  
  var body: some View{
    NavigationHamburgerMenu(viewRouter: viewRouter)
  }
}
