//
//  WelfareOrganization.swift
//  Petulia
//
//  Created by Benjamin Simpson on 5/4/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

struct WelfareOrganization: View {
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @EnvironmentObject var orgDataController: OrgDataController

  
  var body: some View{
    //    Text("This is the Welfare view")
    VStack {
      
      MapView(address: postcode)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
      
    }
    .navigationBarTitle("Organizations", displayMode: .inline)
    .onAppear { }
    
  }
}

extension WelfareOrganization {
  
  func fetchOrgs() {
    self.orgDataController.requestOrgs(around: postcode.isEmpty ? "94108" : postcode)
  }
  
}
