//
//  Basics.swift
//  Components
//
//  Created by Oleksandr Ignatenko on 15/07/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

// StateController
// ModelController
// LogicController

import Foundation

//class Component<Action, State> {
//    var presenter: Presenter<State>!
//    var interactor: Interactor<Action>!
//    var viewController: UIViewController!
//}

class Interactor<Action> {
}

protocol PresenterDelegate: class {
    associatedtype State
    func stateDidChanged(_ state: State)
}

class Presenter<Delegate: PresenterDelegate> {
    weak var delegate: Delegate?
}

enum SomeState {
    case initial
}

class SomeViewController: UIViewController, PresenterDelegate {

    var presenter: Presenter<SomeViewController>!

    func stateDidChanged(_ state: SomeState) {

    }
}

func sample() {
    let p = Presenter<SomeViewController>()
}

// one function to build component
// one base interface of communication
// ability to extend interface of communication

protocol _Component: class {
    associatedtype S
}

class _MooComponent: _Component {
    typealias S = Moo
}

class _Presenter<State, C: _Component> {
    var state: State
    weak var component: C!
    init(state: State) {
        self.state = state
    }
}

enum Moo {
    case initial
}

func _sample() {
    let p = _Presenter<Moo, _MooComponent>(state: .initial)
}
