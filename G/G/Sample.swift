//
//  Sample.swift
//  G
//
//  Created by Oleksandr Ignatenko on 29/12/2017.
//  Copyright © 2017 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import UIKit

protocol Screen {
    associatedtype Model
    associatedtype ViewState

    init(model: Model)
    func viewState(from model: Model) -> ViewState
}

struct StartScreen: Screen {
    var model: Introduction

    init(model: Introduction) {
        self.model = model
    }

    func viewState(from model: Introduction) -> ViewState {
        return ViewState(
            titleLabel: ViewState.TitleLabel(text: model.title),
            messageLabel: ViewState.MessageLabel(text: model.message)
        )
    }
}

extension StartScreen {
    struct Introduction {
        let title: String
        let message: String
    }

    struct ViewState {
        let titleLabel: TitleLabel
        let messageLabel: MessageLabel

        struct TitleLabel {
            let text: String
        }

        struct MessageLabel {
            let text: String
        }
    }
}

struct StatusScreen: Screen {
    var count: Int

    init(model: Int) {
        self.count = model
    }

    func viewState(from count: Int) -> String {
        return "Count: \(count)"
    }
}

struct ConvertScreen: Screen {
    var model: (Double, Double)

    init(model: (Double, Double)) {
        self.model = model
    }

    func viewState(from model: (Double, Double)) -> (String, String) {
        return ("input: \(model.0)", "output: \(model.1)")
    }
}

struct WizardScreen: Screen {
    typealias Model = (imageName: String, message: String)
    var model: Model

    func viewState(from model: Model) -> (UIImage, String) {
        return (UIImage(named: model.imageName)!, model.message)
    }
}

let introduction = StartScreen.Introduction(title: "Hi there!", message: "Start you'r journey now!")
let count = 5
let inputOutput = (42.0, 107.6)

enum Screens {
    static let start: StartScreen = StartScreen(model: introduction)
    static let status: StatusScreen = StatusScreen(model: count)
    static let convert: ConvertScreen = ConvertScreen(model: inputOutput)
    static let progress: [WizardScreen] = [WizardScreen(model: ("x", "bkk")), WizardScreen(model: ("t", "mmr"))]
}

