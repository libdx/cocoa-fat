//
//  SceneOptionsViewController+Updating.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 13/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

extension SceneOptionsViewController: SceneOptionsStateUpdating {
    func update(with state: SceneOptionsState) {
        let drawingOptions = state.drawingOptions

        slider.value = drawingOptions.sliderValue
        segmentedControl.selectedSegmentIndex = drawingOptions.selectedToolIndex
    }
}
