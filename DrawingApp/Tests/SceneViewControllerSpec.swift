//
//  SceneViewControllerSpec.swift
//  DrawingApp
//
//  Created by Oleksandr Ignatenko on 17/05/2019.
//  Copyright © 2019 Oleksandr Ignatenko. All rights reserved.
//

import XCTest
@testable import DrawingApp

class SceneViewControllerSpec: XCTestCase {

    var controller: SceneViewController!

    override func setUp() {
        let bundle = Bundle(for: SceneViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        controller = storyboard.instantiateInitialViewController() as? SceneViewController

        let _ = controller.view
    }

    override func tearDown() {
        controller = nil
    }

    func test_itPerformsInitialSetup() {
        XCTAssertEqual(controller.optionsController.modalPresentationStyle, .popover)
        // ...
    }

    func test_itPresentsOptions() {
        controller.editDidTap()
//        XCTAssertEqual(controller.presentedViewController, controller.optionsController)
    }

    func test_itUpdatesStateWhenTapsClearButton() {
        // given
        var state = SceneState(
            shapes: [Shape(), Shape(), Shape()],
            drawingOptions: DrawingOptions()
        )
        controller.state = state

        var clearedState = state
        clearedState.shapes = []

        // when
        controller.didTapClearButton(SceneOptionsViewController())

        // then
        XCTAssertEqual(controller.state, clearedState)
    }

    func test_itUpdatesWhiteboard() {
        // given
//        var state = SceneState()
//        state.drawingOptions

        // when
//        controller.state = state

        // then

    }
}
