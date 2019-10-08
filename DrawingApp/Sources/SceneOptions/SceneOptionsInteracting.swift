//
//  SceneOptionsInteracting.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 13/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

protocol SceneOptionsInteracting {
    func uiDidChangeSlider(_ value: Float)
    func uiDidSelectTool(_ index: Int)
}

extension SceneOptionsInteracting where Self: SceneOptionsStateDisplaying, Self: SceneOptionsProcessing {
    func uiDidChangeSlider(_ value: Float) {
        state = changeLineWidth(value)
    }

    func uiDidSelectTool(_ index: Int) {
        state = selectTool(at: index)
    }
}
