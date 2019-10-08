//
//  SceneInteracting.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SceneInteracting {
    func uiDidLoad()
    func uiDidTapEdit()
    func uiDidChangeOptions(_ options: DrawingOptions)
    func uiDidAddNewShape(_ shape: Shape)
    func uiDidTapClear()
}

extension SceneInteracting where Self: SceneProcessing, Self: SceneStateDisplaying {
    func uiDidLoad() {
        state = SceneState()
    }

    func uiDidChangeOptions(_ options: DrawingOptions) {
        state = changeDrawingOptions(options)
    }

    func uiDidAddNewShape(_ shape: Shape) {
        state = addNewShape(shape)
    }

    func uiDidTapClear() {
        state = clearShapes()
    }
}

extension SceneInteracting where Self: SceneRouting {
    func uiDidTapEdit() {
        showDrawingOptions()
    }
}
