//
//  OrgDataController.swift
//  Petulia
//
//  Created by Nicholas Kearns on 5/13/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import Combine


final class OrgDataController: ObservableObject {
  
  @Published private(set) var allOrgs: [Organization] = []
  @Published private(set) var isLoading: Bool = false
  
  private let apiService: NetworkService

  init(
    apiService: NetworkService = APIService(),
    pagination: PaginationDTO = PaginationDTO.new,
    petTypeController: PetTypeController = PetTypeController()
  ) {
    self.apiService = apiService
  }

  
  func requestOrgs(around postcode: String? = nil) {
    allOrgs = []
    
    let queryItems = [URLQueryItem(name: "location", value: postcode)]
    let endPoint = EndPoint.organizations(queryItems: queryItems)
    fetchResult(at: endPoint)
    
  }
  
  //MARK: - Private Methods

  func fetchResult(at endPoint: EndPoint) {
    isLoading = true
    apiService.fetch(at: endPoint) { [weak self]  (result: Result<AllOrgs, Error>) in
      switch result {
      case .success(let orgData):
        let rawOrgs = orgData.Orgs ?? []
        self?.allOrgs = rawOrgs.map { Organization(model: $0)}
      case .failure( let error):
        print(error.localizedDescription)
      }
      DispatchQueue.main.async {
        self?.isLoading = false
      }
    }
  }
  
}
