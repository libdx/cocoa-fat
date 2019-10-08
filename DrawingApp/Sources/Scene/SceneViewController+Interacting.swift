//
//  SceneViewController+Interacting.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

extension SceneViewController: SceneInteracting {}

extension SceneViewController {
    @IBAction @objc func editDidTap() {
        uiDidTapEdit()
    }
}

extension SceneViewController: SceneOptionsDelegate {
    func optionsDidChanges(_ controller: SceneOptionsViewController, options: DrawingOptions) {
        uiDidChangeOptions(options)
    }

    func didTapClearButton(_ controller: SceneOptionsViewController) {
        uiDidTapClear()
    }
}

extension SceneViewController: WhiteboardViewDelegate {
    func numberOfShapes(whiteboard: WhiteboardView) -> Int {
        return state.shapes.count
    }

    func shapeAt(whiteboard: WhiteboardView, index: Int) -> Shape {
        return state.shapes[index]
    }

    func didCreateShape(whiteboard: WhiteboardView, shape: Shape) {
        uiDidAddNewShape(shape)
        whiteboard.setNeedsDisplay()
    }
}
