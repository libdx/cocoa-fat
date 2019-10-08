//
//  ViewController.swift
//  AlaVIP
//
//  Created by Oleksandr Ignatenko on 29/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol SignInBusinessLogic: BusinessLogic {
    func performRequest(_ request: SignInRequest.ValidateUsername)
    func performRequest(_ request: SignInRequest.ValidatePassword)
    func performRequest(_ request: SignInRequest.SignIn)
}

final class SignInInteractor: SignInBusinessLogic {

    let output: BusinessLogicOutput<SignInResponse>

    init(output: @escaping BusinessLogicOutput<SignInResponse>) {
        self.output = output
    }

    func performRequest(_ request: SignInRequest.ValidateUsername) {
        let username = request.username

    }

    func performRequest(_ request: SignInRequest.ValidatePassword) {

    }

    func performRequest(_ request: SignInRequest.SignIn) {

    }
}

struct SignInResponse {

}

struct SignInRequest {
    struct ValidateUsername {
        let username: String?
    }

    struct ValidatePassword {
        let password: String?
    }

    struct SignIn {
        let username: String?
        let password: String?
    }
}

class SignInViewController<BL: SignInBusinessLogic>: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    var businessLogic: BL!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func usernameDidChange(_ textField: UITextField) {
        let request = SignInRequest.ValidateUsername(username: textField.text)
        businessLogic.performRequest(request)
    }

    func passwordDidChange(_ textField: UITextField) {
        let request = SignInRequest.ValidatePassword(password: textField.text)
        businessLogic.performRequest(request)
    }

    func signInButtonTapped() {
        let request = SignInRequest.SignIn(username: usernameField.text, password: passwordField.text)
        businessLogic.performRequest(request)
    }
}

