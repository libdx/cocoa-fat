//
//  SceneOptionsProcessing.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 13/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation
import CoreGraphics

extension DrawingOptions {
    var sliderValue: Float {
        return Float(graphicsOptions.lineWidth / DrawingOptions.lineWidthRatio)
    }
}

protocol SceneOptionsProcessing {
    var state: SceneOptionsState { get }
    
    func changeLineWidth(_ value: Float) -> SceneOptionsState
    func selectTool(at index: Int) -> SceneOptionsState
}

extension SceneOptionsProcessing {
    func changeLineWidth(_ value: Float) -> SceneOptionsState {

        let lineWidth = CGFloat(value) * DrawingOptions.lineWidthRatio

        var state = self.state
        state.drawingOptions.graphicsOptions.lineWidth = lineWidth
        return state
    }

    func selectTool(at index: Int) -> SceneOptionsState {
        var state = self.state
        state.drawingOptions.selectedToolIndex = index
        return state
    }
}
