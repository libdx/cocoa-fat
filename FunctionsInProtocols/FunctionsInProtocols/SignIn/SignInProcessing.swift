//
//  SignInProcessing.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SignInProcessing {
    var state: SignInState { get }

    func signIn(username: String, password: String) -> SignInState
    func validate(password: String) -> SignInState
}

extension SignInProcessing where Self: SignInNetworking {

    func signIn(username: String, password: String) -> SignInState {
        let username = username
        let password = password

        let isSignedIn = performSignIn(username: username, password: password)
        var state = self.state
        state.isSignedIn = isSignedIn
        return state
    }
}

extension SignInProcessing where Self: SignInValidating {

    func validate(password: String) -> SignInState {
        let isValid = isPasswordValid(password)
        var state = self.state
        state.isValid = isValid
        return state
    }
}
