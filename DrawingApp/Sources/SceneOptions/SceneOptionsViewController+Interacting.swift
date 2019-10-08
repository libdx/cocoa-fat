//
//  SceneOptionsViewController+Interacting.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 13/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

extension SceneOptionsViewController: SceneOptionsInteracting {}

extension SceneOptionsViewController {
    @objc func sliderDidChange() {
        let value = slider.value
        uiDidChangeSlider(value)
        delegate?.optionsDidChanges(self, options: state.drawingOptions)
    }

    @objc func toolDidChange() {
        let index = segmentedControl.selectedSegmentIndex
        uiDidSelectTool(index)
        delegate?.optionsDidChanges(self, options: state.drawingOptions)
    }

    @objc func clearDidTap() {
        // TODO: show confirmation alert or inline confirmation prompt
        delegate?.didTapClearButton(self)
    }
}
