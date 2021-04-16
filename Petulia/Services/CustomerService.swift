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

struct CustomerService {
  
  // MARK: - Type Aliases
  
  // MARK: - Static Methods
  
  static func createCustomer(name: String, email: String, password: String, completion: @escaping AlertErrorCompletion) {
    //1. Create Firebase User
    auth.createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        return completion(AlertError(title: "Error authenticating user", message: error.localizedDescription))
      }
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
        createUserInDatabase(name: name, email: email) { (customer, alertError) in
          if let alertError = alertError {
            return completion(alertError)
          }
          //4. Save customer to UserDefaults
          guard let customer = customer else { return }
          Customer.setCurrent(customer, writeToUserDefaults: true)
          completion(nil)
        }
      }
    }
  }
  
  private static func createUserInDatabase(name: String, email: String, completion: @escaping CustomerWithAlertErrorCompletion) {
    let userDoc = db.collection(CollectionKeys.users).document()
    let customer = Customer(documentId: userDoc.documentID, name: name, email: email)
    db.collection(CollectionKeys.users)
      .document(userDoc.documentID)
      .setData(customer.asDictionary, merge: true) { (error) in
        if let error = error {
          return completion(nil, AlertError(title: "Error creating user in database", message: error.localizedDescription))
        }
        completion(customer, nil)
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
  
  ///register and create a user
  fileprivate static func createUserInDatabase(customer: Customer, completion: @escaping AlertErrorCompletion) {
    db.collection(CollectionKeys.users)
      .document(customer.userId)
      .setData(customer.asDictionary) { (error) in
        if let error = error {
          return completion(AlertError(title: "Error saving user to database", message: error.localizedDescription))
        }
        completion(nil)
      }
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
          completion(nil)
        }
      }
    }
  }
}
