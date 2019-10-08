//
//  SignInViewController+SignInStateUpdating.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

// UI (Updating according to state)

extension SignInViewController: SignInStateUpdating {
    func update(to state: SignInState) {
        usernameTextField?.text = state.username
        passwordTextField?.text = state.password

        passwordTextField?.backgroundColor = state.isValid ? .white : .red

        if let direction = state.navigation?.direction {
            switch direction {
            case .welcome:
                // TODO:
                // navigaitonController.push... or better implement Router to access `Navigation` values
                break
            default:
                break
            }
        }
    }
}
