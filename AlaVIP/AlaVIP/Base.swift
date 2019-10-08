//
//  Base.swift
//  AlaVIP
//
//  Created by Oleksandr Ignatenko on 29/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

typealias BusinessLogicOutput<Response> = (Response) -> ()

protocol BusinessLogic {
    associatedtype Response

    init(output: @escaping BusinessLogicOutput<Response>)
}

protocol ResponseProcessor {
    associatedtype Response
    func processResponse(_ response: Response)
}

protocol UserInterface: class {
    associatedtype ViewState
    var state: ViewState { get set }
    func updateView(to newState: ViewState)
}

protocol Presenter {
    associatedtype Response
    associatedtype ViewState
    func viewState(from response: Response, with oldState: ViewState) -> ViewState
}

class BaseResponseProcessor<UI: UserInterface, P: Presenter, R>: ResponseProcessor where UI.ViewState == P.ViewState, R == P.Response {

    weak var ui: UI?
    var presenter: P

    init(ui: UI, presenter: P) {
        self.ui = ui
        self.presenter = presenter
    }

    func processResponse(_ response: R) {
        if let ui = ui {
            let newState = presenter.viewState(from: response, with: ui.state)
            ui.updateView(to: newState)
            ui.state = newState
        }
    }
}

