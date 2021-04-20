//
//  AppService.swift
//  Petulia
//
//  Created by Samuel Folledo on 4/15/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import UIKit

struct AppService {
    static func initRootView(rootController: UIViewController) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("could not get scene delegate ")
        }
        sceneDelegate.window?.rootViewController = rootController
        // A mask of options indicating how you want to perform the animations.
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        // Creates a transition animation.
        UIView.transition(with: sceneDelegate.window!, duration: 0.3, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
    }
}
