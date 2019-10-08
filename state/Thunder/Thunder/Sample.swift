//
//  Sample.swift
//  Thunder
//
//  Created by Oleksandr Ignatenko on 17/02/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol Presenter: class {
    associatedtype Interactor: Thunder.Interactor

    var interactor: Interactor! { get set }

    func receive(state: Interactor.State)
}

protocol Interactor: class {
    associatedtype State
    associatedtype Action

    var sendState: ((State) -> ())! { get set }

    func send(state: State)
    func dispatch(action: Action)
}

extension Interactor {
    func send(state: State) {
        sendState(state)
    }
}

extension Interactor {
    func dispatch(action: Action) {}
}

enum SomeState { case initial }
enum SomeAction { case none }

final class SomeViewController: UIViewController, Presenter {
    typealias State = SomeState
    typealias Interactor = BaseInteractor<SomeState, SomeAction>

    var interactor: Interactor!

    func receive(state: SomeState) {}
}

class BaseInteractor<S, A>: Interactor {
    typealias State = S
    typealias Action = A

    var sendState: ((State) -> ())!
}

class SomeInteractor: BaseInteractor<SomeState, SomeAction> {
    func dispatch(action: SomeAction) {}
}

class AppComponent {

    func compose<P: Presenter, I>(presenter: P, interactor: I) where I == P.Interactor {
        presenter.interactor = interactor
        interactor.sendState = { [weak presenter] state in
            presenter?.receive(state: state)
        }
    }

    func make() -> UIViewController {
        let presenter = SomeViewController()
        let interactor = SomeInteractor()

        compose(presenter: presenter, interactor: interactor)

        return presenter
    }
}
