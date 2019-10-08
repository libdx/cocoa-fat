//
//  Generics.swift
//  Boxes
//
//  Created by Oleksandr Ignatenko on 28/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import UIKit

protocol Interactor {
    func performRequest<Request, Response>(_ request: Request, response: (Response) -> ())
}

protocol Presenter_ {
    func viewState<ViewState, Response>(from response: Response, with oldState: ViewState) -> ViewState
}

protocol UserInterface {
    func updateView<ViewState>(to newState: ViewState)
}

class HInteractor: Interactor {
    func performRequest<Request, Response>(_ request: Request, response: (Response) -> ()) {

    }

    func bar() {}
}

class HPresenter: Presenter_ {
    func viewState<ViewState, Response>(from response: Response, with oldState: ViewState) -> ViewState {
        return oldState
    }
}

final class HViewController<I: Interactor>: UIViewController, UserInterface {
    var interactor: I!

    func updateView<ViewState>(to newState: ViewState) {

    }
}

func HSample() {
    let viewController = HViewController<HInteractor>()
    viewController.interactor = HInteractor()
    viewController.interactor.bar()
}
