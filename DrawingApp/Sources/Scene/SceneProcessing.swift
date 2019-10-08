//
//  SceneProcessing.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SceneProcessing {
    var state: SceneState { get }

    func changeDrawingOptions(_ options: DrawingOptions) -> SceneState
    func addNewShape(_ shape: Shape) -> SceneState
    func clearShapes() -> SceneState
}

extension SceneProcessing {
    func changeDrawingOptions(_ options: DrawingOptions) -> SceneState {
        var state = self.state
        state.drawingOptions = options
        return state
    }

    func addNewShape(_ shape: Shape) -> SceneState {
        var state = self.state
        state.shapes.append(shape)
        return state
    }

    func clearShapes() -> SceneState {
        var state = self.state
        state.shapes = []
        return state
    }
}
