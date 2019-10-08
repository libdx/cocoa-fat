//
//  SceneViewController+Updating.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol SceneStateUpdating {
    func update(with state: SceneState)
}

extension SceneViewController: SceneStateUpdating {
    func update(with state: SceneState) {
        whiteboardView.options = WhiteboardView.Options(state.drawingOptions)
    }
}
