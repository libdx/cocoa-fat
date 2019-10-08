//
//  RedViewController.swift
//  Trya
//
//  Created by Oleksandr Ignatenko on 11/02/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol InteractorX: class {
//    associatedtype Presenter: Trya.Presenter
//    weak var presenter: Presenter! { get set }

    associatedtype State
    associatedtype Action

    var present: (State) -> () { get set }

    init()

    func prepare()
    func start()
    func pause()
    func complete()

    func accept(action: Action)
}

class InteractorImplX<S, A>: InteractorX {

    required init() {}

    var present: (State) -> () = { _ in }

    func prepare() {

    }

    func start() {

    }

    func pause() {

    }

    func complete() {

    }

    func accept(action: A) {

    }

    typealias State = S
    typealias Action = A
}

final class RedInteractorImplX<S, A>: InteractorImplX<S, A> {
}

protocol PresenterX: class {
    associatedtype Interactor: Trya.InteractorX

    var interactor: Interactor! { get set }

    func present(state: Interactor.State)
}

extension PresenterX {
    static func makeInteractor() -> Interactor {
        return Interactor()
    }

    func makeInteractor() -> Interactor {
        return Interactor()
    }
}

protocol Mediator_: class {
    associatedtype State
    associatedtype Action

    func present(state: State)
    func accept(action: Action)
}

final class MediatorImpl<S, A>: Mediator_ {
    typealias State = S
    typealias Action = A

    func present(state: State) {}
    func accept(action: Action) {}
}

enum RedActionX {}
enum RedStateX {}

final class RedInteractorX<S, A>: InteractorX {

    typealias State = S
    typealias Action = A

    var present: (State) -> () = { _ in }

    func prepare() {}
    func start() {}
    func pause() {}
    func complete() {}

    func accept(action: Action) {}
}

final class RedViewControllerX<S, A>: UIViewController, PresenterX {
    typealias Interactor = InteractorImplX<S, A>

    var interactor: Interactor!

    func present(state: Interactor.State) {}
}

final class RedComponentX {

//    func make() -> PresenterX<>

    func sample() {

        typealias Presenter = RedViewControllerX<RedStateX, RedActionX>
        let presenter0 = Presenter()
        let interactor0 = Presenter.makeInteractor()

        let presenter = RedViewControllerX<RedStateX, RedActionX>()
        let interactor = presenter.makeInteractor()

        presenter.interactor = interactor
        interactor.present = { [weak presenter] state in
            presenter?.present(state: state)
        }

//        typealias Interactor = RedInteractorX<RedStateX, RedActionX>
//
//        let interactor = Interactor()
//        let presenter = RedViewControllerX<Interactor>()
//
//        presenter.interactor = interactor
//        interactor.present = { [weak presenter] state in
//            presenter?.present(state: state)
//        }
    }
}

protocol Interactor0: class {
    associatedtype Action

    func prepare()
    func start()
    func pause()
    func complete()

    func accept(action: Action)
}

extension Interactor0 {
    func prepare() {}
    func start() {}
    func pause() {}
    func complete() {}

    func accept(action: Action) {}
}

protocol Interactor1: Interactor0 {
    associatedtype Presenter: Trya.Presenter0
    weak var presenter: Presenter! { get set }
}



protocol Presenter0: class {
    associatedtype State
    func present(state: State)
}

protocol Presenter1: Presenter0 {
    associatedtype Interactor: Trya.Interactor0
    var interactor: Interactor! { get set }
}

enum MooAction {

}

class MooInteractor0<A>: Interactor0 {
    typealias Action = A
}

final class MooInteractor<P: Presenter0, A>: MooInteractor0<A>, Interactor1 {

    typealias Presenter = P

    weak var presenter: P!
}

final class MooViewController<I: Interactor0>: UIViewController, Presenter1 {
    typealias Interactor = I
    enum State {}

    var interactor: I!

    func present(state: State) {}

}

final class MooComponent {
    func sample() {
        typealias BaseInteractor = MooInteractor0<MooAction>
        typealias BasePresenter = MooViewController<BaseInteractor>

        let presenter = BasePresenter()
        let interactor = MooInteractor<BasePresenter, MooAction>()

        interactor.presenter = presenter
        presenter.interactor = interactor

//        let interactor = RedInteractor<RedViewController>()
//        let presenter = RedViewController()
//
//        interactor.presenter = presenter
//        presenter.interactor = interactor
    }
}

///////////////

protocol Interactor: class {
    associatedtype Presenter: Trya.Presenter

