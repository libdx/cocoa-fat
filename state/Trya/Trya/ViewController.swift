//
//  ViewController.swift
//  Trya
//
//  Created by Oleksandr Ignatenko on 25/01/2018.
//  Copyright © 2018 Oleksandr Ignatenko. All rights reserved.
//

import UIKit
import Style

class SomeView: UIView {
    let label: UILabel!
    let button: UIButton!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SomeView {
    func accept(state: WerViewController.ViewState) {
        accept(state: state.style)
        accept(state: state.data)
    }

    func accept(state style: WerViewController.ViewState.Style) {
        label.accept(state: style.titleLabel)

        button.accept(state: style.doneButton.0)
        button.accept(state: style.doneButton.1)

        label.accept(state: P1())

        button.accept(state: P4())
        button.accept(state: ThinRoundRect())
    }

    func accept(state: WerViewController.ViewState.Data) {
        label.text = state.titleText
    }
}

class WerInteractor {
    func load() -> WerState {
        return .waiting
    }

    func update(/* ? */) {

    }
}

protocol DataSource {
    func startLoading()
}

protocol DataTarget {
    associatedtype Data
    func update(with data: Data)
}

enum WerState {
    case waiting
    case info(value: SomeSubstate)

    struct SomeSubstate {
        var title: String
    }
}

class WerViewController: UIViewController, Component {

    let someView: SomeView? = nil

    typealias State = WerState

    struct ViewState {
        struct Style {
            let titleLabel = (P1())
            let doneButton = (P4(), ThinRoundRect())
        }
        let style = Style()

        struct Data {
            let titleText: String
        }
        var data = Data(titleText: "Test")
    }

    func viewState(for model: State) -> ViewState {
        return ViewState()
    }

    func apply(state: State) {
        let state = viewState(for: state)
        someView?.accept(state: state)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        apply(state: .info(value: .init(title: "moo")))
    }
}

