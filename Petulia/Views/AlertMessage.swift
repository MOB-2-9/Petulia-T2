//
//  AlertMessage.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct AlertError {
    var title: String = "Error"
    var message: String
}

enum AlertMessage {
    /// A message for errors with OK button
    case error(title: String = "Error", body: String = "")
    case alertError(alertError: AlertError)
    /// A message and OK button
    case information(body: String)
    /// A message and OK button
    case warning(body: String)
    /// A question with YES and NO buttons
    case confirmation(body: String, action: () -> Void)
    /// A question about destractive action with `action` and CANCEL buttons
    case destruction(body: String, label: String, action: () -> Void)
}

extension AlertMessage: Identifiable {
    var id: String { String(reflecting: self) }
}

extension AlertMessage {
    /// Builder of an Alert
    func show() -> Alert {
        switch self {
        case let .error(title, body):
            return Alert(
                title: Text(title),
                message: Text(body))
        
        case let .alertError(alertError):
            return Alert(
                title: Text(alertError.title),
                message: Text(alertError.message))
            
        case let .information(body):
            return Alert(
                title: Text("Information"),
                message: Text(body))

        case let .warning(body):
            return Alert(
                title: Text("Warning"),
                message: Text(body))
            
        case let .confirmation(body, action):
            return Alert(
                title: Text("Confirmation"),
                message: Text(body),
                primaryButton: .default(Text("YES"), action: action),
                secondaryButton: .cancel(Text("NO")))

        case let .destruction(body, label, action):
            return Alert(
                title: Text("Confirmation"),
                message: Text(body),
                primaryButton: .destructive(Text(label), action: action),
                secondaryButton: .cancel())
        }
    }
}