    weak var presenter: Presenter! { get set }

    func prepare()
    func start()
    func pause()
    func complete()

    func accept(action: Presenter.Action)
}

protocol Presenter: class {
    associatedtype Interactor: Trya.Interactor
    associatedtype State
    associatedtype Action

    var interactor: Interactor! { get set }

    func present(state: State)
}

extension Interactor {
    func prepare() {}
    func start() {}
    func pause() {}
    func complete() {}

    func accept(action: Presenter.Action) {}
}

class BaseInteractor<P: Presenter>: Interactor {
    weak var presenter: P!

    typealias Presenter = P
    typealias Action = P.Action
}

extension Presenter where Self: UIViewController {
}

final class RedInteractor<P: Presenter>: BaseInteractor<P> {
    func accept(action: Action) {}

    private func calculateRedDegree() {}
}

final class RedViewController: UIViewController, Presenter {
    typealias State = RedState
    typealias Action = RedAction
    typealias Interactor = BaseInteractor<RedViewController>

    var interactor: Interactor!

    func present(state: State) {}
}

enum RedState {}
enum RedAction {}

//final class AppComponent<P: Presenter, I: Interactor> {

//}

final class RedAppComponent {

    func assemble<P: Presenter, I>(_ presenter: P, _ interactor: I) where I == P.Interactor, P == I.Presenter {
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    func make() -> UIViewController {
        let presenter = RedViewController()

//        let intr = RedViewController.Interactor()
        let interactor = RedInteractor<RedViewController>()

        assemble(presenter, interactor)

        return presenter
    }
}

////////////////////

protocol Mediator: class {
    associatedtype State
    associatedtype Action

    var _present: ((State) -> ())! { get set }
    var _accept: ((Action) -> ())! { get set }
}

protocol MPresenter: class {
    associatedtype Mediator: Trya.Mediator

    var mediator: Mediator! { get set }

    func present(state: Mediator.State)
}

protocol MInteractor: class {
    associatedtype Mediator: Trya.Mediator

    var mediator: Mediator! { get set }

    func accept(action: Mediator.Action)
}

protocol MPresenterR: class {
    associatedtype Interactor: MediatorInteractor
    associatedtype State

    var interactor: Interactor! { get }

    func present(state: State)
}

protocol MInteractorR: class {
    associatedtype Presenter: MediatorPresenter
    associatedtype Action

    var presenter: Presenter! { get }

    func accept(action: Action)
}

class BaseMediator<S, A>: Mediator {
    typealias State = S
    typealias Action = A

    var _present: ((State) -> ())!
    var _accept: ((Action) -> ())!
}

protocol MediatorInteractor: class {
    associatedtype Action

    var accept: ((Action) -> ())! { get set }
}

protocol MediatorPresenter: class {
    associatedtype State

    var present: ((State) -> ())! { get set }
}

final class ForwardInteractor<A>: MediatorInteractor {
    typealias Action = A

    var accept: ((Action) -> ())!
}

final class ForwardPresenter<S>: MediatorPresenter {
    typealias State = S

    var present: ((State) -> ())!
}

final class MegaInteractor: MInteractorR {
    typealias Action = RedAction
    typealias State = RedState
    typealias Presenter = ForwardPresenter<State>
    var presenter: Presenter!
    func accept(action: Action) {}
}

final class MegaViewController: UIViewController, MPresenterR {
    typealias Action = RedAction
    typealias State = RedState
    typealias Interactor = ForwardInteractor<Action>
    var interactor: Interactor!
    func present(state: State) {}
}

class BaseComponent<S, A> {
//    func assemble<M: Mediator, I: MInteractor, P: MPresenter>(mediator: M, interactor: I, presenter: P) where M == MInteractor.Mediator {
//
//        mediator.present = presenter.present
//        mediator.accept = interactor.accept
//
//        presenter.mediator = mediator
//        interactor.mediator = mediator
//    }
}

class MegaComponent {
    func make() -> UIViewController {
        let presenter = MegaViewController()
        let interactor = MegaInteractor()

        let forwardInteractor = ForwardInteractor<MegaInteractor.Action>()
        let forwardPresenter = ForwardPresenter<MegaViewController.State>()

        forwardPresenter.present = { [weak presenter] state in
            presenter?.present(state: state)
        }
        forwardInteractor.accept = interactor.accept

        presenter.interactor = forwardInteractor
        interactor.presenter = forwardPresenter

        return presenter
    }

    static func sample() {
        let component = MegaComponent()
        let controller = component.make()
    }
}

