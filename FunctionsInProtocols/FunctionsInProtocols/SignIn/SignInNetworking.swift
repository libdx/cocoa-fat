//
//  SignInNetworking.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SignInNetworking {
    var client: ShoppingMallSupport { get }
    func performSignIn(username: String, password: String) -> Bool
}

extension SignInNetworking {

    var client: ShoppingMallSupport {
        return ShoppingMallClient.shared
    }

    func performSignIn(username: String, password: String) -> Bool {
        return true
    }
}
