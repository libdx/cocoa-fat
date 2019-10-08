//
//  SignInValidating.swift
//  FunctionsInProtocols
//
//  Created by Oleksandr Ignatenko on 02/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SignInValidating {
    func isPasswordValid(_ password: String) -> Bool
}

extension SignInValidating {
    func isPasswordValid(_ password: String) -> Bool {
        return password.count > 6
    }
}
