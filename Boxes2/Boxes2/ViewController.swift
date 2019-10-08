//
//  ViewController.swift
//  Boxes2
//
//  Created by Oleksandr Ignatenko on 29/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

/* Business Logic */

class SignInNetworkWorker {
    func fetchToken(_ completion: @escaping (String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let token = "sdfsd"
            completion(token)
        }
    }
}

class SingInDiskWorker {
    func saveToken(_ token: String?) -> Bool {
        if let token = token {
            // ...
            return true
        } else {
            return false
        }
    }
}

struct SignInRequest {
    let username: String?
    let password: String?
}

struct SignInResponse {
    let isLoading: Bool
    let isSinedIn: Bool
}

extension SignInRequest: Request {
    func start(_ output: @escaping (Response) -> Void) {
        let networkWorker = SignInNetworkWorker()
        let diskWorker = SingInDiskWorker()

        output(SignInResponse(isLoading: true, isSinedIn: false))
        networkWorker.fetchToken { token in
            let isSinedIn = token.map(diskWorker.saveToken) ?? false
            output(SignInResponse(isLoading: false, isSinedIn: isSinedIn))
        }
    }
}

/* Presentation */

struct SignInViewState {
    var isLoading: Bool
    var details: String

    static var initial: SignInViewState {
        return SignInViewState(isLoading: false, details: "")
    }
}

extension SignInViewState: ViewState {
    func viewState(from response: SignInResponse) -> SignInViewState {
        var state = self
        state.isLoading = isLoading
        state.details = response.isSinedIn ? "You're Sined In" : "You're Sined Out"
        return state
    }
}

//extension Response {
//    func accept(_ oldState: SignInViewState) -> SignInViewState {
//        return accept(oldState)
//    }
//}

extension SignInResponse: Response {
    func accept<S>(_ oldState: S) -> S {
        return oldState.viewState(from: self)
    }

//    func accept(_ oldState: SignInViewState) -> SignInViewState {
//        return oldState.viewState(from: self)
//    }
}

final class SignInPresenter: BasePresenter<SignInViewState> {
    override func viewState(from response: Response, with oldState: SignInViewState) -> SignInViewState {
        return response.accept(oldState)
    }
}

////////////

class SingInViewController: UIViewController, UserInterface {

    var state: SignInViewState = .initial

    var interactor: Interactor!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = SignInRequest(username: "test", password: "retest")
        interactor.performRequest(request)
    }
}

extension SingInViewController {
    func updateView(to newState: SignInViewState) {

    }
}

func setupSignInViewController(_ viewController: SingInViewController) {
    let presenter = SignInPresenter()
    let responseProcessor = ResponseProcessor(ui: viewController, presenter: presenter)
    let interactor = BaseInteractor(output: responseProcessor.processResponse)
    viewController.interactor = interactor
}
