//: Playground - noun: a place where people can play

import UIKit

protocol Presenter: class {
    associatedtype _Interactor: Interactor
    associatedtype State

    var interactor: _Interactor! { get set }

    func receive(state: State)
}

protocol Interactor: class {
    associatedtype State
    associatedtype Action

    var _send: ((State) -> ())! { get set }

    func send(state: State)
    func dispatch(action: Action)
}

extension Interactor {
    func send(state: State) {
        _send(state)
    }
}

extension Interactor {
    func dispatch(action: Action) {}
}

enum SomeState { case initial }
enum SomeAction { case none }

final class SomeViewController<I: Interactor>: UIViewController, Presenter {
    typealias State = SomeState
    typealias _Interactor = I

    var interactor: _Interactor!

    func receive(state: SomeState) {}
}

class BaseInteractor<S, A>: Interactor {
    typealias State = S
    typealias Action = A

    var _send: ((State) -> ())!
}

class SomeInteractor: BaseInteractor<SomeState, SomeAction> {
    func dispatch(action: SomeAction) {}
}

let presenter = SomeViewController<SomeInteractor>()
let interactor = SomeInteractor()

presenter.interactor = interactor
interactor._send = { [weak presenter] state in
    presenter?.receive(state: state)
}

interactor.send(state: .initial)
presenter.interactor.dispatch(action: .none)

/////

protocol StateSubscriber {
    associatedtype State
    func receive(state: State)
}

final class SomeListner: StateSubscriber {
    typealias State = SomeState

    func receive(state: SomeState) {

    }
}

class Notifier<Sub: StateSubscriber> {
    var subscribers: [Sub] = []
    func subscribe(_ subscriber: Sub) {
        subscribers.append(subscriber)
    }

    func broadcast(state: Sub.State) {
        subscribers.forEach { $0.receive(state: state) }
    }
}

let notifier = Notifier<SomeListner>()
let listner = SomeListner()
notifier.subscribe(listner)
