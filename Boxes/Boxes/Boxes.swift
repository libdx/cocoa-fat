//
//  Boxes.swift
//  Boxes
//
//  Created by Oleksandr Ignatenko on 20/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import UIKit

func compose<A, B, C>(_ fn1: @escaping (A) -> B, _ fn2: @escaping (B) -> C) -> (A) -> C {
    return { a in fn2(fn1(a)) }
}

typealias BusinessLogicOutput<Response> = (Response) -> ()

protocol BusinessLogic {
    associatedtype Request
    associatedtype Response
    var output: BusinessLogicOutput<Response> { get }
    func performRequest(_ request: Request)
}

protocol Presenter: class {
    associatedtype UI
    associatedtype ViewState
    associatedtype Response

    var ui: UI? { get }
    var currentState: ViewState { get set }

    init(ui: UI?)
    func viewState(basedOn oldState: ViewState, from response: Response) -> ViewState
    func updateView(of ui: UI, with viewState: ViewState, basedOn oldState: ViewState)
    func processResponse(_ response: Response)
}

extension Presenter {
    func processResponse(_ response: Response) {
        if let ui = ui {
            let newState = viewState(basedOn: currentState, from: response)
            updateView(of: ui, with: newState, basedOn: currentState)
            currentState = newState
        }
    }
}

// MARK: Sample Implementation

protocol QUI: class {
    var saveButton: UIButton! { get }
    var titleLabel: UILabel! { get }
    var emailField: UITextField! { get }
}

final class QViewController<BL: BusinessLogic>: UIViewController, QUI where BL.Request == QRequest {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!

    var businessLogic: BL!

    func usernameDidChange(_ textField: UITextField) {
        businessLogic.performRequest(.changeEmail(emailField.text ?? ""))
    }

    func saveButtonDidTapped() {
        businessLogic.performRequest(.save)
    }
}

enum QRequest {
    case changeEmail(String)
    case save
}

enum QResponse {
    case started
    case finished([Int])
}

enum QViewState {
    case initial
    case loaded(QLoadedState)
}

struct QLoadedState {
    var list: [Int]
}

final class /* struct */ QBusinessLogic: BusinessLogic {
    typealias Request = QRequest
    typealias Response = QResponse

    let output: BusinessLogicOutput<Response>

    init(output: @escaping BusinessLogicOutput<Response>) {
        self.output = output
    }

    func performRequest(_ request: Request) {
        output(.started)
        // ...
        DispatchQueue.main.async {
            let list = [2, 3, 4]
            self.output(.finished(list))
        }
    }
}

final class QPresenter: Presenter {
    var currentState: QViewState
    weak var ui: QUI?

    init(ui: QUI?) {
        self.ui = ui
        currentState = .initial
    }

    func viewState(basedOn oldState: QViewState, from response: QResponse) -> QViewState {
        return .initial
    }

    func updateView(of ui: QUI, with viewState: QViewState, basedOn oldState: QViewState) {
        ui.saveButton.titleLabel?.text = "Save"
        ui.titleLabel.text = "QSample"
        ui.emailField.text = "email@example.com"
    }
}

func QSample() {
    let viewController = QViewController<QBusinessLogic>()
    let presenter = QPresenter(ui: viewController)
    viewController.businessLogic = QBusinessLogic(output: presenter.processResponse)
}

func QPretertest() {
    let presenter = QPresenter(ui: nil)
    let state = presenter.viewState(basedOn: .initial, from: .finished([1, 2, 3]))
    // assert state
}

func QBusinessLogicTest() {
    let processResponse: (QResponse) -> Void = { response in
        // assert response
    }

    let logic = QBusinessLogic(output: processResponse)
    logic.performRequest(.save)
}

func QViewControllerTest() {
    let viewController = QViewController<QBusinessLogic>()

    // assert nothing
}
