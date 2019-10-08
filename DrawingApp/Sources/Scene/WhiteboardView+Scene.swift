//
//  WhiteboardView+Scene.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 07/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

extension WhiteboardView.Options {
    init(_ drawingOptions: DrawingOptions) {
        backgroundColor = drawingOptions.backgroundColor
        drawingType = drawingOptions.selectedTool.drawingType
        graphicsOptions = drawingOptions.graphicsOptions
    }
}
