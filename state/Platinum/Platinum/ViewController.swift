//
//  ViewController.swift
//  Platinum
//
//  Created by Oleksandr Ignatenko on 28/02/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

protocol AnyPresenter: class {
    var _interactor: AnyInteractor! { get }
}

protocol AnyInteractor: class {
    weak var _presenter: AnyPresenter! { get }
}

protocol Presenter: AnyPresenter {
    associatedtype State

    func receive(state: State)
}

protocol Interactor: AnyInteractor {
    associatedtype Action

    func dispatch(action: Action)
}

// MARK: Some

enum SomeState {}
enum SomeAction {}

protocol SomeInteractor: Interactor where Action == SomeAction {
}

protocol SomePresenter: Presenter where State == SomeState {
}

final class ASomeInteractor: SomeInteractor {
    weak var _presenter: AnyPresenter!

    var presenter: SomePresenter {
        return _presenter as! SomePresenter
    }

    func dispatch(action: SomeAction) {
        switch action {
        default:
            break
        }
    }
}

final class SomeViewController: SomePresenter {
    var _interactor: AnyInteractor!

    func receive(state: SomeState) {
        switch state {
        default:
            break
        }
    }
}

func sample() {
}






