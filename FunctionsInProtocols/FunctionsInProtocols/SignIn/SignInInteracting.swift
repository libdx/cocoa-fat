//
//  SignInInteracting.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SignInInteracting {
    var ui: SignInDisplaying? { get }

    func uiDidLoad()
    func uiDidSignIn(username: String, password: String)
    func uiDidChangePassword(_ passwrod: String)
}

extension SignInInteracting where Self: SignInDisplaying {
    var ui: SignInDisplaying? {
        return self
    }
}

extension SignInInteracting where Self: SignInProcessing {

    func uiDidLoad() {
        ui?.state = SignInState()
    }

    func uiDidSignIn(username: String, password: String) {
        ui?.state = signIn(username: username, password: password)
    }

    func uiDidChangePassword(_ password: String) {
        ui?.state = validate(password: password)
        print(ui!.state)
    }
}
