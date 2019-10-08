//
//  SceneRouting.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 03/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import UIKit

protocol SceneRouting {
    func showDrawingOptions()
}

extension SceneRouting where Self: UIViewController, Self: ScenePopoverSupport {
    func showDrawingOptions() {
        optionsController.popoverPresentationController?.barButtonItem = editItem
        present(optionsController, animated: true, completion: {})
    }
}
