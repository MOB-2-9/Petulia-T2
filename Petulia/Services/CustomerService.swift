//
//  CustomerService.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import FirebaseAuth.FIRUser

//MARK: - Type Aliases
typealias AlertErrorCompletion = (_ error: AlertError?) -> Void
typealias CustomerWithAlertErrorCompletion = (_ space: Customer?, _ error: AlertError?) -> Void
typealias FavoritesWithAlertErrorCompletion = (_ animals: [Animal]?, _ error: AlertError?) -> Void

struct CustomerService {
  
  // MARK: - Type Aliases
  
  // MARK: - Static Methods
  
  static func createCustomer(name: String, email: String, password: String, completion: @escaping AlertErrorCompletion) {
    //1. Create Firebase User
    auth.createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        return completion(AlertError(title: "Error authenticating user", message: error.localizedDescription))
      }
      guard let result = result else { return }
      //2. Update FirebaseUser's displayName
      updateUserDisplayName(name: name) { (alertError) in
        if let alertError = alertError {
          deleteCurrentUser { (error) in
            if let error = error {
              print("Error deleting user \(error)")
            }
          }
          return completion(alertError)
        }
        //3. Save customer to Firestore
        let customer = Customer(userId: result.user.uid, name: name, email: email)
        createUserInDatabase(customer: customer) { (alertError) in
          if let alertError = alertError {
            return completion(alertError)
          }
          //4. Save customer to UserDefaults
          Customer.setCurrent(customer, writeToUserDefaults: true)
          completion(nil)
        }
      }
    }
  }
  
  ///sign user in and store them locally
  static func signIn(email: String, password: String, completion: @escaping AlertErrorCompletion) {
    auth.signIn(withEmail: email, password: password) { (result, error) in
      if let error = error {
        return completion(AlertError(title: "Error signing in", message: error.localizedDescription))
      }
      guard let result = result else { return }
      let userId = result.user.uid
      fetchUser(userId: userId) { (customer, alertError) in
        if let alertError = alertError {
          return completion(alertError)
        }
        guard let customer = customer else { return }
        Customer.setCurrent(customer, writeToUserDefaults: true)
        completion(nil)
      }
    }
  }
  
  ///Fetch a user from database
  static func fetchUser(userId: String, completion: @escaping CustomerWithAlertErrorCompletion) {
    db.collection(CollectionKeys.users)
      .document(userId)
      .getDocument { (snapshot, error) in
        if let error = error {
          return completion(nil, AlertError(title: "Error fetching user data", message: error.localizedDescription))
        }
        guard let snapshot = snapshot,
              let customer = Customer(document: snapshot)
        else { return }
        completion(customer, nil)
      }
  }
  
  ///create a user data in Firestore's Users collection
  private static func createUserInDatabase(customer: Customer, completion: @escaping AlertErrorCompletion) {
    db.collection(CollectionKeys.users)
      .document(customer.userId)
      .setData(customer.asDictionary, merge: true) { (error) in
        if let error = error {
          return completion(AlertError(title: "Error creating user in database", message: error.localizedDescription))
        }
        completion(nil)
      }
  }
  
  ///update FirebaseUser's display name property
  private static func updateUserDisplayName(name: String, completion: @escaping AlertErrorCompletion) {
    let request = auth.currentUser?.createProfileChangeRequest()
    request?.displayName = name
    request?.commitChanges(completion: { (error) in
      if let error = error {
        return completion(AlertError(title: "Error updating user's name", message: error.localizedDescription))
      }
      completion(nil)
    })
  }
  
  static func signOut(completion: @escaping (_ error: String?) -> Void) {
    guard let _ = auth.currentUser
    else { return completion("No user found") }
    do {
      try auth.signOut()
      Defaults.removeUser(true)
      completion(nil)
    } catch let error {
      return completion(error.localizedDescription)
    }
  }
  
  ///sign user out before deleting from the database and locally
  static func deleteCurrentUser(completion: @escaping (_ error: String?) -> Void) {
    guard let user = auth.currentUser
    else { return completion("No user found") }
    signOut { (error) in
      if let error = error {
        return completion(error)
      }
      //delete user in database
      let userRef = db.collection(CollectionKeys.users)
        .document(user.uid)
      userRef.delete { (error) in
        if let error = error {
          return completion(error.localizedDescription)
        }
        //delete user in auth
        user.delete { (error) in
          if let error = error {
            return completion(error.localizedDescription)
          }
          Defaults.removeUser(true)
          completion(nil)
        }
      }
    }
  }
}
  
  func addUserFavoritePets(pet: PetDetailViewModel, completion: @escaping AlertErrorCompletion) {
    guard let userId = Customer.current?.userId else { return }
    db.collection(CollectionKeys.users)
      .document(userId)
      .collection(CollectionKeys.Users.favoritePets)
      .document("\(pet.id)")
      .setData(pet.asDictionary, merge: true) { (error) in
        if let error = error {
          return completion(AlertError(title: "Error saving pet", message: error.localizedDescription))
        }
        completion(nil)
      }
  }
  
  func removeUserFavoritePets(petId: String, completion: @escaping AlertErrorCompletion) {
    guard let userId = Customer.current?.userId else { return }
    db.collection(CollectionKeys.users)
      .document(userId)
      .collection(CollectionKeys.Users.favoritePets)
      .document(petId)
      .delete { (error) in
        if let error = error {
          return completion(AlertError(title: "Error deleting pet", message: error.localizedDescription))
        }
        completion(nil)
      }
  }
}
