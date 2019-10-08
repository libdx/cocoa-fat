//
//  Components.swift
//  Output
//
//  Created by Oleksandr Ignatenko on 04/04/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import Foundation


protocol InteractorOutput: class {
    associatedtype State

    func stateChanged(_ state: State)
}

protocol InteractorInput: class {
    associatedtype Action

    func handle(action: Action)

    func prepare()
    func start()
    func pause()
    func complete()
}

protocol Presenter {
    associatedtype Input: InteractorInput
    var interactor: Input! { get }
}

protocol Interactor {
    associatedtype Output: InteractorOutput
    var output: Output! { get }
}

enum SomeAction {}
enum SomeState {}

final class SomePresenter<I: InteractorInput>: Presenter, InteractorOutput {
    typealias Input = I
    typealias State = SomeState

    var interactor: Input!

    func stateChanged(_ state: SomeState) {

    }
}

final class SomeInteractor<O: InteractorOutput>: Interactor, InteractorInput {
    typealias Output = O
    typealias Action = SomeAction

    weak var output: Output!

    func handle(action: SomeAction) {

    }

    func prepare() {

    }

    func start() {

    }

    func pause() {

    }

    func complete() {

    }
}

func smaple() {
    let presenter = SomePresenter()
    let interactor = SomeInteractor()
}
