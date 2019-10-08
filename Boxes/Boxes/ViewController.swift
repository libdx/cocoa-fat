//
//  ViewController.swift
//  Boxes
//
//  Created by Oleksandr Ignatenko on 20/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

enum LoginViewState {
    case signIn(username: String)
    case signUp
}

enum LoginRequest {
    case latestUsername
    case usernameDidChange(String?)
    case passwordDidChange(String?)
    case signIn(username: String?, password: String?)
    case singUp
}

extension LoginResponse {
    enum Error: Swift.Error {
        case noConnection
        case invalidUsername
        case weakPassword
        case wrongCredentials
    }
}

enum LoginResponse {
    case success
    case error(LoginResponse.Error)
}

protocol LoginUI {
    var usernameField: UITextField! { get }
    var passwordField: UITextField! { get }
    var signInButton: UIButton! { get }
    var signUpButton: UIButton! { get }
}

final class LoginViewController<BL: BusinessLogic>: UIViewController, LoginUI where BL.Request == LoginRequest {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!

    var businessLogic: BL!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        businessLogic.performRequest(.latestUsername)
    }

    func usernameTextChanged(_ textField: UITextField) {
        businessLogic.performRequest(.usernameDidChange(textField.text))
    }

    func passwordTextChanged(_ textField: UITextField) {
        businessLogic.performRequest(.passwordDidChange(textField.text))
    }

    func signUpButtonTapped() {
        let username = usernameField.text
        let password = passwordField.text
        businessLogic.performRequest(.signIn(username: username, password: password))
    }
}

final class LoginWorker {

}

final class LoginBusinessLogic: BusinessLogic {
    var output: BusinessLogicOutput<LoginResponse>

    init(output: @escaping BusinessLogicOutput<LoginResponse>) {
        self.output = output
    }

    func performRequest(_ request: LoginRequest) {
//        switch request {
//        case .latestUsername:
//            <#code#>
//        case .usernameDidChange(_):
//            <#code#>
//        case .passwordDidChange(_):
//            <#code#>
//        case .signIn(let username, let password):
//            <#code#>
//        case .singUp:
//            <#code#>
//        }
    }
}
