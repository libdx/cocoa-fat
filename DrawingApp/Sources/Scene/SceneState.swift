//
//  Scene.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import Foundation

struct SceneState: Equatable {
    var shapes: [Shape] = []
    var drawingOptions = DrawingOptions()
}

func ==(_ lhs: SceneState, rhs: SceneState) -> Bool {
    return lhs.shapes == rhs.shapes &&
        lhs.drawingOptions == rhs.drawingOptions
}
