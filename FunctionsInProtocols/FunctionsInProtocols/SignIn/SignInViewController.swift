//
//  SignInViewController.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol SignInDisplaying: class {
    var state: SignInState { get set }
}

protocol SignInStateUpdating: class {
    func update(to state: SignInState)
}

// Main Advantage: the only one Lifecycle object - ViewController:
// - no retain cycles
// - no ...

// UI (ViewController setup boilerplate)

class SignInViewController: UIViewController, SignInDisplaying {

    @IBOutlet var usernameTextField: UITextField? = UITextField()
    @IBOutlet var passwordTextField: UITextField? = UITextField()
    @IBOutlet var signInButton: UIButton? = UIButton()

    var state = SignInState() {
        willSet {
            update(to: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField?.addTarget(self, action: #selector(usernameDidChange), for: .editingChanged)
        passwordTextField?.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        signInButton?.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        uiDidLoad()
    }
}

// Business Logic (No code here! All done in protocol extensions)

extension SignInViewController: SignInProcessing, SignInValidating, SignInNetworking {
}
