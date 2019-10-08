//
//  MainViewController.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 01/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol ScenePopoverSupport {
    var editItem: UIBarButtonItem! { get }
    var optionsController: UIViewController! { get }
}

protocol SceneStateDisplaying: class {
    var state: SceneState { get set }
}

class SceneViewController: UIViewController, SceneStateDisplaying, ScenePopoverSupport {

    @IBOutlet var whiteboardView: WhiteboardView!
    @IBOutlet var editItem: UIBarButtonItem!
    var optionsController: UIViewController!

    var state = SceneState() {
        willSet {
            update(with: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let drawingController = SceneOptionsViewController()
        drawingController.delegate = self
        let navigationController = UINavigationController(rootViewController: drawingController)
        optionsController = navigationController
        optionsController.modalPresentationStyle = .popover
        whiteboardView.delegate = self
        editItem.target = self
        editItem.action = #selector(editDidTap)
    }
}

extension SceneViewController: UIToolbarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SceneViewController: SceneProcessing, SceneRouting {}
