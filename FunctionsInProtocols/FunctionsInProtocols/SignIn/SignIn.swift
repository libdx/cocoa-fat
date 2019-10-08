//
//  Login.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 28/04/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

// If you need to do background work define (+ write extension):
//protocol SignInWorkering { ... }

// If you need to to be informed, define (+ write extension):
//protocol SignInObserving { ... }

// Some of this protocols can be implemented by separate types independent of ViewController and be added to latest as properties

//// Redundant
//final class SigninLogic: SignInInteracting, SignInProcessing, SignInValidating, SignInNetworking {
//
//    var state: SignInState {
//        return ui!.state
//    }
//
//    weak var ui: SignInDisplaying?
//
//    init(ui: SignInDisplaying) {
//        self.ui = ui
//    }
//}
////

struct SignInState {
    var username: String = "joe.doe@example.com"
    var password: String = "WEr342-234sf-4rer"
    var isValid: Bool = true
    var isSignedIn: Bool = false
    var wantsToSignUp: Bool = false

    var navigation: SignInNavigation? {
        return isSignedIn ? SignInNavigation(.welcome) : nil
    }
}

struct SignInNavigation {
    enum Direction {
        case welcome
        case signUp
    }

    var direction: Direction

    init(_ direction: Direction = .welcome) {
        self.direction = direction
    }
}

// Testing

final class Test_SignInValidatingLogic: SignInValidating {}

final class Test_SignInProcessingLogic: SignInProcessing, SignInValidating, SignInNetworking {
    var state = SignInState()

    var client: ShoppingMallSupport {
        return ShoppingMallClientMock.shared
    }
}

final class ShoppingMallClientMock: Networking, ShoppingMallSupport {
    typealias AuthToken = ShoppingMallAuthToken
    var token: ShoppingMallAuthToken?
    static let shared = ShoppingMallClientMock()
}
