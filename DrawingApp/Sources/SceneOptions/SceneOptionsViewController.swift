//
//  SceneOptionsViewController.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol SceneOptionsStateDisplaying: class {
    var state: SceneOptionsState { get set }
}

protocol SceneOptionsStateUpdating {
    func update(with: SceneOptionsState)
}

protocol SceneOptionsDelegate: class {
    func optionsDidChanges(_ controller: SceneOptionsViewController, options: DrawingOptions)
    func didTapClearButton(_ controller: SceneOptionsViewController)
}

class SceneOptionsViewController: UIViewController, SceneOptionsStateDisplaying {
    weak var delegate: SceneOptionsDelegate?

    @IBOutlet var slider: UISlider!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var clearButton: UIButton!

    var state = SceneOptionsState() {
        willSet {
            update(with: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupSlider()
        setupClearButton()

        state = SceneOptionsState()
    }

    private func setupClearButton() {
        clearButton.addTarget(self, action: #selector(clearDidTap), for: .touchUpInside)
    }

    private func setupSlider() {
        slider.addTarget(self, action: #selector(sliderDidChange), for: .valueChanged)
    }

    private func setupSegmentedControl() {
        for (index, tool) in DrawingOptions.allTools.enumerated() {
            segmentedControl.setTitle(tool.title, forSegmentAt: index)
        }
        segmentedControl.addTarget(self, action: #selector(toolDidChange), for: .valueChanged)
    }
}

extension SceneOptionsViewController: SceneOptionsProcessing {}
