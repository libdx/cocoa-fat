//
//  SignInViewController+Interacting.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

// Interaction (Propagating to Business Login)

extension SignInViewController: SignInInteracting {}

extension SignInViewController {
    @objc func usernameDidChange() {

    }

    @objc func passwordDidChange() {
        let password = passwordTextField?.text ?? ""
        uiDidChangePassword(password)
    }

    @objc func signInButtonTapped() {
        let username = usernameTextField?.text ?? ""
        let password = passwordTextField?.text ?? ""
        uiDidSignIn(username: username, password: password)
    }
}
