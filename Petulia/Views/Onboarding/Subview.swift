//
//  Subview.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/11/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct Subview: View {
  
  var imageString: String
  
  var body: some View {
    Image(imageString)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .clipped()
  }
}
