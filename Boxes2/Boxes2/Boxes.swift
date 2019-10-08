//
//  Boxes.swift
//  Boxes2
//
//  Created by Oleksandr Ignatenko on 29/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol Request {
    func start(_ output: @escaping (Response) -> Void)
}

protocol Response {
    func accept<S>(_ oldState: S) -> S
}

//extension Response {
//    func accept(with oldState: ViewState) -> ViewState {
//        return oldState.viewState(from: self)
//    }
//}

protocol ViewState {
//    func viewState(from response: Response) -> ViewState
}

protocol Interactor {
    init(output: @escaping (Response) -> Void)
    func performRequest(_ request: Request)
}

class BaseInteractor: Interactor {
    let output: (Response) -> Void

    required init(output: @escaping (Response) -> Void) {
        self.output = output
    }

    func performRequest(_ request: Request) {
        request.start(output)
    }
}

protocol Presenter {
    associatedtype S: ViewState
    func viewState(from response: Response, with oldState: S) -> S
}

class BasePresenter<S: ViewState>: Presenter {
    func viewState(from response: Response, with oldState: S) -> S {
        return oldState
//        return response.accept(oldState) as! S // "!" is for runtime check
    }
}

protocol UserInterface: class {
    associatedtype S: ViewState
    var state: S { get set }
    func updateView(to newState: S)
}

class ResponseProcessor<UI: UserInterface, P: Presenter> where UI.S == P.S {

    weak var ui: UI?
    var presenter: P

    init(ui: UI, presenter: P) {
        self.ui = ui
        self.presenter = presenter
    }

    func processResponse(_ response: Response) {
        if let ui = ui {
            let newState = presenter.viewState(from: response, with: ui.state)
            ui.updateView(to: newState)
            ui.state = newState
        }
    }
}
